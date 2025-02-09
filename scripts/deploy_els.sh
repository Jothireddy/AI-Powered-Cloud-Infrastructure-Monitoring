#!/bin/bash
# This script deploys the ELK stack using Docker Compose

cd ../elk
docker-compose up -d
echo "ELK stack deployed. Access Kibana at http://localhost:5601"
