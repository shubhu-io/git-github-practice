/* ===== THEME.JS =========================================================
   Theme management — 6 themes + auto (system preference).
   Persists choice in localStorage. Applies early to avoid flash.
   ====================================================================== */

const THEMES = ['dark', 'light', 'night', 'sepia', 'forest', 'ocean'];
const STORAGE_KEY = 'gh-learning-theme';
const AUTO_KEY = 'gh-learning-theme-auto';

const Theme = {
  init() {
    const saved = localStorage.getItem(STORAGE_KEY);
    const autoPref = localStorage.getItem(AUTO_KEY);

    if (autoPref === 'true') {
      this.setAuto();
    } else if (saved && THEMES.includes(saved)) {
      this.set(saved);
    } else {
      this.setAuto();
    }

    this.renderPicker();
  },

  getCurrent() {
    return document.documentElement.getAttribute('data-theme') || 'dark';
  },

  set(theme) {
    document.documentElement.setAttribute('data-theme', theme);
    localStorage.setItem(STORAGE_KEY, theme);
    localStorage.removeItem(AUTO_KEY);
    this.updateMetaThemeColor(theme);
    this.updateActiveButton(theme);
    document.dispatchEvent(new CustomEvent('themechange', { detail: { theme } }));
  },

  setAuto() {
    const prefersDark = window.matchMedia('(prefers-color-scheme: dark)').matches;
    const theme = prefersDark ? 'dark' : 'light';
    document.documentElement.setAttribute('data-theme', theme);
    localStorage.setItem(AUTO_KEY, 'true');
    this.updateMetaThemeColor(theme);
    this.updateActiveButton('auto');
    document.dispatchEvent(new CustomEvent('themechange', { detail: { theme, auto: true } }));
  },

  isAuto() {
    return localStorage.getItem(AUTO_KEY) === 'true';
  },

  toggle() {
    const current = this.getCurrent();
    if (current === 'dark') this.set('light');
    else if (current === 'light') this.set('dark');
    else this.set('dark');
  },

  updateMetaThemeColor(theme) {
    let meta = document.querySelector('meta[name="theme-color"]');
    if (!meta) {
      meta = document.createElement('meta');
      meta.name = 'theme-color';
      document.head.appendChild(meta);
    }
    const colors = {
      dark: '#0D1117', light: '#FFFFFF', night: '#0A0A0A',
      sepia: '#F4ECD8', forest: '#1A2E1A', ocean: '#0A1628'
    };
    meta.content = colors[theme] || '#0D1117';
  },

  updateActiveButton(theme) {
    document.querySelectorAll('.theme-btn').forEach(btn => {
      const val = btn.dataset.theme;
      btn.classList.toggle('active', val === theme);
      btn.setAttribute('aria-pressed', val === theme ? 'true' : 'false');
    });
  },

  renderPicker() {
    const container = document.getElementById('theme-picker');
    if (!container) return;

    const current = this.isAuto() ? 'auto' : this.getCurrent();
    const themes = [
      { id: 'auto', label: 'Auto', icon: '🖥️' },
      { id: 'dark', label: 'Dark', icon: '🌙' },
      { id: 'light', label: 'Light', icon: '☀️' },
      { id: 'night', label: 'Night', icon: '🌌' },
      { id: 'sepia', label: 'Sepia', icon: '📜' },
      { id: 'forest', label: 'Forest', icon: '🌲' },
      { id: 'ocean', label: 'Ocean', icon: '🌊' },
    ];

    container.innerHTML = themes.map(t => `
      <button class="theme-btn ${t.id === current ? 'active' : ''}"
              data-theme="${t.id}"
              aria-label="${t.label} theme"
              aria-pressed="${t.id === current ? 'true' : 'false'}"
              title="${t.label}">
        <span class="theme-btn-icon">${t.icon}</span>
        <span class="theme-btn-label">${t.label}</span>
      </button>
    `).join('');

    container.querySelectorAll('.theme-btn').forEach(btn => {
      btn.addEventListener('click', () => {
        if (btn.dataset.theme === 'auto') this.setAuto();
        else this.set(btn.dataset.theme);
        this.closePicker();
      });
    });
  },

  openPicker() {
    const panel = document.getElementById('theme-panel');
    if (panel) {
      panel.classList.add('open');
      this.renderPicker();
    }
  },

  closePicker() {
    const panel = document.getElementById('theme-panel');
    if (panel) panel.classList.remove('open');
  },

  togglePicker() {
    const panel = document.getElementById('theme-panel');
    if (panel) {
      panel.classList.contains('open') ? this.closePicker() : this.openPicker();
    }
  }
};

document.addEventListener('DOMContentLoaded', () => Theme.init());
window.matchMedia('(prefers-color-scheme: dark)').addEventListener('change', () => {
  if (Theme.isAuto()) Theme.setAuto();
});

window.Theme = Theme;
