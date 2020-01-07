FROM golang:1.12 AS builder

ENV CGO_ENABLED=0

WORKDIR /hello-docker-go

ADD . .

RUN export PROJECT=$(head -n1 go.mod | awk '{ print $2 }') && go build --mod=vendor -ldflags "-s -w" -o /tmp/hello-docker-go

FROM alpine:3.7

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories && apk update && apk add --no-cache tzdata ca-certificates

RUN /bin/cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo 'Asia/Shanghai' >/etc/timezone

COPY --from=builder /tmp/hello-docker-go /hello-docker-go

EXPOSE 9090

ENTRYPOINT ["/hello-docker-go"]
