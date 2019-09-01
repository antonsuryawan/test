# golang app build
FROM golang:latest AS builder
MAINTAINER Nyoman Anton Suryawan (antonsuryawan@gmail.com)
ENV CGO_ENABLED=0\
	GOOS=linux\
	GOARCH=amd64\
	GO111MODULE=on
WORKDIR /go/src/echoserver
COPY ./main.go .
COPY ./Makefile .
RUN make

# final image
FROM alpine:latest AS echoserver-final
RUN apk update && \
	apk upgrade && \
	apk --no-cache add ca-certificates
WORKDIR /root/
COPY --from=builder /go/src/echoserver/echoserver .
EXPOSE 1323
ENTRYPOINT ["./echoserver"]

