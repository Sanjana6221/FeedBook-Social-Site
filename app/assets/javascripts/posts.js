$(document).ready(function(){

  $('#post_content').keyup(function(e){
    var txtVal = $(this).val();
    $('.user-post').val(txtVal);
  });
});
