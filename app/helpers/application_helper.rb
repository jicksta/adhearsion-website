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
  
  def auth_token
    javascript_tag "var AUTH_TOKEN = #{form_authenticity_token.inspect};" if protect_against_forgery?
  end
  
  def phone_from_here
    if logged_in?
      
      url    = "http://api.phonefromhere.com/gateway/adhearsion.xsql?caller=#{current_user.login}"
      div_id = "pfh_#{randomness}"
      
      <<-HTML
        <div id="#{div_id}"></div>
        <script type="text/javascript">
          
          function initialize_phone() {
            $("##{div_id}").empty().append('\
              <iframe src="#{url}" height="265" width="297" scrolling="no">\
                <p>Click <a href="#{url}" target="_blank">here</a> to open the softphone in a new window.</p>\
              </iframe>\
              <p><a href="#" onclick="javascript:reset_preview(); return false;">Close Phone</a></p>'
            );
          }
          
          function reset_preview() {
            $("##{div_id}").empty().append('\
              <p>Click the following image to initialize Phone From Here.</p>\
              <p><a href="#" onclick="javascript:initialize_phone(); return false;">\
                <img src="/images/phonefromhere-preview.png" alt="Click here to activate Phone From Here"/>\
              </a></p>\
              <p>Note: You will need to have Java installed.</p>'
            );
          }
          
          reset_preview();
          
        </script>
      HTML
    else
      <<-HTML
        <img src="/images/phonefromhere-logo.png" alt="Phone From Here"/>
        <form action="http://api.phonefromhere.com/gateway/adhearsion.xsql" method="GET" target="_blank">
          <p><label for="caller">Enter the sandbox username to call.</label><br/><br/><input type="text" name="caller"/> <input type="submit" value="Open softphone"/></p>
          <p>Phone From Here will be opened in a new window.</p>
        </form>
      HTML
    end
  end
  
  protected
  
  def randomness
    (rand * 1_000_000).to_i
  end
  
end
