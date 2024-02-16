#!/command/with-contenv bashio
# ==============================================================================
# Home Assistant Community Add-on: InfluxDB
# Configures NGINX for use with the Chronograf
# ==============================================================================
declare dns_host
declare ingress_interface
declare ingress_port
declare ingress_entry
declare ingress_entry_clean

bashio::log.info "Running /etc/cont-init.d/nginx.sh"

ingress_entry=$(bashio::addon.ingress_entry)
# replace the "/" since we need it later without
ingress_entry_clean=${ingress_entry/\//}

ingress_port=$(bashio::addon.ingress_port)
ingress_interface=$(bashio::addon.ip_address)
sed -i "s/%%port%%/${ingress_port}/g" /etc/nginx/servers/ingress.conf
sed -i "s/%%interface%%/${ingress_interface}/g" /etc/nginx/servers/ingress.conf
sed -i "s#%%ingress_entry%%#${ingress_entry}#g" /etc/nginx/servers/ingress.conf
sed -i "s#%%ingress_entry_clean%%#${ingress_entry_clean}#g" /etc/nginx/servers/ingress.conf

dns_host=$(bashio::dns.host)
sed -i "s/%%dns_host%%/${dns_host}/g" /etc/nginx/includes/resolver.conf