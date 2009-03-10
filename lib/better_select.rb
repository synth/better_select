# BetterSelect
module BetterSelect
  module TimeHelpers
    def time_of_day_options(t = Time.now)
      @@hours_of_the_day ||= [12]+(1..11).collect{|i| i}

      opts_str = ''
      ["AM", "PM"].each do |ampm|
        @@hours_of_the_day.each do |hour|
          ["00", "15", "30", "45"].each do |minute|
            s = "#{hour}:#{minute} #{ampm}"
            opts_str << content_tag(:option, s, {:value => s})
          end
        end
      end
  
      return opts_str
    end      
  end
  
  module FormHelpers
    def better_select_tag(name, option_tags, opts={})
      str = select_tag(name, option_tags, opts)
      str << javascript_tag("new Autocompleter.SelectBox('search_start_time', {input_tag_attributes : 'size=9'});")
      return str 
    end
    
    def better_time_select_tag(name, selected_time, opts={})
      better_select_tag(name, time_of_day_options(selected_time), opts.merge(:class => "autocomplete"))
    end
  end
  
  #this is really trivial right now, but leaving as is so its easier to expand if necessary
  #TODO: This probably doesn't play nice with an asset bundler
  module AssetTagHelper
    def better_select_javascript_include_tag
      javascript_include_tag "select"
    end
    
    def better_select_stylesheet_link_tag
      stylesheet_link_tag "autocomplete.css"
    end
    
    def better_select_includes
      better_select_javascript_include_tag+"\n"+better_select_stylesheet_link_tag
    end
  end
end