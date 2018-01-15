# IoT-Lab

## What's that?
[At first]
In order to deliver a quality training, I automate the implementation of a lab allowing the implementation of an open-source IoT infrastructure.
It includes tools like:

    . MQTT
    . node-red
    . thingsboard
    . reverse proxy apache2
    . Let's encrypte
    . Guacamole
    . NoSQL base like elasticsearch / cassandra

[Today] this purpose goes on another level.

Please go to [sakura project](https://github.com/redbeard28/sakura-project).

## What do we need?
We need the following prerequisites:

    . OpenStack environment with credentials
    . Terraform
    . **ansible**

## Folders description
Little folder description:

    /ansible => all about ansible deployment
    /terraform => all about terraform deployment

you have a symlink from /terraform/ansible to /ansible

## Servers descriptions

### Front apache2
This server is used as a reverse proxy to https access to:

    . thingsboard
    . guacamole

SSH service is listenning on tcp port 8143


Inspired from Jeff Geerling


### ThingsBoard server
This server act as dashboard service.

    . MQTT secured server
    . https dashboard access
    . Demo for training

### Node-Red server

    . MQTT publisher and listenner

### Guacamole server

    . https HTML5 remote access
    . ssh acces for private lan server
    . Web secured access for node-red (access denied for direct access)

## How it deploy?

    * Terraform deploy the router, the network
    * Terraform deploy the FRONT server with it's public @IP
    * Terraform deploy the Guacamole, thingsboard, node-red and NoSQL servers
    * Terraform deploy ansible package and ssh keys to the FRONT server
    * ansible install all needs on FRONT server
    * ansible install all needs on Guacamole server
    * ansible install all needs on node-red, thingsboard and NoSQL servers
    * ansible install let's encrypt, apache2 and reverse conf. We need servers up and running to respond let's encrypt request...

[Apache role](https://github.com/geerlingguy/ansible-role-apache) was created in 2014 by [Jeff Geerling](https://www.jeffgeerling.com/), author of [Ansible for DevOps](https://www.ansiblefordevops.com/).

# Licence
Licence CC-BY-NC-SA
