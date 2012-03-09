_ = require "underscore"
xml2js = require('xml2js')

parser = new xml2js.Parser(mergeAttrs:true)

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

  createTree: (xmlData, callback)->
     parser.parseString xmlData, (err, jsonData)=>
       callback @cleanTree(jsonData)

  cleanTree: (data, callback)->
    files = arrWrap data.tree.folder.files.file
    folders = arrWrap data.tree.folder.folders.folder
    data.tree.folder

  safeWrapFolders: (folders)->
    folders.folder = arrWrap folders.folder
    for folder in folders.folder
      if folder.folders
        @safeWrapFolders folder.folders
      if folder.files
        folder.files.file = arrWrap folder.files.file

  safeWrapTree: (obj)->
    @safeWrapFolders(obj.tree.folder.folders)
    obj

