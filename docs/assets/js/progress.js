/* ===== PROGRESS.JS ======================================================
   Reading progress bar — fills from 0% to 100% as user scrolls.
   ====================================================================== */

const ProgressBar = {
  bar: null,

  init() {
    this.bar = document.getElementById('progress-bar-fill');
    if (!this.bar) return;
    window.addEventListener('scroll', this.onScroll.bind(this), { passive: true });
    this.onScroll();
  },

  onScroll() {
    const scrollTop = window.scrollY;
    const docHeight = document.documentElement.scrollHeight - window.innerHeight;
    if (docHeight <= 0) {
      this.bar.style.width = '0%';
      return;
    }
    const progress = Math.min((scrollTop / docHeight) * 100, 100);
    this.bar.style.width = progress + '%';
  }
};

document.addEventListener('DOMContentLoaded', () => ProgressBar.init());
window.ProgressBar = ProgressBar;
