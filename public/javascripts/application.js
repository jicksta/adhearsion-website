// This lets jQuery AJAX requests always send along Rails' authenticity token. AUTH_TOKEN is defined in the layout.
// $(document).ajaxSend(function(event, request, settings) {
//   if (typeof(AUTH_TOKEN) == "undefined") return;
//   // settings.data is a serialized string like "foo=bar&baz=boink" (or null)
//   settings.data = settings.data || "";
//   settings.data += (settings.data ? "&" : "") + "authenticity_token=" + encodeURIComponent(AUTH_TOKEN);
// });