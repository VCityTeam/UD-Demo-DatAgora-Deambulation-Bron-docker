FROM ubuntu:focal

LABEL maintainer "VCityTeam"
LABEL source.repo "https://github.com/VCityTeam/UD-Viz-Template-docker"

######### Install packages required by UD-Viz demo
# We don't want any interaction from package installation during the docker image building.
ARG DEBIAN_FRONTEND=noninteractive
# Some packages are not available without a preliminary update.
RUN apt-get update
#
RUN apt-get install -y --no-install-recommends curl wget
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash -
RUN apt-get install -y --no-install-recommends nodejs npm
RUN node --version
RUN npm --version
RUN apt-get install -y --no-install-recommends git
RUN git --version

######### Get other repos
COPY getRepoCommit.sh /
############# ExpressJS server
WORKDIR /
RUN ./getRepoCommit.sh https://github.com/VCityTeam/UD-SimpleServer 4cad0d14d9a22ca3af7804ceff71ae3455389d9f
WORKDIR UD-SimpleServer
RUN npm install
############# The demo
WORKDIR /
RUN ./getRepoCommit.sh https://github.com/VCityTeam/UD-Demo-DatAgora-Deambulation-Bron 72e6c0f4b1942b8ac7b38d5eda55888218fdaee1
WORKDIR UD-Demo-DatAgora-Deambulation-Bron
RUN ./install.sh
RUN npm run build

WORKDIR /
EXPOSE 80
CMD [ "node", "UD-SimpleServer/index.js", "UD-Demo-DatAgora-Deambulation-Bron", "80" ]
