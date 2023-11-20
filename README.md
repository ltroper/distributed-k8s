# Deploying a Distributed Kubernetes Cluster on Linode with Terraform

This guide will walk you through the process of deploying a distributed Kubernetes (K8s) cluster on Linode using Terraform. The cluster will consist of a control plane node and multiple worker nodes.

## Prerequisites

1. **Linode Account**: Ensure you have a Linode account. If you don't have one, sign up at [Linode](https://www.linode.com/).

2. **Linode API Token**: Generate a Linode API token from the Linode Cloud Manager. Instructions can be found [here](https://www.linode.com/docs/guides/getting-started-with-the-linode-api/#creating-an-api-token).

3. **Terraform Installation**: Install Terraform on your local machine. You can download Terraform from [here](https://www.terraform.io/downloads.html) and follow the installation instructions.

4. **Linode CLI**: Install the Linode CLI for easier management. Instructions can be found [here](https://www.linode.com/docs/guides/linode-cli/).

## Steps

### 1. Clone the Repository

Clone this repository to your local machine:

```
git clone https://github.com/your-username/linode-k8s-terraform.git
cd linode-k8s-terraform
```
### 2. Create Terraform Variables File

Create a terraform.tfvars file with the required variables:
```
# terraform.tfvars

regions       = ["us-east", "us-west"]  # Replace with desired Linode region codes
token         = "your-linode-api-token"
name          = "your-cluster-name"
master_node   = "linode-type-for-control-plane"
worker_nodes  = "linode-type-for-worker-nodes"
worker_count  = 2
```

### 3. Initialize Terraform and deploy configuration

Run the following command to initialize Terraform:

```
terraform init
terraform apply --auto-approve
```

### 4. Access Cluster

Use the output to ssh into the controlPlane node and begin deploying distributed applications.


Happy Kubernetes deploying! 🚀
