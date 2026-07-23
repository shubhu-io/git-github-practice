/* ===== SIDEBAR.JS =======================================================
   Collapsible sidebar with section memory (localStorage),
   current page highlighting, mobile drawer support.
   ====================================================================== */

const Sidebar = {
  data: null,
  state: {},
  base: '',

  async init() {
    this.base = window.location.pathname.replace(/\/[^/]*$/, '');
    this.state = this.loadState();
    await this.loadContentIndex();
    this.render();
    this.bindEvents();
    this.highlightCurrent();
    this.restoreScrollPosition();
  },

  async loadContentIndex() {
    try {
      const res = await fetch(this.base + '/assets/data/content-index.json');
      this.data = await res.json();
    } catch {
      try {
        const res = await fetch('./assets/data/content-index.json');
        this.data = await res.json();
      } catch {
        this.data = { sections: [] };
      }
    }
  },

  render() {
    const container = document.getElementById('sidebar');
    if (!container || !this.data) return;

    const currentPath = window.location.pathname;

    container.innerHTML = `
      <div class="sidebar-inner">
        ${this.data.sections.map(section => {
          const sectionId = this.sectionId(section.title);
          const isOpen = this.state[sectionId] !== false;
          const active = section.pages?.some(p => currentPath.endsWith(p.path));
          return `
            <div class="sidebar-section ${active ? 'section-active' : ''}">
              <button class="sidebar-header ${isOpen ? '' : 'collapsed'}"
                      data-section="${sectionId}"
                      aria-expanded="${isOpen}">
                <span class="sidebar-header-icon">
                  ${section.icon ? this.iconFor(section.icon) : ''}
                  ${section.title}
                </span>
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                  <polyline points="6 9 12 15 18 9"></polyline>
                </svg>
              </button>
              <div class="sidebar-items ${isOpen ? '' : 'collapsed'}">
                ${section.pages ? section.pages.map(page => {
                  const isActive = currentPath.endsWith(page.path);
                  return `
                    <a class="sidebar-item ${isActive ? 'active' : ''}"
                       href="${this.base}${page.path}"
                       data-page="${page.id || ''}">
                      ${page.icon ? this.iconFor(page.icon) : '<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"></path><polyline points="14 2 14 8 20 8"></polyline></svg>'}
                      ${page.title}
                    </a>
                  `;
                }).join('') : ''}
              </div>
            </div>
          `;
        }).join('')}
      </div>
    `;
  },

  bindEvents() {
    const container = document.getElementById('sidebar');

    container?.addEventListener('click', (e) => {
      const header = e.target.closest('.sidebar-header');
      if (header) {
        const sectionId = header.dataset.section;
        const items = header.nextElementSibling;
        const isOpen = header.classList.toggle('collapsed');
        items.classList.toggle('collapsed');
        header.setAttribute('aria-expanded', !isOpen);
        this.state[sectionId] = !isOpen;
        this.saveState();
      }
    });

    const hamburger = document.getElementById('sidebar-toggle-mobile');
    const overlay = document.getElementById('sidebar-overlay');

    hamburger?.addEventListener('click', () => this.toggleMobile());
    overlay?.addEventListener('click', () => this.closeMobile());

    document.addEventListener('keydown', (e) => {
      if (e.key === 'b' && (e.metaKey || e.ctrlKey)) {
        e.preventDefault();
        this.toggleMobile();
      }
    });
  },

  highlightCurrent() {
    const currentPath = window.location.pathname;
    document.querySelectorAll('.sidebar-item').forEach(item => {
      item.classList.toggle('active', currentPath.endsWith(item.getAttribute('href')));
    });
  },

  toggleMobile() {
    const sidebar = document.getElementById('sidebar');
    const overlay = document.getElementById('sidebar-overlay');
    if (!sidebar) return;
    const isOpen = sidebar.classList.toggle('open');
    overlay?.classList.toggle('open', isOpen);
    document.body.style.overflow = isOpen ? 'hidden' : '';
  },

  closeMobile() {
    document.getElementById('sidebar')?.classList.remove('open');
    document.getElementById('sidebar-overlay')?.classList.remove('open');
    document.body.style.overflow = '';
  },

  sectionId(title) {
    return 'sidebar-' + title.toLowerCase().replace(/[^a-z0-9]+/g, '-').replace(/(^-|-$)/g, '');
  },

  loadState() {
    try {
      return JSON.parse(localStorage.getItem('gh-learning-sidebar') || '{}');
    } catch { return {}; }
  },

  saveState() {
    localStorage.setItem('gh-learning-sidebar', JSON.stringify(this.state));
  },

  restoreScrollPosition() {
    const sidebar = document.getElementById('sidebar');
    if (!sidebar) return;
    const active = sidebar.querySelector('.sidebar-item.active');
    if (active) {
      active.scrollIntoView({ block: 'center', behavior: 'auto' });
    }
  },

  iconFor(name) {
    const icons = {
      'rocket': '<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M12 15l-2 5 2 1 2-1-2-5z"/><path d="M12 8c-1.5 0-3 .5-4 2 0 0 2 1 4 1s4-1 4-1c-1-1.5-2.5-2-4-2z"/><path d="M8 5c0 0 1-1 4-1s4 1 4 1l-1 3c0 0-1 1-3 1s-3-1-3-1L8 5z"/></svg>',
      'book': '<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M4 19.5A2.5 2.5 0 0 1 6.5 17H20"/><path d="M6.5 2H20v20H6.5A2.5 2.5 0 0 1 4 19.5v-15A2.5 2.5 0 0 1 6.5 2z"/></svg>',
      'map': '<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><polygon points="1 6 1 22 8 18 16 22 23 18 23 2 16 6 8 2 1 6"/><line x1="8" y1="2" x2="8" y2="18"/><line x1="16" y1="6" x2="16" y2="22"/></svg>',
      'compass': '<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="10"/><polygon points="16.24 7.76 14.12 14.12 7.76 16.24 9.88 9.88 16.24 7.76"/></svg>',
      'github': '<svg viewBox="0 0 24 24" fill="currentColor"><path d="M12 0c-6.626 0-12 5.373-12 12 0 5.302 3.438 9.8 8.207 11.387.599.111.793-.261.793-.577v-2.234c-3.338.726-4.033-1.416-4.033-1.416-.546-1.387-1.333-1.756-1.333-1.756-1.089-.745.083-.729.083-.729 1.205.084 1.839 1.237 1.839 1.237 1.07 1.834 2.807 1.304 3.492.997.107-.775.418-1.305.762-1.604-2.665-.305-5.467-1.334-5.467-5.931 0-1.311.469-2.381 1.236-3.221-.124-.303-.535-1.524.117-3.176 0 0 1.008-.322 3.301 1.23.957-.266 1.983-.399 3.003-.404 1.02.005 2.047.138 3.006.404 2.291-1.552 3.297-1.23 3.297-1.23.653 1.653.242 2.874.118 3.176.77.84 1.235 1.911 1.235 3.221 0 4.609-2.807 5.624-5.479 5.921.43.372.823 1.102.823 2.222v3.293c0 .319.192.694.801.576 4.765-1.589 8.199-6.086 8.199-11.386 0-6.627-5.373-12-12-12z"/></svg>',
      'cpu': '<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="4" y="4" width="16" height="16" rx="2" ry="2"/><rect x="9" y="9" width="6" height="6"/><line x1="9" y1="1" x2="9" y2="4"/><line x1="15" y1="1" x2="15" y2="4"/><line x1="9" y1="20" x2="9" y2="23"/><line x1="15" y1="20" x2="15" y2="23"/><line x1="20" y1="9" x2="23" y2="9"/><line x1="20" y1="14" x2="23" y2="14"/><line x1="1" y1="9" x2="4" y2="9"/><line x1="1" y1="14" x2="4" y2="14"/></svg>',
      'layers': '<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><polygon points="12 2 2 7 12 12 22 7 12 2"/><polyline points="2 17 12 22 22 17"/><polyline points="2 12 12 17 22 12"/></svg>',
      'terminal': '<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><polyline points="4 17 10 11 4 5"/><line x1="12" y1="19" x2="20" y2="19"/></svg>',
      'list': '<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><line x1="8" y1="6" x2="21" y2="6"/><line x1="8" y1="12" x2="21" y2="12"/><line x1="8" y1="18" x2="21" y2="18"/><line x1="3" y1="6" x2="3.01" y2="6"/><line x1="3" y1="12" x2="3.01" y2="12"/><line x1="3" y1="18" x2="3.01" y2="18"/></svg>',
    };
    return icons[name] || icons['book'];
  }
};

window.Sidebar = Sidebar;
