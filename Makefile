.PHONY: build linux clean test helm

all: build

build:
	go build -o gabi cmd/gabi/main.go

linux:
	CGO_ENABLED=0 GOOS=linux go build -ldflags '-s -w' -o gabi cmd/gabi/main.go

clean:
	rm -f gabi

test:
	go test ./...

helm:
	@if [ -z "$(HELM_PARAMS)" ]; then \
	  echo "Error: HELM_PARAMS variables is not set. Use 'make helm HELM_PARAMS=\"--set splunk.token=<token> --set splunk.endpoint=<endpoint>\"'"; \
	  exit 1; \
	else \
	  helm template helm/ ${HELM_PARAMS}; \
	fi;
