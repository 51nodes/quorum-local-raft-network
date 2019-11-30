# quorum-local-raft-network

Work In Progress

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.

Setup a local [quorum network](https://www.goquorum.com/) with 3 nodes using [raft consensus](https://raft.github.io/)  algorithm without tx manager.

## Rpc proxy to avoid timestamp error

Javascript could safely store numbers up to 53 bits so the biggest safest number that can be stored is equal to `2^(53)-1`. However, the implementation of [Raft](https://raft.github.io/) uses timestamp in nanoseconds which is bigger than that safest number.

The RPC requests [eth_getBlockByHash](https://github.com/ethereum/wiki/wiki/JSON-RPC#eth_getblockbyhash) and [eth_getblockbynumber](https://github.com/ethereum/wiki/wiki/JSON-RPC#eth_getblockbynumber), which is used frequently by truffle migrate and test commands, return a block object contain the timestamp. Therefore, we need a proxy to read the timestamp from those responses as BigNumber and then convert it to seconds.

Original repository for the proxy https://github.com/edgraaff/quorum-rpc-proxy

## Quorum local
Based on the [7-nodes example](https://github.com/jpmorganchase/quorum-examples) of quorum and simplified to 3 nodes with only [Raft consensus](https://raft.github.io/) without tx manager.

## Run the 3 nodes in containers plus one container for the proxy
run:    `docker-compose up -d`

in case of any change of Dockerfile run `docker-compose up --build -d`

4 Docker Containers
1. quorum_raft_node1_1 : access at port 22000 `with proxy to 22003`
2. quorum_raft_node2_1 : access at port 22001 `with proxy to 22004`
3. quorum_raft_node3_1 : access at port 22002 `with proxy to 22005`
4. quorum_raft_proxy_1 : access at port 22003 and 22004 and 22005

access to geth of nodes: `docker exec -it <container_name> geth attach ./qdata/dd/geth.ipc`

check logs of proxy: `docker logs quorum_raft_proxy_1`

stop:       `docker-compose stop`

remove:     `docker-compose down -v`

## Run truffle example
based on the meta coin truffle-box example

change to the example directory:  `cd ./example`

### With Proxy
to deploy contract and library with proxy: `truffle migrate --reset --network nodeoneproxy`

to test the contract with proxy: `truffle test ./test/metacoin.js --network nodeoneproxy`

### Without Proxy 
the given truffle commands will start the process,
but then it will either give an error back or get stuck without any information.

to deploy contract without proxy: `truffle migrate --reset --network nodeone`

test contract without proxy: `truffle test ./test/metacoin.js --network nodeone`
