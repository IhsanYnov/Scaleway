terraform {
    required_providers {
      scaleway = {
        source = "scaleway/scaleway"
      }
    }
    required_version = ">= 0.13"
  }
  provider "scaleway" {
    access_key      = "SCWVVGB6SYQS1W9X5Z5F"
    secret_key      = "303f9063-7a14-4fad-8017-83e92f226701"
    project_id      = "f8f64f6d-0933-4758-be35-c07395306199"
    zone            = "fr-par-1"
    region          = "fr-par"
  }
  