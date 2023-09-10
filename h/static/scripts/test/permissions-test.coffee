{module, inject} = angular.mock

describe 'h:permissions', ->
  sandbox = null
  fakeSession = null
  fakeLocalStorage = null

  before ->
    angular.module('h', [])
    .service('permissions', require('../permissions'))

  beforeEach module('h')

  beforeEach module ($provide) ->
    sandbox = sinon.sandbox.create()
    fakeSession = {
      state: {
        userid: 'acct:flash@gordon'
      }
    }
    fakeLocalStorage = {
      getItem: -> undefined
    }

    $provide.value 'session', fakeSession
    $provide.value 'localStorage', fakeLocalStorage
    return

  afterEach ->
    sandbox.restore()


  describe 'permissions service', ->
    permissions = null

    beforeEach inject (_permissions_) ->
      permissions = _permissions_

    describe 'private()', ->

      it 'fills all permissions with auth.user', ->
        perms = permissions.private()
        assert.equal(perms.read[0], 'acct:flash@gordon')
        assert.equal(perms.update[0], 'acct:flash@gordon')
        assert.equal(perms.delete[0], 'acct:flash@gordon')
        assert.equal(perms.admin[0], 'acct:flash@gordon')

      it 'returns null if session.state.userid is falsey', ->
        delete fakeSession.state.userid
        assert.equal(permissions.private(), null)

    describe 'shared()', ->

      it 'fills the read property with group:__world__', ->
        perms = permissions.shared()
        assert.equal(perms.read[0], 'group:__world__')
        assert.equal(perms.update[0], 'acct:flash@gordon')
        assert.equal(perms.delete[0], 'acct:flash@gordon')
        assert.equal(perms.admin[0], 'acct:flash@gordon')

      it 'fills the read property with group:foo if passed "foo"', ->
        perms = permissions.shared("foo")
        assert.equal(perms.read[0], 'group:foo')
        assert.equal(perms.update[0], 'acct:flash@gordon')
        assert.equal(perms.delete[0], 'acct:flash@gordon')
        assert.equal(perms.admin[0], 'acct:flash@gordon')

      it 'returns null if session.state.userid is falsey', ->
        delete fakeSession.state.userid
        assert.equal(permissions.shared("foo"), null)

    describe 'default()', ->

      it 'returns shared permissions if localStorage contains "shared"', ->
        fakeLocalStorage.getItem = -> 'shared'
        assert(permissions.isShared(permissions.default()))

      it 'returns private permissions if localStorage contains "private"', ->
        fakeLocalStorage.getItem = -> 'private'
        assert(permissions.isPrivate(
          permissions.default(), fakeSession.state.userid))

      it 'returns shared permissions if localStorage is empty', ->
        fakeLocalStorage.getItem = -> undefined
        assert(permissions.isShared(permissions.default()))

    describe 'setDefault()', ->

      it 'sets the default permissions that default() will return', ->
        stored = {}
        fakeLocalStorage.setItem = (key, value) ->
          stored[key] = value
        fakeLocalStorage.getItem = (key) ->
          return stored[key]

        permissions.setDefault('private')
        assert(permissions.isPrivate(
          permissions.default(), fakeSession.state.userid))

        permissions.setDefault('shared')
        assert(permissions.isShared(
          permissions.default('foo'), 'foo'))

    describe 'isPublic', ->
      it 'isPublic() true if the read permission has group:__world__ in it', ->
        permission = {
            read: ['group:__world__', 'acct:angry@birds.com']
        }
        assert.isTrue(permissions.isShared(permission))

      it 'isPublic() false otherwise', ->
        permission = {
            read: ['acct:angry@birds.com']
        }

        assert.isFalse(permissions.isShared(permission))
        permission.read = []
        assert.isFalse(permissions.isShared(permission))
        permission.read = ['one', 'two', 'three']
        assert.isFalse(permissions.isShared(permission))

    describe 'isPrivate', ->
      it 'returns true if the given user is in the permissions', ->
        user = 'acct:angry@birds.com'
        permission = {read: [user]}
        assert.isTrue(permissions.isPrivate(permission, user))

      it 'returns false if another user is in the permissions', ->
        users = ['acct:angry@birds.com', 'acct:angry@joe.com']
        permission = {read: users}
        assert.isFalse(permissions.isPrivate(permission, 'acct:angry@birds.com'))

      it 'returns false if different user in the permissions', ->
        user = 'acct:angry@joe.com'
        permission = {read: ['acct:angry@birds.com']}
        assert.isFalse(permissions.isPrivate(permission, user))

    describe 'permits', ->
      it 'returns true when annotation has no permissions', ->
        annotation = {}
        assert.isTrue(permissions.permits(null, annotation, null))

      it 'returns false for unknown action', ->
        annotation = {permissions: permissions.private()}
        action = 'Hadouken-ing'
        assert.isFalse(permissions.permits(action, annotation, null))

      it 'returns true if user different, but permissions has group:__world__', ->
        annotation = {permissions: permissions.shared()}
        annotation.permissions.read.push 'acct:darthsidious@deathstar.emp'
        user = 'acct:darthvader@deathstar.emp'
        assert.isTrue(permissions.permits('read', annotation, user))

      it 'returns true if user is in permissions[action] list', ->
        annotation = {permissions: permissions.private()}
        user = 'acct:rogerrabbit@toonland'
        annotation.permissions.read.push user
        assert.isTrue(permissions.permits('read', annotation, user))

      it 'returns false if the user name is missing from the list', ->
        annotation = {permissions: permissions.private()}
        user = 'acct:rogerrabbit@toonland'
        assert.isFalse(permissions.permits('read', annotation, user))
