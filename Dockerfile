FROM golang:1.15.8 as builder

WORKDIR /go/src/

COPY . .
RUN go mod download

ARG CGO_ENABLED=0
ARG GOOS=linux
ARG GOARCH=amd64
RUN go build -o ./bin/example ./example-app/
FROM alpine:3.12 as runner

COPY --from=builder /go/src/bin/example ./example

ENTRYPOINT ["./example"]