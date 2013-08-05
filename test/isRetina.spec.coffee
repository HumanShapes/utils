describe 'isRetina', ->
  $window = isRetina = matchMedia = null

  beforeEach ->
    module('cabin.isRetina')
    module ($provide) ->
      $provide.value('$window', $window = angular.mock.createMockWindow())
      matchMedia = matches: false
      $window.matchMedia = jasmine.createSpy('matchMedia').andReturn(matchMedia)
      return
    inject (_isRetina_) ->
      isRetina = _isRetina_

  it 'checks devicePixelRatio', ->
    $window.devicePixelRatio = 1.5
    expect(isRetina()).toBe(true)
    $window.devicePixelRatio = 1
    expect(isRetina()).toBe(false)

  it 'falls back on a media query', ->
    $window.devicePixelRatio = undefined
    expect(isRetina()).toBe(false)
    matchMedia.matches = true
    expect(isRetina()).toBe(true)

  it 'is false when the browser lacks devicePixelRatio and matchMedia', ->
    $window.devicePixelRatio = undefined
    $window.matchMedia = undefined
    expect(isRetina()).toBe(false)
