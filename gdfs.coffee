_arrayBufferToBase64 = (buffer) ->
    binary = ''
    bytes = new Uint8Array(buffer)
    len = bytes.byteLength
    i = 0
    while ++i < len
      binary += String.fromCharCode(bytes[i])
    return window.btoa(binary)

_writeFile = (buffer, cb) ->
  boundary = '-------314159265358979323846'
  delimiter = "\r\n--" + boundary + "\r\n"
  close_delim = "\r\n--" + boundary + "--"

  contentType = fileData.type or 'application/octet-stream'
  metadata = {
    title: fileData.name,
    mimeType: contentType
  }

  base64Data = _arrayBufferToBase64(buffer)
  multipartRequestBody =
    delimiter +
    'Content-Type: application/json\r\n\r\n' +
    JSON.stringify(metadata) +
    delimiter +
    'Content-Type: ' + contentType + '\r\n' +
    'Content-Transfer-Encoding: base64\r\n' +
    '\r\n' +
    base64Data +
    close_delim;

  request = gapi.client.request({
    path: '/upload/drive/v2/files',
    method: 'POST',
    params: {
      uploadType: 'multipart'
    },
    headers: {
      'Content-Type': "multipart/mixed; boundary=\"#{boundary}\""
    },
    body: multipartRequestBody
  })

  unless callback
    callback = (file) ->
      console.log(file)

  request.execute(callback)

class BrowserFS.File.GDriveFile extends BrowserFS.File.PreloadFile
  sync: (cb) ->
    _writeFile(@_buffer.buff.buffer, cb)

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
