App.chat = App.cable.subscriptions.create("ChatChannel", {
  connected: function() {

  },
  disconnected: function() {

  },
  received: function(data) {
  	var messages = $('#message-box');
    var message_template = data['message']['template'];
    var message_json = JSON.parse(data['message']['json_version']);

  	messages.append(message_template);
  	if (messages[0] !== undefined) {
      messages.scrollTop(messages[0].scrollHeight);
    }
    if (!window.location.href.endsWith('messages')) {
      var template = "<a class='dropdown-item' href='/conversations/" + message_json['conversation_id'] + "/messages'>New message from " + message_json['from'] + "</a>"
      var count = parseInt($("[data-behavior='unread-count']").text());
      count += 1;
      $("[data-behavior='unread-count']").text(count);
      $("[data-behavior='notification-items']").append(template);
    }
  }
});
