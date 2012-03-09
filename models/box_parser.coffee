_ = require "underscore"
xml2js = require('xml2js')
{JsonWrapper} = require "../models/json_wrapper"

parser = new xml2js.Parser(mergeAttrs:true)

class exports.BoxParser
  filterByExtension: (files, extensions)->
    _.filter files, (file)->
      extension = file.file_name.split(".").pop().toLowerCase()
      _.include extensions, extension

  findExtensions: (data, extensions, callback)->
     @createTree data, (result)=>
      filtered = @filterByExtension result.files, extensions
      callback filtered

  createTree: (xmlData, callback)->
     parser.parseString xmlData, (err, jsonData)=>
       callback @cleanTree(jsonData)

  cleanTree: (data, callback)->
    wrapper = new JsonWrapper()
    wrapper.safeWrapTree data
