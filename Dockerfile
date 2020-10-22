FROM ubuntu:xenial-20200916 AS packer-build

LABEL maintainer="Jerry Warren <jerry@forged-concepts.com>"

# Install package dependencies
RUN apt-get update && \
  apt-get install -y apt-transport-https curl lsb-core software-properties-common

# Install packer
RUN curl -fsSL https://apt.releases.hashicorp.com/gpg | apt-key add - && \
  apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main" && \
  apt-get update && \
  apt-get install -y packer

# Install session-manager
RUN curl "https://s3.amazonaws.com/session-manager-downloads/plugin/latest/ubuntu_64bit/session-manager-plugin.deb" -o "session-manager-plugin.deb" && \
  dpkg -i session-manager-plugin.deb


FROM ubuntu:xenial-20200916

# copy over packer
COPY --from=packer-build /usr/bin/packer /usr/bin/packer
COPY --from=packer-build /usr/share/doc/packer /usr/share/doc/packer

# copy over session-manager
COPY --from=packer-build /usr/share/lintian/overrides/sessionmanagerplugin /usr/share/lintian/overrides/sessionmanagerplugin
COPY --from=packer-build /etc/init/session-manager-plugin.conf /etc/init/session-manager-plugin.conf
COPY --from=packer-build /lib/systemd/system/session-manager-plugin.service /lib/systemd/system/session-manager-plugin.service
COPY --from=packer-build /usr/share/doc/sessionmanagerplugin /usr/share/doc/sessionmanagerplugin
COPY --from=packer-build /usr/local/sessionmanagerplugin /usr/local/sessionmanagerplugin

WORKDIR /
ENTRYPOINT [ "/bin/packer" ]
CMD ["--help"]