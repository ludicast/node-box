{BoxParser} = require "../models/box_parser"
fs = require "fs"
_ = require "underscore"

describe "box parser", ->

  describe "lets us filter by extension", ->
    beforeEach ->
      parser = new BoxParser()
      fs.readFile "#{__dirname}/fixtures/boxpull.xml", (err, data)=>
        parser.findExtensions data.toString(), ["jpg"], (@images)=>
      waitsFor (-> @images), 5000

    it "pulls images from data", ->
      expect(@images.length).toEqual 1
    it "assigns the file name", ->
      expect(@images[0].file_name).toEqual "2012-01-10 12.46.50.jpg"


  describe "wrapper", ->
    beforeEach ->
      parser = new BoxParser()
      fs.readFile "#{__dirname}/fixtures/boxpull.json", (err, data)=>
        @object = parser.safeWrapTree JSON.parse(data.toString())
      waitsFor (-> @object), 5000
      @addMatchers isArray: (tt)-> _.isArray(@actual)

    describe "wraps folders", ->

      it "leaves folder arrays alone", ->
        expect(@object.tree.folder.folders.folder).isArray()
      it "wraps immediate folders", ->
        expect(@object.tree.folder.folders.folder[0].folders.folder).isArray()
      it "recursively wraps folders", ->
        expect(@object.tree.folder.folders.folder[0].folders.folder[0].folders.folder[0].folders.folder).isArray()

    describe "wraps files", ->
      it "wraps single files in array", ->
        expect(@object.tree.folder.folders.folder[0].folders.folder[0].folders.folder[0].files.file).isArray()
      it "leaves file arrays alone", ->
        expect(@object.tree.folder.folders.folder[0].folders.folder[0].folders.folder[1].folders.folder[0].files.file).isArray()
