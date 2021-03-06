App.room = App.cable.subscriptions.create("RoomChannel", {
  connected: function() {
    // Called when the subscription is ready for use on the server
  },

  disconnected: function() {
    // Called when the subscription has been terminated by the server
  },

  received: function(data) {
    $('#messages-' + data.room_id).append('<div class="post-preview">' + '<h3 class="post-subtitle">' + '<h5>' + data.content + '</h5>' + '</h3>' + '<p class="post-meta"><b>' + data.username + '</b> at ' + data.created_at + '</p>' + '</div>' + '<hr>');
    console.log(data.room_id);
  }
});
