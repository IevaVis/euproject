App.chat = App.cable.subscriptions.create("ChatChannel", {
  connected: function() {

  },
  disconnected: function() {

  },
  received: function(data) {
  	var messages = $('#message-box');
  	messages.append(data['message']);
  	messages.scrollTop(messages[0].scrollHeight);

  }
});
