// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults


// Hacer que el flash desaparezca en 5 segundos
document.observe("dom:loaded", function() {
  var flash = $$('.flash');
  flash.each( function(element) {
    new Effect.Fade(element, { duration: 5.0 });
  });
});


