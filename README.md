# Simple Hello World GoLang Application

This is an interview project to validate technical keenness and skillset. Project involves building a Docker container for a simple GoLang Hello World application. Terraform is used to automate the building, deploying, and managing of the infrastructure for your Docker container.

## Objectives

- Create a simple GoLang Hello World application
- Build a Docker image of the application
- Use Terraform or CloudFormation to automate the deployment of the Docker container
- Ensure to use best practices regarding security (credential handling)
- Please use Gitlab or Github and be ready to share and speak about your code

## Go Application

```go
package main

import "fmt"

func main() {
    fmt.Println("Hello, World!")
}
```
## Project Architecture


## Using Application

`cd` into the `terraform-configs` folder then run

```bash
terraform apply
```

After the process is completed

`cd` into `kuberntes` folder then apply again