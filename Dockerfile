FROM docker:19.03.2 as runtime

LABEL "repository"="https://github.com/mlycore/Publish-Docker-Github-Action"
LABEL "maintainer"="mlycore"

RUN apk update \
  && apk upgrade \
  && apk add --no-cache git

ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

FROM runtime as testEnv
RUN apk add --no-cache coreutils bats ncurses
ADD test.bats /test.bats
ADD stub.sh /usr/local/bin/docker
ADD mock.sh /usr/bin/date
#RUN /test.bats

FROM runtime
