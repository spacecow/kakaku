// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

//function confirm_destroy(element, action) {
//  if (confirm("Are you sure?")) {
//    var f = document.createElement('form');
//    f.style.display = 'none';
//    element.parentNode.appendChild(f);
//    f.method = 'POST';
//    f.action = action;
//    var m = document.createElement('input');
//    m.setAttribute('type', 'hidden');
//    m.setAttribute('name', '_method');
//    m.setAttribute('value', 'delete');
//    f.appendChild(m);
//    f.submit();
//  }
//  return false;
//}

$(document).ready(function() {
       // focus on the first text input field in the first field on the page
  $("input[type='text']:first", document.forms[0]).focus();
});