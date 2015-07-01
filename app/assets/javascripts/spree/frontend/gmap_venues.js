$(document).ready(function(){
  if ($("#map")) {
  function GmapVenues () {
    this.venuesSearch = $("#searchVenues");
    this.rank = $(".rank");
    this.venuesNearBy =$("#venues-near-by")
    this.location = JSON.parse($("#locationSession").html());
    this.map = null;
  };
  GmapVenues.prototype = {
  init: function(){
    this.bindEvents();
    this.checkRank();
   if (this.location) {
      this.setMap(this.location[0], this.location[1]);
    }
      this.setPinsOnload();
  },
  bindEvents: function(){
    this.venuesSearch.on('submit', function(e){
      this.getVenues(e);
    }.bind(this))
    this.rank.on("click", function(e){
      this.getFliteredVenues(e)
    }.bind(this))
  },
  checkRank: function(){
    $('.rank:input:checkbox').attr('checked', 'checked')
  },
  toggleCheck: function(e) {
    $(e.target).prev().toggle();
  },
  getVenues: function (e){
    e.preventDefault();
    var zip = $(e.target).children().first().val();
    if(zip ){
      $.ajax({
         url: "/venues.json",
         type: 'GET',
         data: $(e.target).serialize()
       })
      .success(function(data){
        this.resetSidebar(e)
        if(data.venues.length > 0){
          this.setMap(data.user_location[0], data.user_location[1])
          this.setPins(data.venues)
          this.venuesTemplate(data.venues);
        } else if (!data.user_location == "") {
          this.setMap(data.user_location[0], data.user_location[1])
          this.resetVenues()
        }
      }.bind(this))
      .error(function(xhr) {
        console.log("error something happened with retrieving your venues near you ")
        }.bind())
      }
    },
    setPinsOnload: function(){
      $.ajax({
         url: "/venues/drop_pins_on_load",
         type: 'GET'
       })
      .success(function(data){
        if(data.venues.length > 0){
          this.setPins(data.venues);
        } else {
          this.resetVenues()
        }
      }.bind(this))
      .error(function(xhr) {
        console.log("error something happened with retrieving your venues near you ")
      }.bind())
    },
    getFliteredVenues: function (e){
      this.venuesNearBy.html('')
      map.removeOverlays();
      $.ajax({
         url: "/venues/fliter_venues_near_by",
         type: 'GET',
         data: $('input:checkbox:checked').serialize()
       })
      .success(function(data){
        this.toggleCheck(e)
        if(data.venues.length > 0) {
          this.setPins(data.venues);
          this.venuesTemplate(data.venues)
        }
      }.bind(this))
      .error(function(xhr) {
        console.log("error something happened with retrieving your venues near you ")
      }.bind())
    },
    setMap: function(lat, lng){
      if (this.location) {
         map = new GMaps({
          el: '#map',
          lat: lat ,
          lng: lng,
          zoom: 10
        });
      };
    },
    setOverLay: function(lat, lng, letter) {
      map.drawOverlay({
        lat: lat,
        lng: lng,
        content: '<div class="overlay letters"><span>'+ letter + '</span></div>'
      });
    },
    setPins: function(data) {
      var letters = ["A", "B", "C", "E", "F"]
      var counter = 0
      for (var i = data.length - 1; i >= 0; i--) {
        data[i].letter = letters[i]
        counter++
      };
      this.createOverLay(data)
    },
    createOverLay: function(data) {
      for (var i = data.length - 1; i >= 0; i--) {
        this.setOverLay(data[i].latitude, data[i].longitude, data[i].letter)
      };
    },
    resetVenues: function(){
      this.venuesNearBy.html("");
       this.venuesNearBy.append("<div class='no-stores'>There are no stores in your area.</div>")
    },
    venuesTemplate: function(data) {
      $("#venues-near-by").html("")
      var template = Handlebars.compile($("#venues-template").html());
      this.venuesNearBy.append(template(data))
    },
    resetForm: function() {
      this.venuesSearch[0].reset();
    },
    resetSidebar: function(e){
      this.toggleCheck(e)
      map.removeOverlays();
    }
  }
     // start
   var venuesController = new GmapVenues();
   venuesController.init();
  };
})