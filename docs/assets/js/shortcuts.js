/* ===== SHORTCUTS.JS =====================================================
   Keyboard navigation shortcuts for the learning platform.
   ====================================================================== */

const Shortcuts = {
  init() {
    document.addEventListener('keydown', (e) => {
      const target = e.target;
      if (target.matches('input, textarea, [contenteditable]')) return;

      switch (e.key) {
        case '?':
          if (!e.metaKey && !e.ctrlKey) {
            e.preventDefault();
            this.showHelp();
          }
          break;
        case 'n':
          if (!e.metaKey && !e.ctrlKey) {
            const next = document.querySelector('.page-nav-link.next');
            if (next) { e.preventDefault(); next.click(); }
          }
          break;
        case 'p':
          if (!e.metaKey && !e.ctrlKey) {
            const prev = document.querySelector('.page-nav-link.prev');
            if (prev) { e.preventDefault(); prev.click(); }
          }
          break;
        case 't':
          if (!e.metaKey && !e.ctrlKey) {
            e.preventDefault();
            window.Theme?.toggle();
          }
          break;
      }
    });
  },

  showHelp() {
    const shortcuts = [
      { key: '?', desc: 'Show keyboard shortcuts' },
      { key: 'Ctrl+K', desc: 'Open search' },
      { key: 'n', desc: 'Next lesson' },
      { key: 'p', desc: 'Previous lesson' },
      { key: 't', desc: 'Toggle theme' },
      { key: 'Escape', desc: 'Close modals' },
    ];

    const modal = document.createElement('div');
    modal.style.cssText = `
      position: fixed; inset: 0; z-index: 1000;
      display: flex; align-items: center; justify-content: center;
      background: var(--clr-overlay);
    `;

    modal.innerHTML = `
      <div class="glass" style="max-width: 480px; width: 90%; padding: var(--space-6);">
        <h3 style="margin-top: 0; margin-bottom: var(--space-4); font-family: var(--ff-display); color: var(--clr-text);">Keyboard Shortcuts</h3>
        <div style="display: flex; flex-direction: column; gap: var(--space-3);">
          ${shortcuts.map(s => `
            <div style="display: flex; justify-content: space-between; align-items: center;">
              <span style="color: var(--clr-text-secondary); font-size: var(--fs-sm);">${s.desc}</span>
              <kbd>${s.key}</kbd>
            </div>
          `).join('')}
        </div>
        <button id="shortcuts-close" class="btn btn-primary" style="margin-top: var(--space-6); width: 100%;">Close</button>
      </div>
    `;

    document.body.appendChild(modal);

    const close = () => {
      modal.remove();
      document.removeEventListener('keydown', onKey);
    };

    const onKey = (e) => {
      if (e.key === 'Escape') close();
    };

    document.addEventListener('keydown', onKey);
    modal.querySelector('#shortcuts-close').addEventListener('click', close);
    modal.addEventListener('click', (e) => { if (e.target === modal) close(); });
  }
};

document.addEventListener('DOMContentLoaded', () => Shortcuts.init());
window.Shortcuts = Shortcuts;
