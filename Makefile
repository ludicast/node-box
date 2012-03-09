.PHONY: all clean

COFFEE:=coffee#./node_modules/.bin/coffee

#### General

all: build

build: models/*coffee
	@$(COFFEE) -v > /dev/null
	$(COFFEE) -o lib/ -c models/*.coffee

clean:
	rm -f lib/*.js

