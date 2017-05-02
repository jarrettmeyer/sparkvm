#!/usr/bin/env sh

# Always look for a new environment settings.
cp /vagrant/scripts/etc/environment /etc
cp /vagrant/scripts/etc/hosts /etc

echo "PYTHONPATH=${PYTHONPATH}"
echo "SPARK_HOME=${SPARK_HOME}"
echo "SCALA_HOME=${SCALA_HOME}"
