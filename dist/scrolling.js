(function () {
  var module;
  module = angular.module('cabin.scrolling', []);
  module.factory('windowScrollY', [
    '$window',
    function ($window) {
      if ($window.pageYOffset != null) {
        return function () {
          return $window.pageYOffset;
        };
      } else {
        return function () {
          return $window.document.documentElement.scrollTop;
        };
      }
    }
  ]);
  module.value('absoluteOffsetTop', function (node) {
    var offset;
    if (!node) {
      return 0;
    }
    if (node.bind && node.find) {
      node = node[0];
    }
    offset = node.offsetTop;
    while (node = node.offsetParent) {
      offset += node.offsetTop;
    }
    return offset;
  });
  module.directive('cbStickyPos', [
    'absoluteOffsetTop',
    'windowScrollY',
    '$window',
    function (absoluteOffsetTop, windowScrollY, $window) {
      return {
        restrict: 'A',
        link: function (scope, elm, attrs) {
          var container, node, setClass, setup, stickyMax, stickyMin;
          node = elm[0];
          container = node.offsetParent;
          stickyMin = stickyMax = null;
          setClass = function () {
            var scroll;
            scroll = windowScrollY();
            elm.toggleClass('cb-stick', scroll >= stickyMin);
            return elm.toggleClass('cb-stick--bottom', scroll >= stickyMax);
          };
          setup = function () {
            var extraTop, height, nodeMarginTop;
            nodeMarginTop = parseInt(getComputedStyle(node).marginTop, 10);
            extraTop = parseInt(attrs.cbStickyPos || 0, 10);
            height = node.clientHeight + nodeMarginTop + extraTop;
            stickyMin = absoluteOffsetTop(node) - nodeMarginTop - extraTop;
            stickyMax = absoluteOffsetTop(container) + container.clientHeight - height;
            angular.element($window).bind('scroll', setClass);
            return setClass();
          };
          return angular.element($window).bind('load', setup);
        }
      };
    }
  ]);
}.call(this));