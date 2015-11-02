module PaginationHelper
    class LinkRenderer < WillPaginate::ActionView::LinkRenderer
        protected

      def page_number(page)
        unless page == current_page
          link(page, page, :rel => rel_value(page))
        else
          link(page, "#", :class => 'active')
        end
      end

      def gap
        text = @template.will_paginate_translate(:page_gap) { '&hellip;' }
        %(<li class="disabled"><a>#{text}</a></li>)
      end

      def next_page
        num = @collection.current_page < @collection.total_pages && @collection.current_page + 1
        previous_or_next_page(num, @options[:next_label], '')
      end

      def previous_or_next_page(page, text, classname)
        if page
          link(text, page, :class => classname)
        else
          link(text, "#", :class => classname + ' disabled')
        end
      end

      def html_container(html)
        tag(:div, tag(:ul, html), container_attributes)
      end

    private
      def first_page
        previous_or_next_page(current_page == 1 ? nil : 1, @options[:first_label], "first_page")
      end

      def last_page
        previous_or_next_page(current_page == total_pages ? nil : total_pages, @options[:last_label], "last_page")
      end

        def link(text, target, attributes = {})
        if target.is_a? Fixnum
          attributes[:rel] = rel_value(target)
          target = url(target)
        end

                unless target == "#"
                    attributes[:href] = target
                end

        classname = attributes[:class]
        attributes.delete(:classname)
        puts 'taggg '+text.to_s
        puts 'taggg '+(text.to_s=='Next &#8594;').to_s
        if text.to_s=='Next &#8594;'
          text="<img src='/assets/next-1.png'>"
          tag(:li, tag(:a, text, attributes))
        elsif text.to_s=='&#8592; Previous'
          text="<img src='/assets/prev-1.png'>"
          tag(:li, tag(:a, text, attributes))
        else
          tag(:li, tag(:a, text, attributes), :class => 'plink')
        end

        end
    end
end
