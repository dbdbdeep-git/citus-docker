#!/bin/bash

docker-compose -p citus up --scale worker=3 --no-recreate worker

