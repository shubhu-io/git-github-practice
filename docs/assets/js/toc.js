/* ===== TOC.JS ============================================================
   Table of Contents generator + scroll spy.
   Reads h2/h3 from article.content, builds outline, highlights active.
   ====================================================================== */

const TOC = {
  observer: null,

  init() {
    const container = document.getElementById('toc');
    if (!container) return;
    const content = document.getElementById('article-content');
    if (!content) return;

    const headings = content.querySelectorAll('h2, h3');
    if (headings.length < 2) {
      container.style.display = 'none';
      return;
    }

    this.build(headings, container);
    this.setupScrollSpy(headings);
  },

  build(headings, container) {
    const items = [];
    let h3Parent = null;

    headings.forEach(h => {
      if (!h.id) {
        h.id = h.textContent.toLowerCase().replace(/[^a-z0-9]+/g, '-').replace(/(^-|-$)/g, '');
      }
      if (h.tagName === 'H2') {
        h3Parent = { id: h.id, text: h.textContent, children: [] };
        items.push(h3Parent);
      } else if (h.tagName === 'H3' && h3Parent) {
        h3Parent.children.push({ id: h.id, text: h.textContent });
      }
    });

    container.innerHTML = `
      <div class="toc-title">On This Page</div>
      <ul class="toc-list">
        ${items.map(item => `
          <li class="toc-item" data-target="${item.id}">
            <a href="#${item.id}">${item.text}</a>
            ${item.children.length ? `<ul class="toc-list">${item.children.map(c => `
              <li class="toc-item toc-item-h3" data-target="${c.id}">
                <a href="#${c.id}">${c.text}</a>
              </li>
            `).join('')}</ul>` : ''}
          </li>
        `).join('')}
      </ul>
    `;

    container.querySelectorAll('.toc-item a').forEach(link => {
      link.addEventListener('click', (e) => {
        e.preventDefault();
        const target = document.getElementById(link.getAttribute('href').slice(1));
        if (target) {
          target.scrollIntoView({ behavior: 'smooth', block: 'start' });
          history.pushState(null, '', link.getAttribute('href'));
        }
      });
    });
  },

  setupScrollSpy(headings) {
    if (this.observer) this.observer.disconnect();

    const items = document.querySelectorAll('.toc-item');

    this.observer = new IntersectionObserver((entries) => {
      entries.forEach(entry => {
        if (entry.isIntersecting) {
          const id = entry.target.id;
          items.forEach(item => {
            item.classList.toggle('active', item.dataset.target === id);
          });
        }
      });
    }, { rootMargin: '-80px 0px -60% 0px', threshold: 0 });

    headings.forEach(h => this.observer.observe(h));
  }
};

window.TOC = TOC;
