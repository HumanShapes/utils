module = angular.module('cabin.at2x', ['cabin.isRetina', 'cabin.preload'])

# On retina-capable displays, attempt to load a retina asset
# (`<filename>@2x.<ext>`) and swap it in place of the existing asset on
# success.
module.directive 'cbAt2x', (isRetina, preload) ->
  # Guess the retina asset URL by inserting `@2x` prior to the file extension.
  retinaSrc = (src) ->
    chunks = src.split('.')
    # Give up if there is no file extension.
    return src if chunks.length < 2
    chunks[chunks.length - 2] += '@2x'
    chunks.join('.')

  restrict: 'A'
  link: (scope, elm, attrs) ->
    return unless isRetina()
    src = attrs.cbAt2x or retinaSrc(attrs.src)
    return if src is attrs.src  # nothing to do!
    preload(src).then(-> attrs.$set('src', src))
