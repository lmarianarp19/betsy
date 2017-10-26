// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require foundation
//= require turbolinks
//= require_tree .

// $(function(){ $(document).foundation(); });
//
// StarWars = (function() {
//
//   /*
//    * Constructor
//    */
//   function StarWars(args) {
//     // Context wrapper
//     this.el = $(args.el);
//
//     // Audio to play the opening crawl
//     this.audio = this.el.find('audio').get(0);
//
//     // Start the animation
//     this.start = this.el.find('.start');
//
//     // The animation wrapper
//     this.animation = this.el.find('.animation');
//
//     // Remove animation and shows the start screen
//     this.reset();
//
//     // Start the animation on click
//     this.start.bind('click', $.proxy(function() {
//       this.start.hide();
//       this.audio.play();
//       this.el.append(this.animation);
//     }, this));
//
//     // Reset the animation and shows the start screen
//     $(this.audio).bind('ended', $.proxy(function() {
//       this.audio.currentTime = 0;
//       this.reset();
//     }, this));
//   }
//
//   /*
//    * Resets the animation and shows the start screen.
//    */
//   StarWars.prototype.reset = function() {
//     this.start.show();
//     this.cloned = this.animation.clone(true);
//     this.animation.remove();
//     this.animation = this.cloned;
//   };
//
//   return StarWars;
// })();
//
// new StarWars({
//   el : '.starwars'
// });
