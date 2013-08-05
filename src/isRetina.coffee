angular.module('cabin.isRetina', []).factory 'isRetina', ($window) ->
  mql = null
  if $window.matchMedia?
    mql = $window.matchMedia "
      (-webkit-min-device-pixel-ratio: 1.5),
      (min--moz-device-pixel-ratio: 1.5),
      (-o-min-device-pixel-ratio: 3/2),
      (min-resolution: 1.5dppx)"
    # TODO: add event for when this changes
    # mql.addListener ...

  ->
    if $window.devicePixelRatio?
      return $window.devicePixelRatio >= 1.5
    return !!mql?.matches
