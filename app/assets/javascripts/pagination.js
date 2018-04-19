jQuery(function() {
  if ($('.pagination').length) {
    $(window).on('scroll', function() {
      var more_posts_url;
      more_posts_url = $('.pagination .next_page a').attr('href');
      if (more_posts_url && $(window).scrollTop() > $(document).height() - $(window).height() - 60) {
        $('.pagination').html('<i class="fa-li fa fa-spinner fa-spin">');
        $.getScript(more_posts_url);
      }
    });
  }
});
