# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  def info(message, options={})
    options = {:width => "100%"}.merge options
    <<-MESSAGE
    <div class="info-box ui-state-highlight ui-corner-all" style="width: #{options[:width]}">
      <p><span class="ui-icon ui-icon-info"></span> #{message}</p>
    </div>
    MESSAGE
  end
  
  def error_box(message, options={})
    options = {:width => "100%"}.merge options
    <<-MESSAGE
    <div class="info-box ui-state-error ui-corner-all" style="width: #{options[:width]}">
      <p><span class="ui-icon ui-icon-alert"></span> #{message}</p>
    </div>
    MESSAGE
  end
  
end
