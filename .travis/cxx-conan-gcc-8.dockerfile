FROM sirvestnik/cxx-conan-base:latest

RUN echo "deb http://mirror.yandex.ru/debian sid main" > /etc/apt/sources.list.d/10-sid-backports.list && \
    echo "APT::Default-Release "stable";" > /etc/apt/apt.conf.d/10-default-release && \
    apt-get update && \
    apt-get -y --no-install-recommends -t sid install \
      gcc-8 g++-8 libstdc++-8-dev libgcc-8-dev \
    && \
    apt-get -y clean && \
    rm -rf /var/lib/apt/lists

VOLUME /home/builder/src
USER builder
ENV CC gcc-8
ENV CXX g++-8
RUN mkdir /home/builder/build && conan profile new --detect default
ADD settings.yml /home/builder/.conan/
WORKDIR /home/builder/build

CMD ["libstdc++11", "Release"]
ENTRYPOINT ["/home/builder/src/.travis/autobuild.sh"]
