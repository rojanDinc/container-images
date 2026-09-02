FROM ghcr.io/multica-ai/multica-backend:v0.4.38

RUN apk update
RUN apk --no-cache add github-cli openssh npm

COPY ./entrypoint.sh .

ENTRYPOINT ["./entrypoint.sh"]
