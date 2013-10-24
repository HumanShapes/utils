describe 'cabin.scrolling', ->

  beforeEach ->
    module('cabin.scrolling')

  describe 'windowScrollY', ->
    windowScrollY = null
    $window = null

    beforeEach ->
      $window = {}
      module ($provide) ->
        $provide.factory('$window', -> $window)
        return

    # Because branching happens at injection time rather than call time,
    # re-inject for each test.
    reinject = ->
      inject ($injector) -> windowScrollY = $injector.get('windowScrollY')

    it 'returns pageYOffset if available', ->
      $window.pageYOffset = 12
      reinject()
      expect(windowScrollY()).toEqual(12)

    it 'provides a fallback for IE', ->
      $window.document = documentElement: scrollTop: 17
      reinject()
      expect(windowScrollY()).toEqual(17)

    it 'prefers pageYOffset', ->
      $window.pageYOffset = 12
      $window.document = documentElement: scrollTop: 17
      reinject()
      expect(windowScrollY()).toEqual(12)

  describe 'absoluteOffsetTop', ->
    $compile = $rootScope = absoluteOffsetTop = null
    body = angular.element(document.body).css(margin: 0)

    beforeEach ->
      body.children().remove()  # clear anything added to the DOM
      inject (_$compile_, _$rootScope_, _absoluteOffsetTop_) ->
        $compile = _$compile_
        $rootScope = _$rootScope_
        absoluteOffsetTop = _absoluteOffsetTop_

    it 'should be 0 for invalid arguments', ->
      expect(absoluteOffsetTop()).toBe(0)

    it 'should handle angular.elements', ->
      element = $compile('<div style="margin-top: 17px;"></div>')({})
      body.append(element)
      expect(absoluteOffsetTop(element)).toBe(17)

    it 'should handle plain nodes', ->
      element = $compile('<div style="margin-top: 13px;"></div>')({})
      body.append(element)
      expect(absoluteOffsetTop(element[0])).toBe(13)

    it 'should be 0 for body', ->
      expect(absoluteOffsetTop(document.body)).toBe(0)

    it 'should handle nested elements', ->
      container = $compile('<div><div style="height: 13px;"></div></div>')({})
      element = $compile('<div style="margin-top: 15px;"></div>')({})
      container.append(element)
      body.append(container)
      expect(absoluteOffsetTop(element[0])).toBe(28)

    xit 'should handle nested elements with special positioning', ->  # TODO

  xdescribe 'cbStickyPos', ->  # TODO
