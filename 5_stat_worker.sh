#!/bin/bash

PGPASSWORD=postgres psql -h localhost -d postgres -U postgres -f worker.sql
