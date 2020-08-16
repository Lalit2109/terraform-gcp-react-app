provider "google" {
  project     = var.project_name
  credentials = file("/Users/Lalit/Downloads/Google Cloud/GCP Credentials/testingterrformautomation-ecdb18332270.json")
  region      = var.region

}


resource "google_project_service" "resourcemanager" {
  project            = var.project_id
  service            = "cloudresourcemanager.googleapis.com"
  disable_on_destroy = false
}


#----------------------------------------------------------------------------------------------
#  CLOUD SOURCE REPOSITORY
#      - Enable API
#----------------------------------------------------------------------------------------------

resource "google_project_service" "repo" {
  project            = var.project_id
  service            = "sourcerepo.googleapis.com"
  disable_on_destroy = false
}


#----------------------------------------------------------------------------------------------
#  App Engine
#      - Enable API
#      - Provide access to the app engine
#----------------------------------------------------------------------------------------------

resource "google_project_service" "appengine" {
  project                    = var.project_id
  service                    = "appengine.googleapis.com"
  disable_dependent_services = true

}

data "google_project" "project" {
  project_id = var.project_id
    depends_on = [google_project_service.resourcemanager]
}

resource "google_app_engine_application" "app" {
  project     = var.project_id
  location_id = var.region
  depends_on = [google_project_service.appengine]
}

resource "google_project_iam_binding" "binding" {
  project    = var.project_id
  members    = ["serviceAccount:${data.google_project.project.number}@cloudbuild.gserviceaccount.com"]
  role       = "roles/appengine.appAdmin"
  depends_on = [google_project_service.cloudbuild]
}


#----------------------------------------------------------------------------------------------
#  CLOUD BUILD
#      - Enable cloud Build and app engine API
#      - Create Build Trigger
#----------------------------------------------------------------------------------------------

resource "google_project_service" "cloudbuild" {
  project                    = var.project_id
  service                    = "cloudbuild.googleapis.com"
  disable_dependent_services = true

}


resource "google_cloudbuild_trigger" "cloud_build_trigger" {
  project     = var.project_id
  description = "Cloud Source Repository Trigger ${var.githuReponame} (${var.branch_name})"
  filename    = "cloudbuild.yaml"
  trigger_template {
    repo_name   = var.githuReponame
    branch_name = var.branch_name
  }

  depends_on = [google_project_service.cloudbuild]
}
