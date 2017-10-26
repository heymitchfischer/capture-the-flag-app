// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

function updateLocation(userID) {
  setInterval(function() {
    navigator.geolocation.getCurrentPosition(
      function(position) {
        $.ajax({
                type: 'PATCH',
                url: `/users/${userID}`,
                data: {
                        latitude: position.coords.latitude,
                        longitude: position.coords.longitude
                      },
              });
      }, 
      function(error) {
        alert(error.message);
      });
  }, 10000);
}