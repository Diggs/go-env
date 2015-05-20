FROM ubuntu:12.04

RUN apt-get update && apt-get install -yy curl

# Install Go
RUN \
  mkdir -p /goroot && \
  curl https://storage.googleapis.com/golang/go1.4.2.linux-amd64.tar.gz | tar xvzf - -C /goroot --strip-components=1

# Set environment variables.
ENV GOROOT /goroot
ENV GOPATH /gopath
ENV PATH $GOROOT/bin:$GOPATH/bin:$PATH

RUN mkdir -p /gopath/src/go-env
COPY . /gopath/src/go-env

WORKDIR /gopath/bin

RUN go build go-env
RUN rm -rf /goroot

EXPOSE 8080

CMD go-env
