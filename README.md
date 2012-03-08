# node.js library for box.{net,com}

This library is still under construction and for a particular use-case.  Anybody who wants to add code is more than welcome (taking usual steps of course).

## Installation

    npm install nodebox

## Usage

Right now the only exported function is `fetchByExtensions`, which pulls in files from your top-level directory.  All these files match an extension in an array you put in.  It is used as so:

    {BoxFetcher} = require "node-box"
    boxFetcher = new BoxFetcher(myApiKey)

    ... and then ...

    authToken = somehowGetTokenFromSession()
    boxFetcher.fetchExtensions token, ["jpg", "gif", "png"], (images)->
      # do stuff to images

## How do I test

If you have `jasmine-node` installed:

    jasmine-node --coffee spec/

## A note on coffeescript

All code, tests and samples are right now written in coffeescript.  However, the outputted npm is usable in vanilla js projects all the same.
