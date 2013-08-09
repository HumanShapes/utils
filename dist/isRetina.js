(function () {
  angular.module('cabin.isRetina', []).factory('isRetina', [
    '$window',
    function ($window) {
      var mql;
      mql = null;
      if ($window.matchMedia != null) {
        mql = $window.matchMedia('      (-webkit-min-device-pixel-ratio: 1.5),      (min--moz-device-pixel-ratio: 1.5),      (-o-min-device-pixel-ratio: 3/2),      (min-resolution: 1.5dppx)');
      }
      return function () {
        if ($window.devicePixelRatio != null) {
          return $window.devicePixelRatio >= 1.5;
        }
        return !!(mql != null ? mql.matches : void 0);
      };
    }
  ]);
}.call(this));