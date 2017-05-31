#terraform-aws

## Purpose 
This project defines a Docker host using Terraform

## Goals
1. Use Terraform to spin up EC2 instance in a region
2. Pre-provision EC2 instance to prepare it for Ansible
3. Run Ansible playbook against localhost to setup Docker
4. Ensure that a custom systemd file is used for Docker to allow for the overlay2 storage driver
