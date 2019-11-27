module.exports = {
  networks: {
     nodeone: {
      host: "127.0.0.1",
      port: 22000,
      network_id: "*",
      gasPrice: 0,
      type: "quorum"
    },
    nodeoneproxy: {
      host: "127.0.0.1",
      port: 22003,
      network_id: "*",
      gasPrice: 0,
      type: "quorum"
    }
  }
};
