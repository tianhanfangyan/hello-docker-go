FROM golang:1.11.1 AS builder

WORKDIR ${GOPATH}/src/http_server

ADD . .

RUN CGO_ENABLED=0 go build -ldflags "-s -w" -o /server

FROM alpine:3.7

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories && apk update && apk add --no-cache tzdata ca-certificates

RUN /bin/cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo 'Asia/Shanghai' >/etc/timezone

COPY --from=builder /server /server

EXPOSE 9090

ENTRYPOINT ["/server"]
