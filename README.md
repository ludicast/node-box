# node.js library for box.net

This library is still under construction and for a particular use-case.  Anybody who wants to add code is more than welcome (taking usual steps of course).

## Installation

Add to package.json: `"node-box": "git://github.com/ludicast/node-box"`.

## Usage

Right now the only exported function is `fetchByExtensions`, which pulls in files from your top-level directory.  All these files match an extension in an array you put in.  It is used as so:

    {BoxFetcher} = require "node-box"
    boxFetcher = new BoxFetcher(myApiKey)

    ... and then ...

    authToken = somehowGetTokenFromSession()
    boxFetcher.fetchExtensions token, ["jpg", "gif", "png"], (images)->
      # do stuff to images
