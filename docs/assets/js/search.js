/* ===== SEARCH.JS ========================================================
   Client-side full-text search across content-index.
   Fuzzy matching, keyboard shortcut (Ctrl+K / Cmd+K), result overlay.
   ====================================================================== */

const Search = {
  data: null,
  input: null,
  overlay: null,
  results: null,
  allPages: [],

  async init() {
    this.input = document.getElementById('search-input');
    this.overlay = document.getElementById('search-overlay');
    this.results = document.getElementById('search-results');

    if (!this.input) return;

    await this.loadIndex();
    this.bindEvents();
  },

  async loadIndex() {
    try {
      let res = await fetch('/git-github-practice/assets/data/content-index.json');
      this.data = await res.json();
    } catch {
      try {
        let res = await fetch('./assets/data/content-index.json');
        this.data = await res.json();
      } catch {
        this.data = { sections: [] };
      }
    }

    this.allPages = [];
    this.data.sections.forEach(section => {
      (section.pages || []).forEach(page => {
        this.allPages.push({
          ...page,
          section: section.title,
          sectionIcon: section.icon
        });
      });
    });
  },

  bindEvents() {
    this.input.addEventListener('input', this.debounce(() => {
      const query = this.input.value.trim();
      query ? this.search(query) : this.clear();
    }, 300));

    this.input.addEventListener('focus', () => {
      if (this.input.value.trim()) this.search(this.input.value.trim());
    });

    document.addEventListener('keydown', (e) => {
      if ((e.metaKey || e.ctrlKey) && e.key === 'k') {
        e.preventDefault();
        this.input.focus();
        this.open();
      }
      if (e.key === 'Escape') {
        this.close();
        this.input.blur();
      }
    });

    this.overlay?.addEventListener('click', (e) => {
      if (e.target === this.overlay) this.close();
    });
  },

  search(query) {
    if (!this.allPages.length) return;
    const q = query.toLowerCase();

    const matches = this.allPages.filter(page => {
      const title = (page.title || '').toLowerCase();
      const desc = (page.description || '').toLowerCase();
      const tags = (page.tags || []).join(' ').toLowerCase();
      const section = (page.section || '').toLowerCase();
      return title.includes(q) || desc.includes(q) || tags.includes(q) || section.includes(q);
    });

    this.renderResults(matches, query);
    this.open();
  },

  renderResults(matches, query) {
    if (!this.results) return;

    if (!matches.length) {
      this.results.innerHTML = `
        <div class="empty-state" style="padding: var(--space-8) var(--space-4);">
          <div class="empty-state-icon">
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
              <circle cx="11" cy="11" r="8"/><line x1="21" y1="21" x2="16.65" y2="16.65"/>
            </svg>
          </div>
          <div class="empty-state-title">No results found</div>
          <div class="empty-state-text">Try a different search term</div>
        </div>
      `;
      return;
    }

    this.results.innerHTML = matches.map(page => `
      <a class="search-result-item" href="${page.path}" onclick="Search.close()">
        <div class="search-result-icon">
          <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
            <path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"/>
            <polyline points="14 2 14 8 20 8"/>
          </svg>
        </div>
        <div class="search-result-content">
          <div class="search-result-title">${this.highlight(page.title, query)}</div>
          <div class="search-result-desc">${this.highlight(page.description || '', query)}</div>
          <div class="search-result-meta">
            <span class="badge badge-info">${page.section || ''}</span>
            ${page.difficulty ? `<span class="badge badge-${page.difficulty}">${page.difficulty}</span>` : ''}
          </div>
        </div>
      </a>
    `).join('');
  },

  highlight(text, query) {
    if (!text || !query) return text || '';
    const regex = new RegExp(`(${query.replace(/[.*+?^${}()|[\]\\]/g, '\\$&')})`, 'gi');
    return text.replace(regex, '<mark>$1</mark>');
  },

  open() {
    this.overlay?.classList.add('open');
    document.body.style.overflow = 'hidden';
  },

  close() {
    this.overlay?.classList.remove('open');
    document.body.style.overflow = '';
    this.clear();
  },

  clear() {
    if (this.results) this.results.innerHTML = '';
  },

  debounce(fn, delay) {
    let timer;
    return (...args) => {
      clearTimeout(timer);
      timer = setTimeout(() => fn.apply(this, args), delay);
    };
  }
};

document.addEventListener('DOMContentLoaded', () => Search.init());
window.Search = Search;
