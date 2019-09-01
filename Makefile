GOCMD=go
GOBUILD=$(GOCMD) build
GOCLEAN=$(GOCMD) clean
APPNAME=echoserver

all: build
build: deps
	$(GOBUILD) -o $(APPNAME) -v
clean:
	$(GOCLEAN)
	rm -f $(APPNAME)
	rm -f go.mod
	rm -f go.sum
run: build
	./$(APPNAME)
deps:
	@if [ ! -f "go.mod" ]; then \
	echo 'module "github.com/labstack/echo"' > go.mod; \
	echo 'require "github.com/labstack/echo/v4" v4.0.0' >> go.mod; \
	fi;
install:
	cp $(APPNAME) /usr/local/bin/$(APPNAME)
	chown 755 /usr/local/bin/$(APPNAME)
uninstall: clean
	rm -f /usr/local/bin/$(APPNAME)

