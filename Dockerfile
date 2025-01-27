FROM golang:alpine AS build-env
ENV GOOS=linux GOARCH=amd64 CGO_ENABLED=0
COPY . /build
WORKDIR /build
RUN go build -o exporter

FROM gcr.io/distroless/static
WORKDIR /app
COPY --from=build-env /build/exporter /app/
ENTRYPOINT ["./exporter"]