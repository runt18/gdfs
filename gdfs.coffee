class BrowserFS.File.GDriveFile extends BrowserFS.File.PreloadFile
  sync: (cb) ->

  close: (cb) -> @sync(cb)

class BrowserFS.FileSystem.GDrive extends BrowserFS.FileSystem
  constructor: (cb) ->
    details = {
      client_id: '555024705616.apps.googleusercontent.com'
      scope: 'https://www.googleapis.com/auth/drive'
      immediate: true
    }

    doAuth = (result) ->
      if result and not result.error
        console.log('Authenticated successfully')
      else
        details.immediate = false
        gapi.auth.authorize(details, doAuth)

    gapi.auth.authorize(details, doAuth)

    cb(this) if cb

  getName: -> 'Google Drive'

  @isAvailable: -> true

  isReadOnly: -> false

  supportsSymlinks: -> false

  supportsProps: -> false

  supportsSynch: -> false

  empty: (cb) ->

  rename: (oldPath, newPath, cb) ->

  stat: (path, isLstat, cb) ->

  open: (path, flags, mode, cb) ->

  unlink: (path, cb) ->

  rmdir: (path, cb) ->

  mkdir: (path, mode, cb) ->

  readdir: (path, cb) ->
