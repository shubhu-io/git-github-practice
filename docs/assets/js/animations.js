/* ===== ANIMATIONS.JS ====================================================
   Scroll-triggered animations using Intersection Observer.
   Adds .visible class to fade-up, stagger, and other animated elements.
   Respects prefers-reduced-motion.
   ====================================================================== */

const Animations = {
  observer: null,

  init() {
    if (this.prefersReducedMotion()) return;

    this.observer = new IntersectionObserver((entries) => {
      entries.forEach(entry => {
        if (entry.isIntersecting) {
          entry.target.classList.add('visible');
          this.observer.unobserve(entry.target);
        }
      });
    }, {
      threshold: 0.1,
      rootMargin: '0px 0px -40px 0px'
    });

    document.querySelectorAll('.fade-up, .fade-in').forEach(el => {
      this.observer.observe(el);
    });

    document.querySelectorAll('.stagger-children').forEach(el => {
      this.observer.observe(el);
    });
  },

  prefersReducedMotion() {
    return window.matchMedia('(prefers-reduced-motion: reduce)').matches;
  }
};

document.addEventListener('DOMContentLoaded', () => Animations.init());
window.Animations = Animations;
