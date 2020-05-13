FROM golang:alpine AS builder
RUN mkdir -p /go/src/github.com/affix/lnk.kfj.io
RUN apk -U add git alpine-sdk ca-certificates

WORKDIR /go/src/github.com/affix/lnk.kfj.io

COPY . .

RUN go test -v ./...

# Stripping via -ldflags "-s -w"
RUN CGO_ENABLED=0 GOOS=linux go build -a -ldflags "-s -w" -installsuffix cgo -o build ./...
RUN ls /go/src/github.com/affix/lnk.kfj.io/
FROM scratch

COPY --from=builder /go/src/github.com/affix/lnk.kfj.io/build ./cmd
CMD ["./cmd"]