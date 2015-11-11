$(function(){


  // ALIGN CENTER
  $('.dialog').each(function() {
    $(this).position({
      my: 'center center',
      at: 'center center',
      of: $(this).parent()
    });
  });

  $(window).resize(function() {
    $('.dialog').each(function() {
      $(this).position({
        my: 'center center',
        at: 'center center',
        of: $(this).parent()
      });
    });
  });

  // CURRENT YEAR
  $('.current').text( (new Date).getFullYear() );

 
});
