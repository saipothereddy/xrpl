# Rippled Validator

This container is running on `ubuntu:latest`.

## How to run

If you are new to this and you want to deploy a server for $20 a month at DigitalOcean: [here's a howto](https://medium.com/@WietseWind/how-to-run-a-ripple-validator-digitalocean-7e5fca1c3d77).

### From docker build

```
docker build --tag xrpl:latest .
```

### From the Docker run command



This command does the trick:

```
docker run -dit \
    --name xrpl \
    -p 51235:51235 \
    -v /home/xrpl/keystore/:/keystore/ \
   xrpl:latest
```

This folder wil contain the generated `rippled.cfg`, `validator-keys.json` and `validators.txt`.

## So it's running

If everything is OK and your server is accessible from the public internet, you should be able to find your server (after ~15 minutes) in the Validator Registry: [https://xrpcharts.ripple.com/#/validators](https://xrpcharts.ripple.com/#/validators).

You can retrieve your own _Validator Public Key_ by checking the `validator-keys.json` file in the folder containing the config (`./keystore/` or the path you specified for your volume mapping), or by running:

```
docker exec xrpl cat /root/.ripple/validator-keys.json|grep public_key
```

If you want to check the rippled-logs (container stdout, press CTRL - C to stop watching):

```
docker logs -f xrpl
```

If you want to check the rippled server status:

```
docker exec xrpl server_info
```

```
docker exec xrpl /opt/ripple/bin/rippled server_info -q | grep pubkey_validator
```

