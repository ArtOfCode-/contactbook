// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require datatables.js
//= require_tree .

$(document).on('ready page:load', function() {
  $("table").each(function() {
    $(this).DataTable();

    var parentWidth = $(this).parent().width();
    $(this).width(parentWidth);
    $(this).css("overflow", "scroll");

    var cols = $(this).find("tr").first().find("tr, th").length;
    var colWidth = parentWidth / cols;
    $(this).find("th, td").each(function() {
      $(this).width(colWidth);
    });
  });
});
