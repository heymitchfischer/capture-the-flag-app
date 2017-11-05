document.addEventListener("DOMContentLoaded", function(event) { 
  var app = new Vue({
    el: '#app',
    data: {
      players: [],
      bases: [],
      flags: [],
      message: 'Hello Vue!'
    },
    mounted: function() {
      setInterval(function() {
        console.log(gon.current_user.id);
          navigator.geolocation.getCurrentPosition(
            function(position) {
              $.ajax({
                      type: 'PATCH',
                      url: `/users/${gon.current_user.id}.json`,
                      data: {
                              latitude: position.coords.latitude,
                              longitude: position.coords.longitude
                            },
                      success: function(result) {
                                                  this.players = result;
                                                }.bind(this)
                    });
            }.bind(this), 
            function(error) {
              alert(error.message);
            });
          console.log(this.players);
      }.bind(this), 5000);    
    },
    methods: {
      playerHasFlag: function(player) {
        return player.has_flag;
      },
      playerIsStunned: function(player) {
        return player.time_stunned !== null;
      },
      playerIsNotStunned: function(player) {
        return player.time_stunned === null;
      },
      playerIsStunnable: function(player) {
        return player.team_id !== gon.current_user.team_id && player.time_stunned === null;
      }
    },
    computed: {

    }
  });
});