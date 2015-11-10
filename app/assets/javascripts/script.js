// JavaScript Document
$(document).ready(function(){

    /* alignments */
    $('.midst').each(function() {
      $(this).position({
        my: 'center center',
        at: 'center center',
        of: $(this).parent()
      });
    });

    $(window).resize(function() {
      $('.midst').each(function() {
        $(this).position({
          my: 'center center',
          at: 'center center',
          of: $(this).parent()
        });
      });
    });

    /* page scroll */ 
    $('a.icon-scroll').bind('click', function(event) {
      var $anchor = $(this);
      $('html, body').stop().animate({
          scrollTop: $($anchor.attr('href')).offset().top - 80
      }, 1000, 'easeInOutExpo');
      event.preventDefault();
    });

   /* slick */
    $('.testimonials').slick({
      infinite: true,
      dots: false,
      arrows: true,
      slidesToShow: 1,
      slidesToScroll: 1
    });

    /* nav tabs */
    $('ul.nav-tabs a').click(function (e) {
      e.preventDefault();  
      $(this).tab('show');
    });



    var hash = window.location.hash;
    hash && $('.pricing ul.nav-tabs a[href="' + hash + '"]').tab('show');

    $('.pricing ul.nav-tabs a').click(function (e) {
      $(this).tab('show');
      var scrollmem = $('body').scrollTop();
      window.location.hash = this.hash;
      $('html,body').scrollTop(scrollmem);
    });

    window.addEventListener('hashchange', function() {
      var changedHash = window.location.hash;
      changedHash && $('.pricing ul.nav-tabs a[href="' + changedHash + '"]').tab('show');
    }, false);





    /* custom checkbox and radio buttons */
    $('input').iCheck({
      checkboxClass: 'icheckbox_flat',
      radioClass: 'iradio_flat'
    });

    /* about-us style */
    $('.about-us ul li:nth-of-type(2n)').addClass('no-line');
    $('.about-us ul h2:even').addClass('blue');
    $('.about-us ul h2:odd').addClass('orange');


    /*page steps tabs*/
    $('.tabs li a').click(function(){$('.tabs li').removeClass('current');$(this).parent().addClass('current');$('.tab-content').hide();var selected_tab =		'#'+$(this).attr('rel'); $(selected_tab).show(); 	 return false;});

    /*page steps sub-tabs*/
    $('.sub_tabs li a').click(function(){$('.sub_tabs li').removeClass('current');$(this).parent().addClass('current');$('.sub-tab-content').hide();var selected_tab =	'#'+$(this).attr('rel'); $(selected_tab).show(); 	 return false;});


    /*banner search*/
    $('#banner-hiring').click(function(){
        $(this).addClass('active');
        $(this).removeClass('pass');
        $('#banner-seeking').removeClass('active');
        $('#banner-seeking').addClass('pass');
        $('#search-hiring').addClass('active');
        $('#search-seeking').removeClass('active');
    });

    $('#banner-seeking').click(function(){
        $(this).addClass('active');
        $(this).removeClass('pass');
        $('#banner-hiring').removeClass('active');
        $('#banner-hiring').addClass('pass');
        $('#search-seeking').addClass('active');
        $('#search-hiring').removeClass('active');

    });

    /*banner search popup*/
    $('.advance_search').click(function(){
        $('.advance_search_pop_up').show();
    });
    $('.close').click(function(){
        $('.advance_search_pop_up').hide();
    });

    /*menu*/
    
    $('.top_links_container .top_link_drop').click(function(){      
		
		

        if( $(this).hasClass("active") ) {
            $(this).removeClass("active");
        } else {
            // if other menus are open remove open class and add closed
            $(this).siblings().removeClass("active"); 
            $(this).addClass("active");
        }

    });

    // If an event gets to the body
    $("body").click(function(){
        $(".top_link_drop").removeClass("active");
    });

    // Prevent events from getting pass .popup
    $(".top_link_drop").click(function(e){
        e.stopPropagation();
    });


    /*employee company profile*/
    $('.welcome-box .wel-img').click(function(){

        $(".welcome-box .wel-img").parent().toggleClass("active");
        console.log();

    });
    // If an event gets to the body
    $("body").click(function(){
        $(".welcome-box").removeClass("active");
    });

    // Prevent events from getting pass .popup
    $(".wel-img").click(function(e){
        e.stopPropagation();
    });

    /*toggle button Readmore functionality*/
    $('.content .button').on('click', function () {
        $(this).parent('.content').find('p.hidden_para').slideToggle();
        if ($(this).hasClass('button-icon-close')) {
            $(this).removeClass('button-icon-close');
            $(this).parent('.content').find('.button span').html('Read More...');
        }
        else
        {
            $(this).addClass('button-icon-close');
            $(this).parent('.content').find('.button span').html('Read Less...');
        }
        return false;
    });

    /*company employee add user popup*/
    $(".company_users .orange-btn").click(function(){

        $(".add_new_user_popup,.black_overlay").show();

    });
    $(".company_users .close").click(function(){

        $(".add_new_user_popup,.black_overlay").hide();

    });

    $(document).on('change', '.btn-file :file', function() {
        var input = $(this),
            numFiles = input.get(0).files ? input.get(0).files.length : 1,
            label = input.val().replace(/\\/g, '/').replace(/.*\//, '');
        input.trigger('fileselect', [numFiles, label]);
    });


});