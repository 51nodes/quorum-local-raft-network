# quorum-local-raft-network

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.

Setup a minimal local [quorum network](https://www.goquorum.com/) with 3 nodes using [raft consensus](https://raft.github.io/) algorithm without tx manager (does not support private transactions).

## Quorum local
Build a local Quorum network based on the [7-nodes example](https://github.com/jpmorganchase/quorum-examples) and simplified to 3 nodes with only [Raft consensus](https://raft.github.io/) without tx manager.

## Run the 3 nodes in containers plus one container for the proxy
run:    `docker-compose up -d`

3 Docker Containers
1. quorum_raft_node1_1 : access at port 22000
2. quorum_raft_node2_1 : access at port 22001
3. quorum_raft_node3_1 : access at port 22002


access to geth of nodes: `docker exec -it <container_name> geth attach ./qdata/dd/geth.ipc`

stop:       `docker-compose stop`

remove:     `docker-compose down -v`

