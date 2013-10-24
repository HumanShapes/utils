module = angular.module('cabin.scrolling', [])

# Provide a cross-browser window.scrollY (as a function).
module.factory 'windowScrollY', ($window) ->
  if $window.pageYOffset?
    -> $window.pageYOffset
  else
    -> $window.document.documentElement.scrollTop  # IE8

# Return the offset relative to the window.
module.value 'absoluteOffsetTop', (node) ->
  return 0 unless node
  node = node[0] if (node.bind and node.find)  # unwrap angular.elements
  offset = node.offsetTop
  while node = node.offsetParent
    offset += node.offsetTop
  offset

# Decorate the given element with classes to enable styling similar to the
# proposed `position: sticky`, which currently has poor browser support.
# `.cb-stick` is added when the top of the element meets the top of the window,
# at which point the element should be given fixed positioning if appropriate.
# `.cb-stick--bottom` is also added when the element would escape from its
# offset parent, allowing conversion to absolute positioning at that point.
#
# Set `cb-sticky-pos="<integer>"` to increase the top offset, to work around a
# fixed header.
module.directive 'cbStickyPos', (absoluteOffsetTop, windowScrollY, $window) ->
  restrict: 'A'
  link: (scope, elm, attrs) ->
    node = elm[0]
    container = node.offsetParent
    stickyMin = stickyMax = null

    setClass = ->
      scroll = windowScrollY()
      elm.toggleClass('cb-stick', scroll >= stickyMin)
      elm.toggleClass('cb-stick--bottom', scroll >= stickyMax)

    setup = ->
      nodeMarginTop = parseInt(getComputedStyle(node).marginTop, 10)
      extraTop = parseInt(attrs.cbStickyPos or 0, 10)
      height = node.clientHeight + nodeMarginTop + extraTop
      stickyMin = absoluteOffsetTop(node) - nodeMarginTop - extraTop
      stickyMax = absoluteOffsetTop(container) + container.clientHeight - height
      # Set the initial classes and add the scroll handler. Adding the scroll
      # handler before setup is complete, in case the browser sends an initial
      # scroll event before load.
      angular.element($window).bind('scroll', setClass)
      setClass()

    angular.element($window).bind('load', setup)
