(function(){
  var c='Copyright © 2025 public-pool-btc.ru All rights reserved.';
  document.querySelectorAll('a[href="/ReferralLinks"]').forEach(function(a){
    var li=a.closest('li.nav-item');
    if(li)li.remove();
  });
  document.querySelectorAll('a[href="/SupportMe"]').forEach(function(a){
    var li=a.closest('li.nav-item');
    if(li)li.remove();
  });
  var f=document.querySelector('footer.main-footer');
  if(f){
    var s=f.querySelector('strong');
    if(s&&/Retro Mike|All rights reserved/i.test(s.textContent))s.textContent=c;
  }
  var run=function(){
    document.querySelectorAll('a[href="/ReferralLinks"]').forEach(function(a){var li=a.closest('li.nav-item');if(li)li.remove();});
    document.querySelectorAll('a[href="/SupportMe"]').forEach(function(a){var li=a.closest('li.nav-item');if(li)li.remove();});
    if(f&&s&&/Retro Mike|All rights/i.test(s.textContent))s.textContent=c;
  };
  if(document.readyState==='loading')document.addEventListener('DOMContentLoaded',run);
  else run();
  var obs=new MutationObserver(run);
  if(document.body)obs.observe(document.body,{childList:true,subtree:true});
  setTimeout(run,1500);
})();
