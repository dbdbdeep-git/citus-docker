#!/bin/bash

for i in $(seq 1 3) ;
do
	ID=${i} docker-compose -p citus up --detach --scale worker=${i} --no-recreate worker
done
