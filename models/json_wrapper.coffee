_ = require "underscore"

arrWrap = (item)->
  if _.isArray item
    item
  else
    [item]

class exports.JsonWrapper
  safeWrapFolders: (folder)->
    folder.folders = if folder.folders
      arrWrap folder.folders.folder
    else
      []

    folder.files = if folder.files
      arrWrap folder.files.file
    else
      []

    for subFolder in folder.folders
      @safeWrapFolders subFolder

  safeWrapTree: (obj)->
    @safeWrapFolders(obj.tree.folder)
    obj.tree.folder

