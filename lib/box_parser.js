(function() {
  var arrWrap, parser, xml2js, _;

  _ = require("underscore");

  xml2js = require('xml2js');

  parser = new xml2js.Parser();

  arrWrap = function(item) {
    if (_.isArray(item)) {
      return item;
    } else {
      return [item];
    }
  };

  exports.BoxParser = (function() {

    function BoxParser() {}

    BoxParser.prototype.filterByExtension = function(files, extensions) {
      return _.filter(files, function(file) {
        var extension;
        extension = file.file_name.split(".").pop().toLowerCase();
        return _.include(extensions, extension);
      });
    };

    BoxParser.prototype.findExtensions = function(data, extensions, callback) {
      var _this = this;
      return this.createTree(data, function(result) {
        var filtered;
        filtered = _this.filterByExtension(result.files, extensions);
        return callback(filtered);
      });
    };

    BoxParser.prototype.createTree = function(data, callback) {
      return parser.parseString(data, function(err, result) {
        var files, folders;
        files = _.pluck(arrWrap(result.tree.folder.files.file), "@");
        folders = _.pluck(arrWrap(result.tree.folder.folders.folder), "@");
        return callback({
          files: files,
          folders: folders
        });
      });
    };

    return BoxParser;

  })();

}).call(this);
