/**
	Include here, tracking scripts, such as Google Analytics
*/
// brute-force test for including tracking (on each page)
// alert("Tracking script - " + window.global_test);
console.info("Tracking script - " + window.global_test);

/**
  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

  ga('create', 'xx', 'auto');
  ga('send', 'pageview');
*/