variable "project_name" {
  description =  "Name of the Google Cloud project"

}

variable "region" {
  description =  "Region of GCP project"
}

variable "project_id" {
  description = "Enter the  ID of the Google Cloud project"
  
}


variable "branch_name" {
  description = "Example branch name used to trigger builds."
  type        = string
  default     = "master"
}


variable "githuReponame"{
  description = "Name of the git hub."
  type        = string

  default ="github_lalit2109_reactdemoapp"
}