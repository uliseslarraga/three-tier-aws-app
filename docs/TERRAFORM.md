# Terraform Configurations

### Requirements
- 1.7.4 version
### Deploying an applications instance

To deploy an instance of the app, you need to execute the next steps:

1. Initialize the directory with the flag **_--backend-config_** to chose over the different terraform state files, each file corresponds to one environment, the different files are stored in **environments** folder
```
terraform init -backend-config=environments/<env>/backend.hcl
```

2. Verify the deployed resources with terraform plan command indicating which tf variable file you will use (it should be different for each environent)

```
terraform plan -var-file="./environments/<env>/development.auto.tfvars"
```

3. Deploy a new instance of the App

```
terraform apply -var-file="./environments/<env>/development.auto.tfvars"
```