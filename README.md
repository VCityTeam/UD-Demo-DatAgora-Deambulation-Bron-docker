# Demo Deambulation Bron

Create a docker of a [demo of Bron in which to wander](https://github.com/VCityTeam/UD-Demo-Deambulation-Bron).
_See the [online version](https://deambulation-bron.vcityliris.data.alpha.grandlyon.com/)_.

The demo uses a [SimpleServer](https://github.com/VCityTeam/UD-SimpleServer), based on [ExpressJS](https://en.wikipedia.org/wiki/Express.js) web-server.

Clone the repo :

```bash
git clone https://github.com/VCityTeam/UD-Demo-Deambulation-Bron-docker.git
cd UD-Demo-Deambulation-Bron-docker
```

Build the docker image with

```bash
docker build -t demo_bron .
```

and run the container with

```bash
docker run -p 8084:80/tcp -t demo_bron
```

and open a web browser on URL `http://localhost:8084/`
