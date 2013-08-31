class BrowserFS.File.TemplateFile extends BrowserFS.File.PreloadFile
  sync: (cb) ->

  close: (cb) -> @sync(cb)

class BrowserFS.FileSystem.Template extends BrowserFS.FileSystem
  constructor: (cb) ->
    cb(this) if cb

  getName: -> ''

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
