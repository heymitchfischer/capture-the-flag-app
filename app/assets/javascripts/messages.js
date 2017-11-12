// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

function sendMessage(currentUserId) {
  var field = document.getElementById("message-line");
  $.ajax({
                    type: 'POST',
                    url: `/messages`,
                    data: {
                            text: field.value,
                            userId: currentUserId
                          },
        });
  field.value = "";
}