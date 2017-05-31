#!/bin/bash
sudo apt-get install software-properties-common -y
sudo apt-get update
sudo apt-get install python-pip libssl-dev -y
pip install ansible==1.9.6
