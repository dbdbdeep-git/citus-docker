# Citus

[![Image Size](https://images.microbadger.com/badges/image/citusdata/citus.svg)][image size]
[![Release](https://img.shields.io/github/release/citusdata/docker.svg)][release]
[![License](https://img.shields.io/github/license/citusdata/docker.svg)][license]

Citus is a PostgreSQL-based distributed RDBMS. For more information, see the [Citus Data website][citus data].

### Shell script
```bash

$ 0_conn_master.sh
$ 1_build_image.sh
$ 2_startup.sh
$ 3_stat_worker.sh
$ 4_add_worker.sh
$ 5_stat_worker.sh
$ 6_shutdown.sh

```

### Docker Compose

The included `docker-compose.yml` file provides an easy way to get started with a Citus cluster, complete with multiple workers. Just copy it to your current directory and run:

```bash
docker-compose -p citus up

# Creating network "citus_default" with the default driver
# Creating citus_worker_1
# Creating citus_master
# Creating citus_config
# Attaching to citus_worker_1, citus_master, citus_config
# worker_1    | The files belonging to this database system will be owned by user "postgres".
# worker_1    | This user must also own the server process.
# ...
```

That’s it! As with the standalone mode, you’ll want to find your `docker-machine ip` if you’re using that technology, otherwise, just connect locally to `5432`. By default, you’ll only have one worker:

```sql
SELECT master_get_active_worker_nodes();

--  master_get_active_worker_nodes
-- --------------------------------
--  (citus_worker_1,5432)
-- (1 row)
```

But you can add more workers at will using `docker-compose scale` in another tab. For instance, to bring your worker count to five…

```bash
docker-compose -p citus scale worker=5

# Creating and starting 2 ... done
# Creating and starting 3 ... done
# Creating and starting 4 ... done
# Creating and starting 5 ... done
```

```sql
SELECT master_get_active_worker_nodes();

--  master_get_active_worker_nodes
-- --------------------------------
--  (citus_worker_5,5432)
--  (citus_worker_1,5432)
--  (citus_worker_3,5432)
--  (citus_worker_2,5432)
--  (citus_worker_4,5432)
-- (5 rows)
```

If you inspect the configuration file, you’ll find that there is a container that is neither a master nor worker node: `citus_config`. It simply listens for new containers tagged with the worker role, then adds them to the config file in a volume shared with the master node. If new nodes have appeared, it calls `master_initialize_node_metadata` against the master to repopulate the node table. See Citus’ [`workerlist-gen`][workerlist-gen] repo for more details.

You can stop your cluster with `docker-compose -p citus down`.

## License

The following license information (and associated [LICENSE][license] file) apply _only to the files within **this** repository_. Please consult Citus’s own repository for information regarding its licensing.

Copyright © 2016–2017 Citus Data, Inc.

Licensed under the Apache License, Version 2.0 (the “License”); you may not use this file except in compliance with the License. You may obtain a copy of the License at http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an “AS IS” BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.

[image size]: https://microbadger.com/images/citusdata/citus
[release]: https://github.com/citusdata/docker/releases/latest
[license]: LICENSE
[citus data]: https://www.citusdata.com
[docker-postgres]: https://hub.docker.com/_/postgres/
[compose-config]: docker-compose.yml
[workerlist-gen]: https://github.com/citusdata/workerlist-gen
