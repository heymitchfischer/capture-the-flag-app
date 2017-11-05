document.addEventListener("DOMContentLoaded", function(event) { 
  var app = new Vue({
    el: '#app',

    data: {
      players: [],
      bases: [],
      flags: []
    },

    mounted: function() {
      setInterval(function() {
        console.log(gon.global.current_user.id);
          navigator.geolocation.getCurrentPosition(
            function(position) {
              $.ajax({
                      type: 'PATCH',
                      url: `/users/${gon.global.current_user.id}.json`,
                      data: {
                              latitude: position.coords.latitude,
                              longitude: position.coords.longitude
                            },
                      success: function(result) {
                                                  this.players = JSON.parse(result[0]);
                                                  this.bases = JSON.parse(result[1]);
                                                  this.flags = JSON.parse(result[2]);
                                                }.bind(this),
                    });
            }.bind(this), 
            function(error) {
              alert(error.message);
            });
          console.log(this.players);
          console.log(this.bases);
          console.log(this.flags);
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
        return player.team_id !== gon.global.current_user.team_id && player.time_stunned === null;
      },

      stunPlayer: function(player) {

      },

      baseIsAlly: function(base) {
        return gon.global.current_user.team_id === base.team_id;
      },

      playerHasAllyFlag: function() {
        console.log(gon.global.current_user.latitude);
      },

      playerHasEnemyFlag: function() {
        return gon.global.current_user.has_flag;
      },

      returnFlag: function() {

      },

      score: function() {

      },

      isEnemyFlag: function(flag) {

      },

      isAllyFlag: function(flag) {

      },

      capture: function() {

      },

      rescue: function() {

      },

      playerCanPickUpFlag: function() {
        return gon.global.current_user.time_stunned === null;
      }
    },

    computed: {

    }
  });
});