# Home Assistant Add-ons: InfluxDB2

![HA Ingress Support][influxdb2-ingressSupport]
![Local Build][influxdb2-local-build]
![GitHub Release][influxdb2-releases-shield]
![Project Stage][influxdb2-project-stage-shield]
[![License][influxdb2-license-shield]](LICENSE.md)

![Supports amd64 Architecture][influxdb2-amd64-shield]
![Supports aarch64 Architecture][influxdb2-aarch64-shield]
![Supports armhf Architecture][influxdb2-armhf-shield]
![Supports armv7 Architecture][influxdb2-armv7-shield]
![Supports i386 Architecture][influxdb2-i386-shield]
![Project Maintenance][influxdb2-maintenance-shield]
[![GitHub Activity][influxdb2-commits-shield]][commits]

Homeassistant Addon for InfluxDB2

Scalable datastore for metrics, events, and real-time analytics.

## About

InfluxDB2 is an open source time series database optimized for high-write-volume.
It's useful for recording metrics, sensor data, events,
and performing analytics. It exposes an HTTP API for client interaction and is
often used in combination with Grafana to visualize the data.

This add-on is built on the InfluxDB v2.x build. \
If you're after the InfluxDB V1.x build - check out this other add-on [Here][Influxdbv1]

[WorkInProgress:Read the full add-on documentation][docs]

## FAQ

- Why make another add-on and why not just upgrade the current [InfluxDB v1.x Community Add-on][Influxdbv1]?
  - The upgrade path from V1.x to V2.x requires access to the command line and isn't a very user friendly process. So I decided to create a new add-on and start from there.
- This doesn't support Home Assistant Ingress web interface - why not?
  - Unfortunately the way the ingress works requires the application to support a Base URL rewrite of some form and the InfluxDB2 project currently doesn't.
- Are kapacitor and chronograf both still avaliable in this build?
  - No, neither are included as InfluxDB2 now includes a UI and most features from these other packages.

## Support

Got questions?

You have several options to get them answered:

- Try the [discussion page][githubDiscussions] here on GitHub
- The [Home Assistant Discord chat server][discord-ha] for general Home
  Assistant discussions and questions
- The Home Assistant [Community Forum][forum].

You could also [open an issue here][issue] on GitHub.

## How to Install

Just click this link and follow the instructions to add the repository

<a href="https://my.home-assistant.io/redirect/supervisor_add_addon_repository/?repository_url=https%3A%2F%2Fgithub.com%2Fdattel%2Fhomeassistant-influxdb2"><img src="https://my.home-assistant.io/badges/supervisor_addon.svg" target="_blank"></img></a>

## Contributing

This is an active open-source project. Please use the code or contribute to it.

## Authors & contributors

This repository is maintained by [Daniel][dattel] \
But the original idea behind the InfluxDB2 Addon setup is by [Jay Antoney][jantoney]. \
However we are both using the InfluxDB v1.x add-on from [Franck Nijhof][frenck] for some inspiration.

For a full list of all authors and contributors,
check [the contributor's page][contributors].

Special Thanks to [@smoki3](https://github.com/Dattel/homeassistant-influxdb2/issues/5) for "forcing" me to spend my time on making INGRESS work :-D


## License

MIT License

Copyright (c) 2024 Daniel Tammer

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

[Influxdbv1]: https://github.com/hassio-addons/addon-influxdb
[dattel]: https://github.com/dattel
[jantoney]: https://github.com/jantoney
[frenck]: https://github.com/frenck
[contributors]: https://github.com/Dattel/homeassistant-influxdb2/graphs/contributors
[docs]: https://github.com/Dattel/homeassistant-influxdb2/blob/main/influxdb2/DOCS.md
[issue]: https://github.com/Dattel/homeassistant-influxdb2/issues
[githubDiscussions]: https://github.com/hassio-addons/addon-influxdb/discussions
[discord-ha]: https://discord.com/invite/home-assistant
[forum]: https://community.home-assistant.io/
[influxdb2-local-build]: https://img.shields.io/badge/Home%20Assistant%20--%20local%20build-YES-orange.svg
[influxdb2-ingressSupport]: https://img.shields.io/badge/Home%20Assistant%20--%20ingress%20support-experimental-yellow
[influxdb2-aarch64-shield]: https://img.shields.io/badge/aarch64-untested-orange.svg
[influxdb2-amd64-shield]: https://img.shields.io/badge/amd64-yes-green.svg
[influxdb2-armhf-shield]: https://img.shields.io/badge/armhf-yes-green.svg
[influxdb2-armv7-shield]: https://img.shields.io/badge/armv7-yes-green.svg
[influxdb2-i386-shield]: https://img.shields.io/badge/i386-no-red.svg
[influxdb2-releases-shield]: https://img.shields.io/github/v/release/Dattel/homeassistant-influxdb2.svg
[influxdb2-commits-shield]: https://img.shields.io/github/commit-activity/y/Dattel/homeassistant-influxdb2.svg
[influxdb2-maintenance-shield]: https://img.shields.io/maintenance/yes/2024.svg
[influxdb2-project-stage-shield]: https://img.shields.io/badge/project%20stage-Early%20stage-yellow.svg
[influxdb2-license-shield]: https://img.shields.io/github/license/Jays-Home-Assistant-Add-ons/j-addon-influxdb2.svg
[commits]: https://github.com/Dattel/homeassistant-influxdb2/commits/main
