FROM rust

ENV HOME /root
ARG GIT_URL=https://github.com/massalabs/massa.git
ARG DEBIAN_FRONTEND=noninteractive
ENV PATH=${PATH}:/root/.cargo/bin

WORKDIR $HOME

# Rust
RUN rustup toolchain install nightly
RUN rustup default nightly

# clone the repo
RUN git clone --branch testnet "$GIT_URL" massa

# build node
RUN cd massa/massa-node && cargo build --release

# build client
WORKDIR $HOME/massa/massa-client
RUN cargo build --release

WORKDIR $HOME/massa/massa-node

# Important! If you already have and backed up your node_privkey.key and staking_keys.json
# it must be in same folder that this Dockerfile to add it to node
COPY node_privkey.key config/
COPY staking_keys.json config/

# rebind IP for private API so client can touch it from outside of container
# add routable_ip to enable routing. Add yoyr own IP there
COPY config.toml config/

WORKDIR $HOME/massa/massa-client

# Important! If you already backed up your wallet.dat
# it must be in same folder that this Dockerfile to add it to node
COPY wallet.dat .

# run node
WORKDIR $HOME/massa/massa-node
ENTRYPOINT ["/root/massa/target/release/massa-node"]
