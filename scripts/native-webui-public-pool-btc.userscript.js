// ==UserScript==
// @name         MiningCore Web UI — public-pool-btc.ru (убрать Referral/Support, свой копирайт)
// @namespace    https://github.com/Sert1985n/umbrel-pool-app-store
// @version      1.0
// @description  Удаляет пункты Referral Links и Support Me; заменяет копирайт на public-pool-btc.ru All rights reserved.
// @author       public-pool-btc.ru
// @match        *://umbrel.local/*
// @match        *://localhost/*
// @match        *://127.0.0.1/*
// @match        *://*.local/*
// @match        *://192.168.*/*
// @grant        none
// @run-at       document-idle
// ==/UserScript==

(function () {
  'use strict';

  const NEW_COPYRIGHT = 'Copyright © 2025 public-pool-btc.ru All rights reserved.';

  function isMiningCoreWebUI() {
    return document.querySelector('a[href="/ReferralLinks"]') ||
           (document.querySelector('footer.main-footer') && /Retro Mike|Mining Pool/i.test(document.body.innerText));
  }

  function hideReferralAndSupport() {
    document.querySelectorAll('a[href="/ReferralLinks"]').forEach(function (a) {
      var li = a.closest('li.nav-item');
      if (li) li.remove();
    });
    document.querySelectorAll('a[href="/SupportMe"]').forEach(function (a) {
      var li = a.closest('li.nav-item');
      if (li) li.remove();
    });
  }

  function replaceFooter() {
    var footer = document.querySelector('footer.main-footer');
    if (!footer) return;
    var strong = footer.querySelector('strong');
    if (strong && /Retro Mike|All rights reserved/i.test(strong.textContent)) {
      strong.textContent = NEW_COPYRIGHT;
    }
    footer.querySelectorAll('*').forEach(function (el) {
      if (el.childNodes.length === 1 && el.firstChild && el.firstChild.nodeType === 3) {
        var t = el.firstChild.textContent || '';
        if (/Retro Mike Tech|All rights reserved/i.test(t)) {
          el.textContent = el.tagName === 'STRONG' ? NEW_COPYRIGHT : '';
        }
      }
    });
  }

  function run() {
    if (!document.body || !isMiningCoreWebUI()) return;
    hideReferralAndSupport();
    replaceFooter();
  }

  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', run);
  } else {
    run();
  }
  var observer = new MutationObserver(function () { run(); });
  if (document.body) observer.observe(document.body, { childList: true, subtree: true });
  setTimeout(run, 1500);
})();
