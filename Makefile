.PHONY: all clean

COFFEE:=./node_modules/.bin/coffee

#### General

all: build

build: src/coffee
	@$(COFFEE) -v > /dev/null
	$(COFFEE) -o lib/ -c models/*.coffee

clean:
	rm -f lib/*.js

