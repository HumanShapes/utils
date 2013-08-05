describe 'preload', ->
  $rootScope = preload = img = null

  beforeEach ->
    module('cabin.preload')
    module ($provide) ->
      img = {}
      $window = angular.mock.createMockWindow()
      $window.Image = jasmine.createSpy('Image').andReturn(img)
      $provide.value('$window', $window)
      return
    inject (_$rootScope_, _preload_) ->
      $rootScope = _$rootScope_
      preload = _preload_

  it 'loads the given image', ->
    preload('test.png')
    expect(img.src).toEqual('test.png')

  it 'resolves the promise when appropriate', ->
    success = jasmine.createSpy('success')
    preload('test.png').then(success)
    img.onload()
    $rootScope.$digest()
    expect(success).toHaveBeenCalledWith('test.png')

  it 'rejects the promise when appropriate', ->
    success = jasmine.createSpy('success')
    error = jasmine.createSpy('error')
    preload('test.png').then(success, error)
    img.onerror()
    $rootScope.$digest()
    expect(success).not.toHaveBeenCalled()
    expect(error).toHaveBeenCalled()
