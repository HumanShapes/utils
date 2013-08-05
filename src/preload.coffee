# Load an image (or other resource) without displaying it; return a promise.
angular.module('cabin.preload', []).factory 'preload', ($window, $q) ->
  (src) ->
    deferred = $q.defer()
    img = new $window.Image()
    img.onload = -> deferred.resolve(src)
    img.onerror = -> deferred.reject()
    img.src = src
    return deferred.promise
