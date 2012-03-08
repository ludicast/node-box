{BoxParser} = require "./box_parser"
https = require('https')
class exports.BoxFetcher
  constructor:(@boxKey)->

  fetchPath:(auth)->
    host = "ww.box.net"
    path = "/api/1.0/rest?action=get_account_tree&api_key=#{@boxKey}&auth_token=#{auth}&folder_id=0&params%5B%5D=onelevel&params%5B%5D=nozip"
    {host, path}

  # for fetching file type
  # boxFetcher.fetchExtensions(userAuthToken, extensions, callback) 
  fetchByExtensions:(auth, extensions, callback)->
    httpsReq = https.get @fetchPath(auth), (result)->
      result.on 'data', (data)->
        boxParser = new BoxParser()
        boxParser.findExtensions data.toString(), extensions, callback
    httpsReq.end()
