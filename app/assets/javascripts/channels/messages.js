// run after html rendering
document.addEventListener('DOMContentLoaded', function () {
    var message_box = $('#message-box');
    // run only if we have one message box on the page
    if (message_box.length === 1) {
        App.messages = App.cable.subscriptions.create(
            {
                channel: 'MessagesChannel',
                conversation_id: message_box.data('conversation-id'),
            }, {
                connected: function () {

                },
                disconnected: function () {

                },
                received: function (data) {
                    var messages = $('#message-box')
                    var message_template = data['message']['template']
                    var message_json = JSON.parse(data['message']['json_version'])

                    messages.append(message_template)
                    if (messages[0] !== undefined) {
                        messages.scrollTop(messages[0].scrollHeight)
                    }
                    // if (!window.location.href.endsWith('messages')) {
                    //   var template = "<a class='dropdown-item' href='/conversations/" + message_json['conversation_id'] + "/messages'>New message from " + message_json['from'] + "</a>"
                    //   var count = parseInt($("[data-behavior='unread-count']").text());
                    //   count += 1;
                    //   $("[data-behavior='unread-count']").text(count);
                    //   $("[data-behavior='notification-items']").append(template);
                    // }
                },
            })
    }
})
