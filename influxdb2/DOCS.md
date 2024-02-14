# Home Assistant Community Add-on: InfluxDB2

InfluxDB is an open source time series database optimized for high-write-volume.
It's useful for recording metrics, sensor data, events,
and performing analytics. It exposes an HTTP API for client interaction and is
often used in combination with Grafana to visualize the data.

This add-on runs the InfluxDB v2.x build channel. \
For InfluxDB v1.x build channel, remove this add-on and install https://github.com/hassio-addons/addon-influxdb

## Installation

Just click this link and follow the instructions to add the repository

<a href="https://my.home-assistant.io/redirect/supervisor_add_addon_repository/?repository_url=https%3A%2F%2Fgithub.com%2Fdattel%2Fhomeassistant-influxdb2"><img src="https://my.home-assistant.io/badges/supervisor_addon.svg" target="_blank"></img></a>

## First Run

Make sure, that the required port `8086` is not in use by another Addon (InfluxDB) or just alter it to another port. I'm going with `8087`. You can just change the post in the addon configurations.

After the plugin has been started, please navigate to it's landing page by replacing the ip and the port in the following URL:
http://192.168.1.x:8087

On the first run, you have to create a `username`, `password`.

If you are presented with an `API-Token` please note it down, you will need it later in your homeassistant configuration

Afterwards you need to create an `orgID` and a `bucket`.

## Configuration

Adding the following snippets to your `secrets.yaml` and alter it on your needs.
Your ORG-ID can be obtained by reading it from your URL:
(http://192.168.178.1:8087/orgs/\<ORGID\>)

The API-Token should be written down during the first run.

```yaml
influx_apiToken: <your API-Token>
influx_orgID: <Your ORG-ID>
```

Adding the following snippet to your `configuration.yaml` and alter it on your needs
. Especially ignore_attributes and entities. After that, please restart Homeassistant to take affect of your changes

```yaml
#InfluxDB2
influxdb:
  host: localhost
  port: 8087
  api_version: 2
  max_retries: 3
  default_measurement: state
  token: !secret influx_apiToken
  organization: !secret influx_orgID
  bucket: home_assistant
  ssl: false
  veryify_ssl: false
  ignore_attributes:
    - device_class
    - device_type
    - icon
    - source
    - state_class
    - status
    - child_lock
    - linkquality
    - update_str
    - update_available
    - indicator_mode
    - voltage
    - power
    - power_outage_memory
    - latest_version
    - installed_version
    - update
    - power_outage_memory
    - energy
    - current
    - battery
    - humidity
    - temperature
  include:
    entities:
      - sensor.rf433_temp_garten
      - sensor.RF433_temp_pool
      - sensor.stromzaehler_powerconsumption
```

### Options

- log_level : setting up a general loglevel for the plugin
- influxd_log_level : you can set up your separate loglevel for the influxd service. thats because the service supports less options as log_level and they are named different

## Integration into Homeassistant

The plugin is started and updated as homeassistant addon.

## Known issues and limitations

Currently there is no working way to use ingress for the influxdb2 frontent. You have to open the frontend in a separate window.

## Changelog & Releases

Please see the changelog

## Support

I'm trying to support the plugin as long as it's possible. These plugin is only a hobby-project since there is currently no other working influxdb2 plugin available for homeassistant.

If there is any official plugin available in the future, these plugin here will eventually become stale.

In case you found a bug or have a feature request, please open an issue here:
https://github.com/Dattel/homeassistant-influxdb2/issues

Please keep in mind, that i'm not responsible for any bugs related to the influx database itself because i just use the latest precompliled binaries provided by the author.

## License

You are free to use and modify these plugin but please respect the license for the underlaying influxdb2 and influx-cli binaries

## InfluxDB -> InfluxDB2 Migration

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

The following steps only works for supervised installations.

For HassIO please have a look as https://github.com/hassio-addons/addon-influxdb/discussions/113#discussioncomment-6947661 (many thanks to https://github.com/mbalasz for the documentation)

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

### Migration from official Influxdb Addon
```bash
docker ps -a # Descibe the containers running and finding the Ids.
docker exec -it addon_xxxxx_influxdb /bin/bash # Enter the v1 container. Replace addon_xxxxx_influxdb with the v1 Id
influx_inspect export -compress -database homeassistant -out /data/exports/influxdb.gz -lponly -datadir /data/influxdb/data -waldir /data/influxdb/wal # Export the influxdb timeseries data
exit # Exit container to host
docker cp addon_xxxxx_influxdb:/data/exports/influxdb.gz /root/ # Copy the backup to host
docker cp /root/influxdb.gz addon_xxxxx_influxdbv2:/data/influxdb.gz # Copy the backup to the v2 container (Make sure it's started)
docker exec -it addon_xxxxx_influxdbv2 /bin/bash # Enter the v2 container. Replace addon_xxxxx_influxdbv2 with the v2 Id
influx write \
  --org-id homeassistant \
  --bucket homeassistant \
  --file /data/influxdb.gz \
  --token TOKEN # Replace TOKEN with your InfluxDB2 token.
rm /data/influxdb.gz # Remove backup from v2 container
exit
rm /influxdb.gz # Remove backup from host
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

---

# Downsampling?

Downsampling reduces the amount of datapoints in your database. So its easier and faster to work with data over a long period of time.

Personally, i've created 2 buckets. The first buckets holds a datapoint every 15 minutes and the second bucket holds a datapoint every 60 minutes.

## 1. Downsample all existing data to the new buckets

```bash
from(bucket: "homeassistant")
  |> range(start: 2020-06-03T00:00:00Z)
  |> filter(fn: (r) => r["_field"] == "value")
  |> aggregateWindow(every: 15m, fn: mean, createEmpty: false)
  |> set(key: "agg_type", value: "mean")
  |> to(bucket: "homeassistant_15m", org: "privat", tagColumns: ["agg_type", "domain", "entity_id", "friendly_name", "source"])
```

```bash
from(bucket: "homeassistant")
  |> range(start: 2020-06-03T00:00:00Z)
  |> filter(fn: (r) => r["_field"] == "value")
  |> aggregateWindow(every: 1h, fn: mean, createEmpty: false)
  |> set(key: "agg_type", value: "mean")
  |> to(bucket: "homeassistant_60m", org: "privat", tagColumns: ["agg_type", "domain", "entity_id", "friendly_name", "source"])
```

## 2. Create a Influx Task for downsampling all future data

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
