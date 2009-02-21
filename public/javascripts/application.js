// Used on administration pages.
function deleteListItem(victim, url) {
  dialog_box = document.createElement("p");
  dialog_box.innerHTML = "Are you sure?<br/><br/>There is no undo.";
  
  $(dialog_box).dialog({
		resizable: false,
		height:240,
		modal: true,
		autoOpen: true,
		draggable: false,
		title: "Confirm deletion",
		buttons: {
			'Delete': function() {
        $.ajax({
          url:   url,
          type: "POST",
          async: false,
          data: { _method: "delete", authenticity_token: AUTH_TOKEN },
          success: function() {
            $(dialog_box).dialog('close');
            $(victim).toggle("slide");
          },
          error: function() {
  				  $(dialog_box).dialog('close');
          }
        });
			},
			Cancel: function() {
				$(dialog_box).dialog('close');
			}
		}
	});
}