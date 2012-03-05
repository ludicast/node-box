_ = require "underscore"
xml2js = require('xml2js')

parser = new xml2js.Parser()

arrWrap = (item)->
  if _.isArray item
    item
  else
    [item]

class exports.BoxParser
  filterByExtension: (files, extensions)->
    _.filter files, (file)->
      extension = file.file_name.split(".").pop().toLowerCase()
      _.include extensions, extension

  findExtensions: (data, extensions, callback)->
     @createTree data, (result)=>
      filtered = @filterByExtension result.files, extensions
      callback filtered

  createTree: (data, callback)->
    parser.parseString data, (err, result)->
      files =  _.pluck arrWrap(result.tree.folder.files.file), "@"
      folders = _.pluck arrWrap(result.tree.folder.folders.folder), "@"
      callback {files,folders}

