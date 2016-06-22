# .PHONY: all build linux release
#
# all: build
#
# build:
# 	go build

# release-docker: linux
# 	docker build -t rjocoleman/simple-proxy .
# 	docker push rjocoleman/simple-proxy
#
# release-binary: linux windows darwin

TAG:=`git describe --abbrev=0 --tags --always`

dist-clean:
	rm -rf dist
	rm -f simple-proxy-*.tar.gz

dist-init:
	mkdir -p dist/$$GOOS/$$GOARCH

dist-build: dist-init
	go build -o dist/$$GOOS/$$GOARCH/simple-proxy$$SUFFIX

dist-linux-amd64:
	GOOS=linux GOARCH=amd64 $(MAKE) dist-build

dist-darwin-amd64:
	GOOS=darwin GOARCH=amd64 $(MAKE) dist-build

dist-windows-amd64:
	SUFFIX=.exe GOOS=windows GOARCH=amd64 $(MAKE) dist-build

dist: dist-clean dist-init dist-linux-amd64 dist-darwin-amd64 dist-windows-amd64

release-tarball:
	echo "Building $$GOOS-$$GOARCH-$(TAG).tar.gz"
	GZIP=-9 tar -cvzf simple-proxy-$$GOOS-$$GOARCH-$(TAG).tar.gz -C dist/$$GOOS/$$GOARCH simple-proxy$$SUFFIX >/dev/null 2>&1

release-linux-amd64:
	GOOS=linux GOARCH=amd64 $(MAKE) release-tarball

release-darwin-amd64:
	GOOS=darwin GOARCH=amd64 $(MAKE) release-tarball

release-windows-amd64:
	SUFFIX=.exe GOOS=windows GOARCH=amd64 $(MAKE) release-tarball

release-docker:
	cp dist/linux/amd64/simple-proxy .
	docker build -t rjocoleman/simple-proxy .
	docker push rjocoleman/simple-proxy

release: dist release-linux-amd64 release-darwin-amd64 release-windows-amd64 release-docker
