/* ===== MAIN.JS ==========================================================
   Entry point — initializes all modules.
   Includes Prism.js and marked.js from CDN.
   ====================================================================== */

(function() {
  'use strict';

  function loadCDN(url, callback) {
    const script = document.createElement('script');
    script.src = url;
    script.onload = callback;
    document.head.appendChild(script);
  }

  function init() {
    document.documentElement.classList.add('js-loaded');

    if (window.Theme) Theme.init();
    if (window.Sidebar) Sidebar.init();
    if (window.ProgressBar) ProgressBar.init();
    if (window.Components) Components.init();
    if (window.TOC) TOC.init();
    if (window.Search) Search.init();
    if (window.Router) Router.init();
    if (window.Animations) Animations.init();
    if (window.Shortcuts) Shortcuts.init();
  }

  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', init);
  } else {
    init();
  }
})();
