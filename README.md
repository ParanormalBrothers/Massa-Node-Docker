# Massa Docker container
Docker image helps to migrate your Massa Testnet Node and Client to Docker container

## What you need:
- **Docker installed on your server**
- **Dockerfile** from this repo
- **config.toml** from this repo
- **node_privkey.key** that you are backed up from your node
- **staking_keys.json** that you are backed up from your node
- **wallet.dat** that you are backed up from your node

## What to do
- Download this Dockerfile and config.toml
- Edit config.toml, put your node server IP in routable_ip = "XXX.XXX.XXX.XXX"
- Put node_privkey.key, staking_keys.json and wallet.dat in same folder
- Run command:
<pre>
docker build -t massa .
</pre>
- check that "massa" image is builded:
<pre>
docker images
</pre>
- run image:
<pre>
docker run --rm --name node -d -p 33035:33035 -p 127.0.0.1:33034:33034 -p 31244:31244 -p 31245:31245 massa
</pre>
- check that node container is running:
<pre>docker ps -a</pre>
- View logs of your Massa node:
<pre>docker logs node</pre>
You can grep logs of course:
<pre>docker logs node | grep "Started"</pre>

# Client
Client is builded with node. You have to use it to prepare everything for staking (if you want to stake): buy rolls and register with Massa Bot in Discord.
But you can use client binary to connect to your node also.

## Connect to container and use client:
<pre>
docker run -it --entrypoint /bin/bash node
</pre>
When connected, switch folder to client and run client:
<pre>
cd ~/massa/massa-client && /root/massa/target/release/massa-client
</pre>
Exit client:
<pre>exit</pre>
Exit container (it will still run, don't worry):
<pre>exit</pre>

