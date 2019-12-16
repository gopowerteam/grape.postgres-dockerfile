#!/bin/bash

curl -X PUT -d `{"id": "postgres:${CONSUL_HOST}:${CONSUL_PORT}","name": "postgres","address": "${DATABASE_HOST}", "tags": [ "postgres"], "port": ${DATABASE_PORT},"check":{"tcp":"${DATABASE_HOST}:${DATABASE_PORT}","interval":"30s","timeout":"3s"}}` `http://${CONSUL_HOST}:${CONSUL_PORT}/v1/agent/service/register`