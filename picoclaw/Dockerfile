FROM golang:1.25-alpine AS builder

RUN apk add --no-cache git make

WORKDIR /src

RUN git clone https://github.com/sipeed/picoclaw .

RUN go mod download

RUN make build

FROM debian:trixie-slim

RUN apt-get update && apt-get install -y --no-install-recommends ca-certificates git

COPY --from=builder /src/build/picoclaw /usr/local/bin/picoclaw

RUN groupadd -g 1000 picoclaw && \
    useradd -m -u 1000 -g picoclaw picoclaw

USER picoclaw

ENTRYPOINT ["picoclaw"]
CMD ["gateway"]
