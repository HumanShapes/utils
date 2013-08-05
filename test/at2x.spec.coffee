describe 'cbAt2x', ->
  $compile = $rootScope = wantsRetina = preload = preloadSuccess = null

  beforeEach ->
    module('cabin.at2x')
    module ($provide) ->
      wantsRetina = true
      $provide.value('isRetina', -> wantsRetina)
      preloadSuccess = true
      $provide.factory('preload', -> preload)
      return
    inject (_$compile_, _$rootScope_, $q) ->
      $compile = _$compile_
      $rootScope = _$rootScope_
      preload = jasmine.createSpy('preload').andCallFake (src) ->
        deferred = $q.defer()
        if preloadSuccess
          deferred.resolve(src)
        else
          deferred.reject()
        deferred.promise

  it 'should preload the specified asset', ->
    element = $compile('<img cb-at2x="bar">')($rootScope)
    expect(preload).toHaveBeenCalledWith('bar')

  it 'should swap the asset on successful preload', ->
    element = $compile('<img src="foo" cb-at2x="bar">')($rootScope)
    $rootScope.$digest()
    expect(element.attr('src')).toEqual('bar')

  it 'should attempt to guess the asset name when not given', ->
    element = $compile('<img src="foo.png" cb-at2x>')($rootScope)
    $rootScope.$digest()
    expect(element.attr('src')).toEqual('foo@2x.png')

  it 'should not swap the asset on failed preload', ->
    preloadSuccess = false
    element = $compile('<img src="foo" cb-at2x="bar">')($rootScope)
    $rootScope.$digest()
    expect(element.attr('src')).toEqual('foo')

  it 'should do nothing on non-retina displays', ->
    wantsRetina = false
    element = $compile('<img src="foo" cb-at2x="bar">')($rootScope)
    $rootScope.$digest()
    expect(preload).not.toHaveBeenCalled()
    expect(element.attr('src')).toEqual('foo')
