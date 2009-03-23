module AdminHelper
  
  def delete_icon(url)
    <<-JAVASCRIPT
    <a href="#" onclick="javascript:deleteListItem(this.parentNode, '#{url}');" title="Delete">
      <span class="ui-icon ui-icon-trash"></span>
    </a>
    JAVASCRIPT
  end
  
  def edit_icon(url)
    <<-JAVASCRIPT
      <a href="#{url}" title="Edit">
        <span class="ui-icon ui-icon-pencil" title="Edit"/>
      </a>
    JAVASCRIPT
  end
  
  
end
