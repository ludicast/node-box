https = require('https')
class exports.BoxFetcher
  constructor:(@boxKey)->

  # for fetching file type
  # boxFetcher.fetchExtensions(userAuthToken, extensions, callback) 
  fetchByExtensions:(userAuthToken, extensions, callback)->
    host = "ww.box.net"
    path = "/api/1.0/rest?action=get_account_tree&api_key=#{@boxKey}&auth_token=#{userAuthToken}&folder_id=0&params%5B%5D=onelevel&params%5B%5D=nozip"
    httpsReq = https.get {host,path}, (result)->
      result.on 'data', (data)->
        boxParser = new BoxParser()
        boxParser.findExtensions data.toString(), extensions, callback
    httpsReq.end()

