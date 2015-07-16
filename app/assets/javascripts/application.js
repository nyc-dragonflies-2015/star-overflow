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
/* Not where JS code goes.  Remember, this is a MANIFEST */

$(document).ready(function() {
  $(document).on('submit', '.new_comment', function(e) {
    e.preventDefault();
    var target = e.target

    $.ajax(target.action, {
      method: 'POST',
      data: $(this).serialize()
    })
    .done(function(data) {
      $(target).find('#comment_text').val("");
      // There's parents() which can look "up" to a matching selector i.e.
      // '.comments'.  This parent() parent() should set off your "hacky code
      // o-meter"
      $(target).parent().parent().find('.comments').append(data);
    })
    .fail(function() {
      alert('failed to post comment');
    });
  });

  $(document).on('submit', '.edit_comment', function(e) {
    e.preventDefault();
    var target = e.target;

    $.ajax(target.action, {
      method: 'DELETE',
      data: $(this).serialize()
    })
    .done(function(data) {
      // Try not to commit debug data
      console.log(target)
      $(target).parent().remove();
    })
    .fail(function() {
      alert('failed to delete comment');
    });
  });
});
