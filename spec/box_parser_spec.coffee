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

 
