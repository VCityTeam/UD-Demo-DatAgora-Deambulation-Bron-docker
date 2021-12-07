FROM ubuntu:focal

LABEL maintainer "VCityTeam"
LABEL source.repo "https://github.com/VCityTeam/UD-Viz-Template-docker"

# We don't want any interaction from package installation during the docker image building.
ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update

######### Install packages required by UD-Viz demo
RUN apt-get install -y --no-install-recommends curl
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash -
RUN apt-get install -y --no-install-recommends nodejs npm
RUN node --version
RUN npm --version
RUN apt-get install -y --no-install-recommends git
RUN git --version

######### Install the ExpressJS server from repo
WORKDIR /
#RUN git clone https://github.com/VCityTeam/UD-SimpleServer
#RUN git checkout 4cad0d14d9a22ca3af7804ceff71ae3455389d9f
RUN mkdir UD-SimpleServer
WORKDIR UD-SimpleServer
RUN git init
RUN git remote add origin https://github.com/VCityTeam/UD-SimpleServer
RUN git fetch --depth 1 origin 4cad0d14d9a22ca3af7804ceff71ae3455389d9f
RUN git checkout FETCH_HEAD
#WORKDIR UD-SimpleServer
RUN npm install

######### Install UD-Viz specific branch from repo
WORKDIR /
#RUN git clone --branch webanck-demo-bron https://github.com/VCityTeam/UD-Viz
#RUN git checkout 10fa18b25ca68bdbe5e307bdb26ac4c45d535ecc
RUN mkdir UD-Viz
WORKDIR UD-Viz
RUN git init
RUN git remote add origin https://github.com/VCityTeam/UD-Viz
RUN git fetch --depth 1 origin 10fa18b25ca68bdbe5e307bdb26ac4c45d535ecc
RUN git checkout FETCH_HEAD
#WORKDIR UD-Viz
RUN npm install

######### Install demo from repo
WORKDIR /
#RUN git clone https://github.com/VCityTeam/UD-Demo-DatAgora-Deambulation-Bron
#RUN git checkout 7f46cff17ccc412d0ef96e1e476a0af7160791e8
RUN mkdir UD-Demo-DatAgora-Deambulation-Bron
WORKDIR UD-Demo-DatAgora-Deambulation-Bron
RUN git init
RUN git remote add origin https://github.com/VCityTeam/UD-Demo-DatAgora-Deambulation-Bron
RUN git fetch --depth 1 origin 7f46cff17ccc412d0ef96e1e476a0af7160791e8
RUN git checkout FETCH_HEAD
#WORKDIR UD-Demo-DatAgora-Deambulation-Bron
RUN npm install
RUN npm run build

######### Download demo assets
WORKDIR assets/models
RUN curl -sL "https://dataset-dl.liris.cnrs.fr/vcity-sample-data/bron-2018-campus/map.glb" --output map.glb
RUN curl -sL "https://dataset-dl.liris.cnrs.fr/vcity-sample-data/bron-2018-campus/campus.glb" --output campus.glb

WORKDIR /
EXPOSE 80
#CMD [ "/bin/bash" ]
CMD [ "node", "UD-SimpleServer/index.js", "UD-Demo-DatAgora-Deambulation-Bron", "80" ]
