#!/usr/bin/env sh

# Add the repository for Java.
add-apt-repository ppa:webupd8team/java
apt-get update

# Set the VM's hostname to `sparkvm`.
cp /vagrant/scripts/etc/hostname /etc
cp /vagrant/scripts/etc/hosts /etc
hostnamectl set-hostname sparkvm
echo "Hostname is now set to: ${HOSTNAME}"

# Copy Apache Spark settings to profile.
cp /vagrant/scripts/etc/environment /etc
chmod 644 /etc/environment
chown -R root:root /etc/environment

# Install additional libraries.
apt-get -q install -y build-essential debconf-utils libncurses5-dev libreadline6-dev \
    libssl-dev openssl python3-pip software-properties-common upstart zlib1g-dev

# Upgrade pip to the latest version.
pip3 install --upgrade pip
pip3 install jupyter numpy py4j matplotlib pandas plotly
echo "pip upgraded to version: $(pip -V)"

# Ensure that the correct python interpreter is used.
ln -s /usr/bin/python3.5 /usr/bin/python
echo "Python linked successfully."
echo "Python version: $(python -V)"

# This should skip the Oracle Java license prompts.
echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections
echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections

# Install Java and Scala.
apt-get -q install -y oracle-java8-installer scala
echo "Successfully installed Java."

# Install Apache Spark.
echo "Installing Apache Spark."
cd /tmp
wget -q http://d3kbcqa49mib13.cloudfront.net/spark-2.1.0-bin-hadoop2.7.tgz
tar -xzf /tmp/spark-2.1.0-bin-hadoop2.7.tgz
mv /tmp/spark-2.1.0-bin-hadoop2.7 /opt/spark
echo "Successfully installed Apache Spark to /opt/spark"
echo "SPARK_HOME=${SPARK_HOME}"

# Jupyter notebook settings.
mkdir -p /root/.jupyter
cp /vagrant/scripts/root/.jupyter/jupyter_notebook_config.json /root/.jupyter

# Create startup scripts. Both Spark and Jupyter Notebook services need to run.
ln -s /vagrant/scripts/lib/systemd/system/spark.service /lib/systemd/system
ln -s /vagrant/scripts/lib/systemd/system/jupyter-notebook.service /lib/systemd/system
systemctl daemon-reload
systemctl enable spark
systemctl start spark
systemctl status spark
systemctl enable jupyter-notebook
systemctl start jupyter-notebook
systemctl status jupyter-notebook
