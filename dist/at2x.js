(function() {
  var module;

  module = angular.module('cabin.at2x', ['cabin.isRetina', 'cabin.preload']);

  module.directive('cbAt2x', function(isRetina, preload) {
    var retinaSrc;
    retinaSrc = function(src) {
      var chunks;
      chunks = src.split('.');
      if (chunks.length < 2) {
        return src;
      }
      chunks[chunks.length - 2] += '@2x';
      return chunks.join('.');
    };
    return {
      restrict: 'A',
      link: function(scope, elm, attrs) {
        var src;
        if (!isRetina()) {
          return;
        }
        src = attrs.cbAt2x || retinaSrc(attrs.src);
        if (src === attrs.src) {
          return;
        }
        return preload(src).then(function() {
          return attrs.$set('src', src);
        });
      }
    };
  });

}).call(this);
