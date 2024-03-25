# Mantle
This repository is a (slight) modification to the `ENTRYPOINT` script from the official MariaDB image. It enables automatic bootstrapping of a Galera Cluster. The setup is similar to [severalnines/galera-docker-mariadb](https://github.com/severalnines/galera-docker-mariadb), but it does not rely on an external cluster configurator such as [etcd](https://github.com/etcd-io/etcd). The simplicity of Mantle has been aided by features added to Docker Swarm over the past several years.

## The Modification
The modification is made at the end of the `ENTRYPOINT` file.

```bash
#...
	exec "$@"
#...
```

has been replaced with

```bash
#...
	# 1. No or empty grastate.dat file AND
	# 2. DOCKER_TASK_SLOT is set AND
	# 3. $DOCKER_TASK_SLOT == 1
	# OR
	# 1. The file exists and is not empty AND
	# 2. The state indicates safe to bootstrap
	if { [ ! -s "$DATADIR/grastate.dat" ] && [[ -v DOCKER_TASK_SLOT ]]  && [ $DOCKER_TASK_SLOT == "1" ]; } || \
	{ [ -s "$DATADIR/grastate.dat" ] && grep -q -F "safe_to_bootstrap: 1" "$DATADIR/grastate.dat"; }
	then
		# bootstrap
		exec "$@" --wsrep-new-cluster
	else
		# normal start
		exec "$@"
	fi
#...
```

This modification does not apparently change the operation of MariaDB. All environmental variables from the official image can be used in the exact same manner, commands can be passed to the container, and functionality of the `/etc/mysql/conf.d` and `/docker-entrypoint-initdb.d/` directories remains unchanged.
