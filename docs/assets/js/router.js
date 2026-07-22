/* ===== ROUTER.JS ========================================================
   Client-side routing — handles SPA-like navigation for content pages.
   Loads markdown content and renders it into the article template.
   Only activates on pages that have the #app content container.
   ====================================================================== */

const Router = {
  app: null,
  contentIndex: null,

  async init() {
    this.app = document.getElementById('app');
    if (!this.app) return;

    await this.loadContentIndex();

    this.handleNavigation();

    document.addEventListener('click', (e) => {
      const link = e.target.closest('a[data-router]');
      if (link) {
        e.preventDefault();
        this.navigate(link.href);
      }
    });

    window.addEventListener('popstate', () => this.handleNavigation());
  },

  async loadContentIndex() {
    try {
      let res = await fetch('/git-github-practice/assets/data/content-index.json');
      this.contentIndex = await res.json();
    } catch {
      try {
        let res = await fetch('./assets/data/content-index.json');
        this.contentIndex = await res.json();
      } catch {
        this.contentIndex = { sections: [] };
      }
    }
  },

  async handleNavigation() {
    const path = window.location.pathname.replace('/git-github-practice', '').replace(/\/$/, '');
    const page = this.findPage(path);

    if (page) {
      await this.loadContent(page);
    }
  },

  findPage(path) {
    for (const section of this.contentIndex.sections || []) {
      for (const page of section.pages || []) {
        const pagePath = page.path.replace('.html', '');
        if (path === pagePath || path === page.path) {
          return { ...page, section: section.title };
        }
      }
    }
    return null;
  },

  async loadContent(page) {
    this.app.innerHTML = '<div class="skeleton" style="height: 200px; margin-bottom: 1rem;"></div>';

    const content = await this.fetchMarkdown(page.path);

    if (content) {
      const html = marked.parse(content);
      this.renderArticle(html, page);
      document.title = `${page.title} — Git & GitHub Learning Hub`;
      window.scrollTo(0, 0);
    } else {
      this.app.innerHTML = '<div class="empty-state"><h2>Content not found</h2><p>This page could not be loaded.</p></div>';
    }
  },

  async fetchMarkdown(path) {
    const mdPath = path.replace('.html', '.md');
    try {
      let res = await fetch(`/git-github-practice${mdPath}`);
      if (!res.ok) throw new Error('Not found');
      return await res.text();
    } catch {
      try {
        let res = await fetch(`.${mdPath}`);
        if (!res.ok) throw new Error('Not found');
        return await res.text();
      } catch {
        return null;
      }
    }
  },

  renderArticle(html, page) {
    this.app.innerHTML = `
      <div class="breadcrumbs">
        <a href="/git-github-practice/">Home</a>
        <span class="breadcrumbs-sep"></span>
        <a href="/git-github-practice/">${page.section || 'Guides'}</a>
        <span class="breadcrumbs-sep"></span>
        <span class="breadcrumbs-current">${page.title}</span>
      </div>

      <h1>${page.title}</h1>

      <div class="article-meta">
        <span class="article-meta-item">
          <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="10"/><polyline points="12 6 12 12 16 14"/></svg>
          ${page.readingTime || '15'} min read
        </span>
        ${page.difficulty ? `
          <span class="badge badge-${page.difficulty}">${page.difficulty}</span>
        ` : ''}
        ${page.updated ? `
          <span class="article-meta-item">
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="3" y="4" width="18" height="18" rx="2" ry="2"/><line x1="16" y1="2" x2="16" y2="6"/><line x1="8" y1="2" x2="8" y2="6"/><line x1="3" y1="10" x2="21" y2="10"/></svg>
            Updated ${page.updated}
          </span>
        ` : ''}
      </div>

      <div id="article-content" class="article-content">
        ${html}
      </div>
    `;

    Components.init();
    TOC.init();
  },

  navigate(url) {
    history.pushState(null, '', url);
    this.handleNavigation();
  }
};

document.addEventListener('DOMContentLoaded', () => Router.init());
window.Router = Router;
