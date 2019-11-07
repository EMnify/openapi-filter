FROM node:11.1-alpine as builder

WORKDIR /opt/openapi-filter

COPY . /opt/openapi-filter/

ENV NODE_ENV=production

# Ignore version locking to avoid undesired breaks due to changes in upstream
# hadolint ignore=DL3018
RUN apk add --no-cache git \
    && npm install

FROM node:11.1-alpine

COPY --from=builder /opt/openapi-filter/ /opt/openapi-filter/

RUN ln -s /opt/openapi-filter/openapi-filter.js /usr/local/bin/openapi-filter

WORKDIR /project

EXPOSE 5000
ENTRYPOINT ["openapi-filter"]
CMD ["-h"]