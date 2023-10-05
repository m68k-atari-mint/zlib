ARG BUILD_DIR=/build

FROM mikrosk/m68k-atari-mint-base:master as build
RUN apt -y update
RUN apt -y install make wget

WORKDIR /src
COPY build.sh .

# renew the arguments
ARG BUILD_DIR

ENV ZLIB_VERSION        1.3
ENV ZLIB_URL            https://www.zlib.net/zlib-${ZLIB_VERSION}.tar.gz
ENV ZLIB_FOLDER         zlib-${ZLIB_VERSION}
RUN wget -q -O - ${ZLIB_URL} | tar xzf -

RUN cd ${ZLIB_FOLDER} \
    && ../build.sh ${BUILD_DIR}

FROM scratch

# renew the arguments
ARG BUILD_DIR

COPY --from=build ${BUILD_DIR} /
