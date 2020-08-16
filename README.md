# Terraform CI/CD Pipeline Example

This repo contains an example of deploying a serverless CI/CD pipeline on GCP using Terraform for an React application.

## Features
### Due to limitation on terraform side, some steps needs to be executed manually in GCP console.(See Pre-Requisites)
- Enable and configure the relevant APIs and IAM permissions
- Deploy a Cloud Build
- Deploy a Cloud Build Trigger
- Deploy a app engine application


## Pre-Requisites

- Install terraform in your machine.
- Create GCP account
- Create a project and a service account to execute the terraform scripts.
- Give owner role to the service account.
- Create a Key and download as .json file.
- Create a Source repository and configure Git hub repo as a source 



## How to use the build
- Clone this repo
- Navigate to /terraform-gcp-react-app/GCP_Terraform/main/modules/Projects/ReactDemoApp/terraform.tfvars
- Update below variables in terraform.tfvars
    - project_name  = <Your Project Name>
    - project_id    = <Project ID>
    - region        = <region> 
- Update credentials path at below location:
   /terraform-gcp-react-app/GCP_Terraform/main/main.tf
   Update property "credentials = file("/Users/Lalit/Downloads/Google Cloud/GCP Credentials/testingterrformautomation-ecdb18332270.json")" to your credential file.
- Navigate to terraform-gcp-react-app/GCP_Terraform/main/modules/Projects/ReactDemoApp/ and execute below commands
    - terraform init
    - terraform plan
    - terraform apply
- Login to google console navigate to cloud build --> triggers --> run the triggers.

- If all goes well Voila!!!!! you have deployed application in GCP.
