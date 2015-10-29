// JavaScript Document
$(document).ready(function(){

    /*page steps tabs*/
    $('.tabs li a').click(function(){$('.tabs li').removeClass('current');$(this).parent().addClass('current');$('.tab-content').hide();var selected_tab =		'#'+$(this).attr('rel'); $(selected_tab).show(); 	 return false;});

    /*page steps sub-tabs*/
    $('.sub_tabs li a').click(function(){$('.sub_tabs li').removeClass('current');$(this).parent().addClass('current');$('.sub-tab-content').hide();var selected_tab =	'#'+$(this).attr('rel'); $(selected_tab).show(); 	 return false;});

    /*fixed header after scroll*/
    $(window).scroll(function () {

        var windowsize_val = $(window).width();
        if ((windowsize_val > 760)) { /* condition to check window size*/

            if ($(this).scrollTop() > $('.header').height()) {

                $('.header-wrap').addClass('fixed');
            } else {

                $('.header-wrap').removeClass('fixed');

            }
        }

    });

    /*banner search*/
    $('.hire').click(function(){

        $('.hire').addClass('active');
        $('.main_search_container').toggle().parent().toggleClass('active');
        $('.main_search_container2').css('display','none');
        $('#hiring2').removeClass('active');
    });

    $('.hire1').click(function(){
        $('.hire1').addClass('active');
        $('#hiring').removeClass('active');
        $('.main_search_container2').toggle().parent().toggleClass('active');
        $('.main_search_container').css('display','none');

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