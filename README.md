# nomad-demo
An alternative to GKE - Hashicorp Nomad on GCP.

## HowTo

### Prerequisites

* Get Google Cloud [CLI tool](https://cloud.google.com/sdk/gcloud)
* Authenticate with Google Cloud:
```
gcloud auth application-default login
```
* [Install Terraform](https://releases.hashicorp.com/terraform/0.12.24/)
* [Install Packer](https://www.packer.io/docs/install)
* [Install Nomad](https://www.nomadproject.io/downloads)

### Create a Nomad / Consul image with Packer

Custom public images not currently supported in GCP so we build our own.

```
cd ..
git clone git@github.com:fuzzylabs/terraform-google-nomad.git
cd examples/nomad-consul-image
packer build -var project_id=fuzzylabs -var zone=europe-west2-a nomad-consul.json
```
* Take a note of the generated image name, it will be used as the value for `nomad_consul_server_source_image` and `nomad_client_source_image`.

### Run Terraform to create the cluster

* Update the values in `terraform.tfvars` as required
```
cd nomad-demo # root of this repo.
terraform init
terraform plan
terraform apply
```

This will create 3 master and 3 'worker'/'client' nodes.

### Access the cluster

Run the convenience script to get some useful examples.

```
../terraform-google-nomad/examples/nomad-examples-helper/nomad-examples-helper.sh
```

Or just grap the public IP address of one of the master nodes and browse the web UI http://<master-node-ip>:4646

## Bugs

*Note*: we're using our (fixed) fork of the [official terraform nomad module](https://github.com/hashicorp/terraform-google-nomad) as it's currently broken due to outdated attributes for the consul and nomand sub modules.

*Bugs*
https://github.com/hashicorp/terraform-google-nomad/pull/16
https://github.com/hashicorp/terraform-google-consul/pull/49

*Our forks*
https://github.com/fuzzylabs/terraform-google-nomad/tree/fuzzy_fixes
https://github.com/fuzzylabs/terraform-google-consul/tree/fuzzy_fixes

## ToDo

* Apply the Terragrunt pattern to ensure usage of remote state.
* Investigate access lists - public / private IP allocations.
