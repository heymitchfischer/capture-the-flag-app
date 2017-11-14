document.addEventListener("DOMContentLoaded", function(event) { 
  var app = new Vue({
    el: '#app',

    data: {
      players: [],
      bases: [],
      flags: [],
      currentUser: {},
      loading: false
    },

    mounted: function() {
      if (document.getElementById("app") === null) {
        return;
      }
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
                                              this.players = JSON.parse(result[0]).sort();
                                              this.bases = JSON.parse(result[1]);
                                              this.flags = JSON.parse(result[2]);
                                              this.currentUser = JSON.parse(result[3]);
                                              this.loading = true;
                                            }.bind(this),
                });
        }.bind(this), 
        function(error) {
          alert(error.message);
        }
      );
      setInterval(function() {
        if (document.getElementById("app") === null) {
          return;
        }
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
                                                this.players = JSON.parse(result[0]);
                                                this.bases = JSON.parse(result[1]);
                                                this.flags = JSON.parse(result[2]);
                                                this.currentUser = JSON.parse(result[3]);
                                              }.bind(this),
                  });
          }.bind(this), 
          function(error) {
            alert(error.message);
          }
        );
      }.bind(this), 7000);    
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
        return player.team_id !== this.currentUser.team_id && player.time_stunned === null && this.currentUser.time_stunned === null;
      },

      isAllyBase: function(base) {
        if (base.distance <= 0.01) {
          return base.team_id === this.currentUser.team_id;
        }
      },

      isEnemyFlag: function(flag) {
        if (flag.distance <= 0.01) {
          return flag.team_id !== this.currentUser.team_id;
        }
      },

      isAllyFlag: function(flag) {
        if (flag.distance <= 0.01) {
          return flag.team_id === this.currentUser.team_id && flag.captures.length > 0;
        }
      },

      canReturnFlag: function() {
        return this.currentUser.has_flag && this.currentUser.team_id === this.currentUser.flags[this.currentUser.flags.length - 1].team_id;
      },

      canScoreFlag: function() {
        return this.currentUser.has_flag && this.currentUser.team_id !== this.currentUser.flags[this.currentUser.flags.length - 1].team_id;
      },

      stunPlayer: function(player, user) {
        $.ajax({
          type: 'POST',
          url: '/stuns.json',
          data: {
                  userId: user,
                  enemyId: player
                },
          success: function(result) {
                                      this.players = JSON.parse(result[0]);
                                      this.flags = JSON.parse(result[1]);
                                      this.currentUser = JSON.parse(result[2]);
                                    }.bind(this),
          async: false
        });
      },

      returnFlag: function(base) {
        $.ajax({
          type: 'DELETE',
          url: `/flags/${this.currentUser.flags[this.currentUser.flags.length - 1].id}.json`,
          data: {
                  userId: this.currentUser.id,
                  baseId: base,
                  flagId: this.currentUser.flags[this.currentUser.flags.length - 1].id
                },
          success: function(result) {
                                      this.bases = JSON.parse(result[0]);
                                      this.flags = JSON.parse(result[1]);
                                      this.currentUser = JSON.parse(result[2]);
                                    }.bind(this),
          async: false
        });
      },

      capture: function(flag, user) {
        $.ajax({
          type: 'PATCH',
          url: `/flags/${flag}.json`,
          data: {
                  userId: user,
                  flagId: flag
                },
          success: function(result) {
                                      this.bases = JSON.parse(result[0]);
                                      this.flags = JSON.parse(result[1]);
                                      this.currentUser = JSON.parse(result[2]);
                                    }.bind(this),
          async: false
        });
      },

      directionalBearing: function(degrees) {
        if (degrees >= 337.5 || degrees < 22.5) {
          return "N";
        } else if (degrees >= 22.5 && degrees < 67.5) {
          return "NE";
        } else if (degrees >= 67.5 && degrees < 112) {
          return "E";
        } else if (degrees >= 112 && degrees < 157.5) {
          return "SE";
        } else if (degrees >= 157.5 && degrees < 202.5) {
          return "S";
        } else if (degrees >= 202.5 && degrees < 247.5) {
          return "SW";
        } else if (degrees >= 247.5 && degrees < 292.5) {
          return "W";
        } else if (degrees >= 292.5 && degrees < 337.5) {
          return "NW";
        }
      },

      playerStatus: function() {
        if (this.currentUser.has_flag) {
          return "Carrying Flag!";
        } else if (this.currentUser.time_stunned !== null) {
          return "Stunned";
        } else {
          return "Normal";
        }
      }
    },

    computed: {

    }
  });
});