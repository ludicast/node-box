(function() {
  var BoxParser, https;

  BoxParser = require("./box_parser").BoxParser;

  https = require('https');

  exports.BoxFetcher = (function() {

    function BoxFetcher(boxKey) {
      this.boxKey = boxKey;
    }

    BoxFetcher.prototype.fetchPath = function(auth) {
      var host, path;
      host = "ww.box.net";
      path = "/api/1.0/rest?action=get_account_tree&api_key=" + this.boxKey + "&auth_token=" + auth + "&folder_id=0&params%5B%5D=onelevel&params%5B%5D=nozip";
      return {
        user: user,
        path: path
      };
    };

    BoxFetcher.prototype.fetchByExtensions = function(auth, extensions, callback) {
      var httpsReq;
      httpsReq = https.get(this.fetchPath(auth), function(result) {
        return result.on('data', function(data) {
          var boxParser;
          boxParser = new BoxParser();
          return boxParser.findExtensions(data.toString(), extensions, callback);
        });
      });
      return httpsReq.end();
    };

    return BoxFetcher;

  })();

}).call(this);
