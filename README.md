# quorum-local-raft-network

Work In Progress

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.

Setup a local quroum network with 3 nodes using raft consensus algorithm without tx manager.

## Rpc proxy to avoid timestamp error
Raft use the timestamp in nano seconds which is bigger than the max number in javascript,
therefore we need a proxy to filter the rpc requests and responses and convert the timestamp to seconds.
Original repository for the proxy https://github.com/edgraaff/quorum-rpc-proxy

## Quorum local
Based on the 7-nodes example of quorum  https://github.com/jpmorganchase/quorum-examples
and simplified to 3 nodes with only raft consensus without tx manager.

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


