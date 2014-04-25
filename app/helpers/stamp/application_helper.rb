module Stamp
  module ApplicationHelper
    def sortable(column, title = nil)
        title ||= column.titleize
        css_class = column == sort_column ? "current #{sort_direction}" : nil
        direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
        link_to title, params.merge(:sort => column, :direction => direction, :page => nil), {:class => css_class}
    end

    # doesnt work: check why; and then delete application.css.scss styles
    #and sortable-headers class
   # it adapts the twitter bootstrap framework's icons
   #http://railscasts.com/episodes/228-sortable-table-columns?view=comments
   # def sortable(column, title = nil)
   #      title ||= column.titleize
   #      css_class = column == sort_column ? "current #{sort_direction}" : nil
   #      direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
   #      link_to "#{title} <i class='#{direction == "desc" ? "icon-chevron-down" : "icon-chevron-up"}'></i>".html_safe, {:sort => column, :direction => direction}, {:class => css_class}
   #  end
  end
end
