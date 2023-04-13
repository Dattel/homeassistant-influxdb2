# Home Assistant Community Add-on: InfluxDB2

InfluxDB is an open source time series database optimized for high-write-volume.
It's useful for recording metrics, sensor data, events,
and performing analytics. It exposes an HTTP API for client interaction and is
often used in combination with Grafana to visualize the data.

This add-on runs the InfluxDB v2.x build channel. \
For InfluxDB v1.x build channel, remove this add-on and install https://github.com/hassio-addons/addon-influxdb

## Installation
..
## First Run
..
## Configuration
..
### Options
..
## Integration into Homeassistant
..
## Known issues and limitations
..
## Changelog & Releases
..
## Support
..
## Author
..
## License
..
## InfluxDB -> InfluxDB2 Migration
..
### Export data from InfluxDB1.x

Open a shell on your homeassistant system and execute the following commandline to export all data from your 1.X database to a file

```bash
docker exec addon_a0d7b954_influxdb \
	influx_inspect export \
	-datadir "/data/influxdb/data" \
	-waldir "/data/influxdb/wal" \
	-out "/share/influxdb/home_assistant/export" \
	-database homeassistant \
	-retention autogen \
	-lponly
```
### Importing 1.X File to 2.X

I would suggest, opening a direct shell to the new container. I had some timeouts during import if i execute these the same "docker exec.." way as the export works
replace @token@ and @orgid@ with your values

```bash
docker exec -it addon_ec9cbdb7_influxdb2 /bin/bash
export INFLUX_TOKEN=@token@
export INFLUX_ORG_ID=@orgid@

influx write \
	--bucket homeassistant \
	--file "/share/influxdb/home_assistant/export" \
```

## V1 Kompatiblität

If you need v1.x compatiblity for e.g. grafana, you have to create a retention policy for the database and a user for authentification. Replace the @bucket@ with 
your value.

#### Retention Policy
```bash
influx v1 dbrp create \
	--db homeassistant \
	--rp autogen \
	--bucket-id @bucket@ \
	--default
```

#### Create User for authentification ====

```bash
influx v1 auth create \
  --read-bucket @bucket@ \
  --write-bucket @bucket@ \
  --username homeassistant
```

---------------------

# Downsampling?

## Downsample all old data

```bash
from(bucket: "homeassistant")
  |> range(start: 2020-06-03T00:00:00Z)
  |> filter(fn: (r) => r["_field"] == "value")
  |> aggregateWindow(every: 15m, fn: mean, createEmpty: false)
  |> set(key: "agg_type", value: "mean")
  |> to(bucket: "homeassistant_15m", org: "privat", tagColumns: ["agg_type", "domain", "entity_id", "friendly_name", "source"])
```

```
from(bucket: "homeassistant")
  |> range(start: 2020-06-03T00:00:00Z)
  |> filter(fn: (r) => r["_field"] == "value")
  |> aggregateWindow(every: 1h, fn: mean, createEmpty: false)
  |> set(key: "agg_type", value: "mean")
  |> to(bucket: "homeassistant_60m", org: "privat", tagColumns: ["agg_type", "domain", "entity_id", "friendly_name", "source"])
```

## Create a Influx Task for downsampling all new data

```bash
option task = {name: "Downsample_15m", every: 15m, offset: 0m}

from(bucket: "homeassistant")
    |> range(start: -task.every)
    |> filter(fn: (r) => r["_field"] == "value")
    |> aggregateWindow(every: 15m, fn: mean, createEmpty: false)
    |> to(bucket: "homeassistant_15m", org: "privat")
```    

```bash
option task = {name: "Downsample_60m", every: 1h, offset: 0m}

from(bucket: "homeassistant")
    |> range(start: -task.every)
    |> filter(fn: (r) => r["_field"] == "value")
    |> aggregateWindow(every: 1h, fn: mean, createEmpty: false)
    |> to(bucket: "homeassistant_60m", org: "privat")
```

