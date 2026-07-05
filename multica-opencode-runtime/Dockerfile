FROM ghcr.io/multica-ai/multica-backend:v0.3.38

RUN apk update && apk add npm && npm i -g opencode-ai
COPY ./entrypoint.sh .

ENTRYPOINT ["./entrypoint.sh"]
