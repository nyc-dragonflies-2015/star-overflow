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
//= require_tree .

// comments
$(document).ready(function() {
  $('.new_comment').on('submit', function(e) {
    e.preventDefault();
    var target = e.target

    $.ajax(e.currentTarget.action, {
      method: 'POST',
      data: $(this).serialize()
    })
    .done(function(data, e) {
      $(target).find('#comment_text').val("");
      $(target).parent().parent().find('.comments').append(data);
    })
    .fail(function() {
      alert('failed to post comment');
    });
  });
});
