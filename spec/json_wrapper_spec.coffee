fs = require "fs"
_ = require "underscore"

{JsonWrapper} = require "../models/json_wrapper"

describe "json wrapper", ->
  beforeEach ->
    parser = new JsonWrapper()
    fs.readFile "#{__dirname}/fixtures/boxpull.json", (err, data)=>
      @rootFolder = parser.safeWrapTree JSON.parse(data.toString())
    waitsFor (-> @rootFolder), 5000
    @addMatchers isArray: -> _.isArray @actual

  describe "wraps folders", ->
    it "leaves folder arrays alone", ->
      expect(@rootFolder.folders).isArray()
    it "wraps immediate folders", ->
      expect(@rootFolder.folders[0].folders).isArray()
    it "recursively wraps folders", ->
      expect(@rootFolder.folders[0].folders[0].folders[0].folders).isArray()

  describe "wraps files", ->
    it "wraps single files in array", ->
      expect(@rootFolder.folders[0].folders[0].folders[0].files).isArray()
    it "keeps file attributes", ->
      expect(@rootFolder.folders[0].folders[0].folders[0].files[0].file_name).toEqual "file.pdf"
    it "leaves file arrays alone", ->
      expect(@rootFolder.folders[0].folders[0].folders[1].folders[0].files).isArray()
