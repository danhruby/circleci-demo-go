GOFILES = $(shell find . -name '*.go')

default: build

workdir:
	mkdir -p workdir

build: 
	workdir/contacts

build-native: $(GOFILES)
	go build -o workdir/native-contacts .

workdir/contacts: $(GOFILES)
	GOOS=linux GOARCH=amd64 CGO_ENABLED=0 go build -o workdir/contacts .

image: 
	docker build --ssh default -t danhruby/circle-ci-demo:latest -t danhruby/circle-ci-demo:latest --progress=plain .

publish:
	docker push danhruby/circle-ci-demo:latest