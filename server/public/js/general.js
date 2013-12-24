$(".thumbnail").on('click', function(){  
  console.log('1');
  var video_id = $(this).data('url');
  $('#url').val(video_id);
  $('form#form-remote').submit();
})