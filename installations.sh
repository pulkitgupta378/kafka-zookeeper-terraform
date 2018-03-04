#!/bin/bash
sudo apt-get update
sudo apt-get install default-jre -y
# Install Zookeeper
sudo apt-get install zookeeperd -y
sudo adduser --system --no-create-home --disabled-password --disabled-login kafka
cd ~
wget https://www-us.apache.org/dist/kafka/0.10.2.1/kafka_2.10-0.10.2.1.tgz
sudo mkdir /opt/kafka
sudo tar -xzf kafka_2.10-0.10.2.1.tgz --directory /opt/kafka --strip-components 1
sudo sed -i 's/Xmx1G/Xmx256M/g' /opt/kafka/bin/kafka-server-start.sh
sudo sed -i 's/Xms1G/Xms256M/g' /opt/kafka/bin/kafka-server-start.sh
# Start kafka
sudo /opt/kafka/bin/kafka-server-start.sh -daemon /opt/kafka/config/server.properties
# create topic
sudo  /opt/kafka/bin/kafka-topics.sh --create --topic topic-test --zookeeper localhost:2181 --partitions 1 --replication-factor 1

# List available topics::

sudo  /opt/kafka/bin/kafka-topics.sh --list --zookeeper localhost:2181

# Send message to topic as a producer via the 'kafka-console-producer.sh'::

sudo  echo "hello world" | /opt/kafka/bin/kafka-console-producer.sh --broker-list localhost:9092 --topic topic-test

# *Consume* the send message::

sudo /opt/kafka/bin/kafka-console-consumer.sh --zookeeper localhost:2181 --topic topic-test --from-beginning > /tmp/kafka_consumed.txt

sudo cat /tmp/kafka_consumed.txt
