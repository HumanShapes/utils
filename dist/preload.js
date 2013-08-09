(function () {
  angular.module('cabin.preload', []).factory('preload', [
    '$window',
    '$q',
    function ($window, $q) {
      return function (src) {
        var deferred, img;
        deferred = $q.defer();
        img = new $window.Image();
        img.onload = function () {
          return deferred.resolve(src);
        };
        img.onerror = function () {
          return deferred.reject();
        };
        img.src = src;
        return deferred.promise;
      };
    }
  ]);
}.call(this));