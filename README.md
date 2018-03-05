# kafka-zookeeper-terraform
Install kafka &amp; zookeeper in GCP using terraform

Here’s some very basic concepts you need to understand:

-A stream of messages of a particular type is defined as a topic. A Message is defined as a payload of bytes and a Topic is a category or feed name to which messages are published.

-A Producer can be anyone who can publish messages to a Topic.

-The published messages are then stored at a set of servers called Brokers or Kafka Cluster.

-A Consumer can subscribe to one or more Topics and consume the published Messages by pulling data from the Brokers.

-Usage of Zookepper in Kafka: As for coordination and facilitation of distributed system ZooKeeper is used, for the same reason Kafka is using it. ZooKeeper is used for managing, coordinating Kafka broker. Notice, in Hadoop ecosystem, Zookeeper is also used for cluster management for Hadoop. Thus, we have to say Zookeeper is mainly solving the problem of reliable distributed coordination.

# Steps to install Kafka cluster on Ubuntu 16.04

# Step 1. Install Java

 sudo apt-get update
 sudo apt-get install default-jre

# Step 2. Install Zookeeper
 sudo apt-get install zookeeperd

# Step 3. Installing Kafka
 cd ~
 wget http://www-us.apache.org/dist/kafka/0.11.0.2/kafka_2.11-0.11.0.2.tgz

 sudo mkdir /opt/kafka
 sudo tar -xvzf kafka_2.12-0.11.0.0.tgz --directory /opt/kafka --strip-components 1

# Step 4. Start Kafka

 sudo /opt/kafka/bin/kafka-server-start.sh -daemon /opt/kafka/config/server.properties
 
# create topic 

 /opt/kafka/bin/kafka-topics.sh --create --topic topic-test --zookeeper localhost:2181 --partitions 1 --replication-factor 1

# List available topics

 /opt/kafka/bin/kafka-topics.sh --list --zookeeper localhost:2181

# Send message to topic as a producer

 echo "hello world" | /opt/kafka/bin/kafka-console-producer.sh --broker-list localhost:9092 --topic topic-test

# Consume the send message

/opt/kafka/bin/kafka-console-consumer.sh --zookeeper localhost:2181 --topic topic-test --from-beginning > /tmp/kafka_consumed.txt

cat /tmp/kafka_consumed.txt
