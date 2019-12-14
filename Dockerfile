
# use the 'node' official image
FROM node:8.16.2-alpine3.9

# expose ports 7545, 7546, 7547
EXPOSE 7545 
EXPOSE 7546
EXPOSE 7547
  
# use alpine package manager to install git
RUN apk add --no-cache git

# clone the proxy repository
RUN mkdir -p /usr/src/app

WORKDIR /usr/src/app

RUN git clone https://github.com/edgraaff/quorum-rpc-proxy.git

# change directory and run 'npm install' && 'npm cache clean --force'
WORKDIR  /usr/src/app/quorum-rpc-proxy

RUN npm install && npm cache clean --force

# change the config file to match the nodes urls and ports inside the network
RUN echo 'module.exports = [ { rpcUrl: "http://172.16.239.11:8545", port: 7545, limit: "50kb" },{ rpcUrl: "http://172.16.239.12:8545", port: 7546, limit: "50kb" },{ rpcUrl: "http://172.16.239.13:8545", port: 7547, limit: "50kb" }];' > config.js

# start container with command 'npm run start'
CMD ["npm", "run", "start"]


