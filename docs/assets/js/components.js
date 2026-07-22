/* ===== COMPONENTS.JS ====================================================
   Interactive component handlers: copy buttons, quiz, accordion, tabs,
   stat counters, smooth scroll, back-to-top.
   ====================================================================== */

const Components = {
  init() {
    this.initCopyButtons();
    this.initAccordions();
    this.initTabs();
    this.initQuizzes();
    this.initStatCounters();
    this.initBackToTop();
    this.initSmoothScroll();
    this.initAnchorLinks();
  },

  /* --- Copy Buttons --------------------------------------------------- */
  initCopyButtons() {
    document.querySelectorAll('.copy-btn').forEach(btn => {
      if (btn.dataset.initialized) return;
      btn.dataset.initialized = 'true';

      btn.addEventListener('click', () => {
        const codeBlock = btn.closest('.code-block');
        const code = codeBlock?.querySelector('code')?.textContent ||
                     codeBlock?.querySelector('pre')?.textContent || '';
        this.copyText(code.trim(), btn);
      });
    });
  },

  copyText(text, btn) {
    const origText = btn.innerHTML;
    btn.classList.add('copied');
    btn.innerHTML = '<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><polyline points="20 6 9 17 4 12"></polyline></svg> Copied!';

    if (navigator.clipboard && navigator.clipboard.writeText) {
      navigator.clipboard.writeText(text).catch(() => this.fallbackCopy(text));
    } else {
      this.fallbackCopy(text);
    }

    setTimeout(() => {
      btn.classList.remove('copied');
      btn.innerHTML = origText;
    }, 2000);
  },

  fallbackCopy(text) {
    const ta = document.createElement('textarea');
    ta.value = text;
    ta.style.position = 'fixed';
    ta.style.left = '-9999px';
    document.body.appendChild(ta);
    ta.select();
    document.execCommand('copy');
    document.body.removeChild(ta);
  },

  /* --- Accordion ------------------------------------------------------ */
  initAccordions() {
    document.querySelectorAll('.accordion').forEach(accordion => {
      accordion.querySelectorAll('.accordion-header').forEach(header => {
        if (header.dataset.initialized) return;
        header.dataset.initialized = 'true';

        header.addEventListener('click', () => {
          const item = header.closest('.accordion-item');
          const isOpen = item.classList.contains('open');

          accordion.querySelectorAll('.accordion-item.open').forEach(i => {
            i.classList.remove('open');
          });

          if (!isOpen) item.classList.add('open');
        });
      });
    });
  },

  /* --- Tabs ------------------------------------------------------------ */
  initTabs() {
    document.querySelectorAll('.tabs').forEach(tabs => {
      const nav = tabs.querySelector('.tab-nav');
      if (!nav) return;

      nav.querySelectorAll('.tab-btn').forEach(btn => {
        if (btn.dataset.initialized) return;
        btn.dataset.initialized = 'true';

        btn.addEventListener('click', () => {
          const target = btn.dataset.tab;
          nav.querySelectorAll('.tab-btn').forEach(b => b.classList.remove('active'));
          btn.classList.add('active');

          tabs.querySelectorAll('.tab-panel').forEach(p => {
            p.classList.toggle('active', p.id === target);
          });
        });
      });
    });
  },

  /* --- Quiz ------------------------------------------------------------ */
  initQuizzes() {
    document.querySelectorAll('.quiz').forEach(quiz => {
      const options = quiz.querySelectorAll('.quiz-option');
      const feedback = quiz.querySelector('.quiz-feedback');
      let answered = false;

      options.forEach(opt => {
        if (opt.dataset.initialized) return;
        opt.dataset.initialized = 'true';

        opt.addEventListener('click', () => {
          if (answered) return;
          answered = true;

          const isCorrect = opt.dataset.correct === 'true';

          options.forEach(o => {
            o.classList.remove('selected', 'correct', 'incorrect');
            if (o.dataset.correct === 'true') o.classList.add('correct');
          });

          opt.classList.add(isCorrect ? 'correct' : 'incorrect');
          if (!isCorrect) opt.classList.add('selected');

          if (feedback) {
            feedback.textContent = isCorrect
              ? '✓ Correct! Well done.'
              : '✗ Not quite. Review the section above and try again.';
            feedback.className = `quiz-feedback show ${isCorrect ? 'correct' : 'incorrect'}`;
          }
        });
      });
    });
  },

  /* --- Stat Counters --------------------------------------------------- */
  initStatCounters() {
    const counters = document.querySelectorAll('.stat-value[data-count]');

    if (!counters.length) return;

    const observer = new IntersectionObserver((entries) => {
      entries.forEach(entry => {
        if (entry.isIntersecting) {
          const el = entry.target;
          const target = parseInt(el.dataset.count, 10);
          this.animateCounter(el, target);
          observer.unobserve(el);
        }
      });
    }, { threshold: 0.5 });

    counters.forEach(c => observer.observe(c));
  },

  animateCounter(el, target) {
    const duration = 1500;
    const step = Math.max(1, Math.floor(target / 60));
    let current = 0;

    const update = () => {
      current += step;
      if (current >= target) {
        el.textContent = target + (el.dataset.suffix || '');
        el.classList.add('animated');
        return;
      }
      el.textContent = current + (el.dataset.suffix || '');
      requestAnimationFrame(update);
    };

    update();
  },

  /* --- Back to Top ----------------------------------------------------- */
  initBackToTop() {
    const btn = document.getElementById('back-to-top');
    if (!btn) return;

    window.addEventListener('scroll', () => {
      btn.classList.toggle('visible', window.scrollY > 300);
    }, { passive: true });

    btn.addEventListener('click', () => {
      window.scrollTo({ top: 0, behavior: 'smooth' });
    });
  },

  /* --- Smooth Scroll for anchor links --------------------------------- */
  initSmoothScroll() {
    document.addEventListener('click', (e) => {
      const link = e.target.closest('a[href^="#"]');
      if (!link) return;

      const target = document.getElementById(link.getAttribute('href').slice(1));
      if (target) {
        e.preventDefault();
        target.scrollIntoView({ behavior: 'smooth', block: 'start' });
      }
    });
  },

  /* --- Anchor link generation ----------------------------------------- */
  initAnchorLinks() {
    document.querySelectorAll('#article-content h2, #article-content h3').forEach(h => {
      if (!h.id) {
        h.id = h.textContent.toLowerCase().replace(/[^a-z0-9]+/g, '-').replace(/(^-|-$)/g, '');
      }

      if (!h.querySelector('.anchor-link')) {
        const anchor = document.createElement('a');
        anchor.className = 'anchor-link';
        anchor.href = `#${h.id}`;
        anchor.setAttribute('aria-label', `Link to ${h.textContent}`);
        anchor.innerHTML = '<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" width="16" height="16"><path d="M10 13a5 5 0 0 0 7.54.54l3-3a5 5 0 0 0-7.07-7.07l-1.72 1.71"/><path d="M14 11a5 5 0 0 0-7.54-.54l-3 3a5 5 0 0 0 7.07 7.07l1.71-1.71"/></svg>';
        h.style.position = 'relative';
        h.appendChild(anchor);
      }
    });
  }
};

document.addEventListener('DOMContentLoaded', () => Components.init());
window.Components = Components;
