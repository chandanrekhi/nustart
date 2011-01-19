# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  include TagsHelper
  
  def inside_layout(layout, &block)    
    layout = layout.include?('/') ? layout : "layouts/#{layout}"    
    @template.instance_variable_set("@content_for_layout", capture(&block))    
    concat(@template.render(:file => layout, :user_full_path => true))    
  end
  
  def shorten(string, count = 50)
    if string.length >= count 
   	  shortened = string[0, count]
      splitted = shortened.split(/\s/)
      words = splitted.length
      splitted[0, words-1].join(" ") + ' ...'
    else 
      string
    end
  end
end
