FROM ghcr.io/multica-ai/multica-backend:v0.3.38

RUN apk update
RUN apk --no-cache add github-cli openssh npm && \
  npm i -g opencode-ai

COPY ./entrypoint.sh .

ENTRYPOINT ["./entrypoint.sh"]
