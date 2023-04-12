# Home Assistant Add-ons: InfluxDB2
Homeassistant Addon for InfluxDB2

Scalable datastore for metrics, events, and real-time analytics.

## About

InfluxDB2 is an open source time series database optimized for high-write-volume.
It's useful for recording metrics, sensor data, events,
and performing analytics. It exposes an HTTP API for client interaction and is
often used in combination with Grafana to visualize the data.

This add-on is built on the InfluxDB v2.x build.

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

You could also [open an issue here][issue] on GitHub.

## Contributing

This is an active open-source project. Please use the code or contribute to it.


## Authors & contributors

The original idea behind the InfluxDB2 Addon setup is by [Jay Antoney][jantoney]. \
However I used the InfluxDB v1.x add-on from [Franck Nijhof][frenck] for some inspiration.

For a full list of all authors and contributors,
check [the contributor's page][contributors].

## License

MIT License

Copyright (c) 2023 Danie Tammer

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
[jantoney]: https://github.com/jantoney
[frenck]: https://github.com/frenck
[contributors]: https://github.com/Dattel/homeassistant-influxdb2/graphs/contributors
[issue]: https://github.com/Dattel/homeassistant-influxdb2/issues
