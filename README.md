# How to install kafka-zookeeper in GCP using terraform

Here’s some very basic concepts you need to understand:

-Apache Kafka is a distributed message broker designed to handle large volumes of real-time data efficiently Kafka runs as a cluster of one or more servers which makes it highly scalable and due to this distributed nature

-A stream of messages of a particular type is defined as a topic. A Message is defined as a payload of bytes and a Topic is a category or feed name to which messages are published.

-A Producer can be anyone who can publish messages to a Topic.

-The published messages are then stored at a set of servers called Brokers or Kafka Cluster.

-A Consumer can subscribe to one or more Topics and consume the published Messages by pulling data from the Brokers.

-Usage of Zookepper in Kafka: ZooKeeper is used for managing & coordinating Kafka broker. Zookeeper is mainly solve the problem of reliable distributed coordination.

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

# Start the Producer

/opt/kafka/bin/kafka-console-producer.sh --broker-list localhost:9092 --topic topic-test

# Start the Consumer

/opt/kafka/bin/kafka-console-consumer.sh --zookeeper localhost:2181 --topic topic-test --from-beginning 

# Interactively and real-timely testing

You can type whatever text you want at the producer terminal and press “Enter” when you finished. The same message will be deliver to the consumer terminal.

# Set Up a Multi-Node Cluster (Optional)

If you want to create a multi-broker cluster using more Ubuntu machines, you should repeat Step 1 to Step 4 on each of the new machines. Additionally, you should make the following changes in the server.properties file in each of them:

-The value of the broker.id property should be changed such that it is unique throughout the cluster
-The value of the zookeeper.connect property should be changed such that all nodes point to the same ZooKeeper instance


# Install Terrafrom in Linux 

1. SSH into your GCE instance
2. wget https://releases.hashicorp.com/terraform/0.11.3/terraform_0.11.3_linux_amd64.zip
3. unzip terraform_0.11.3_linux_amd64.zip
4. sudo mv terraform /usr/local/bin/
5. Confirm terraform binary is accessible: terraform --version


# GCP Setup 

1.	Service Account Key file.
This contains your authentication required for Terraform to talk to the Google API.
You can get it under Google Cloud Platform -> API Manager -> Credentials -> Create Credentials -> Service account key.
For the Key type field chose JSON. Put the downloaded file right were your Terraform config file is and name it account.json.
2.	Make sure that you have an SSH key setup for your project: Compute Engine -> Metadata -> SSH Keys
3.	Chose a valid machine image and machine type for your VM.
4.	terraform plan to make sure everything is looking good
5.	terraform apply
6.	Find the IP of the box with terraform show | grep assigned_nat_ip





