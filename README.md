# Deployment 4
###### In this deployment we will be deploying our URL-Shortener application to a VPC we will create with Terraform. 
## Prerequisites
###### You will need the following tools to complete this tutorial:

- Install Jenkins on an EC2 (if you haven’t already) with an Ubuntu image and add ports 22 and 8080
- Install Terraform on your Jenkins server (see the link below for guidance)
  https://www.terraform.io/downloads
![](jenkinsmaster.png)
![](terraforminstall.png)
## Access the UI of the Jenkins server EC2 (i.e. public_ip:8080)
###### Add AWS access key and secret to your Jenkins credentials 
- In the Jenkins Dashboard, click on manage Jenkins and then select Manage Credentials:
  - Select Global
  - Select “Add Credentials” located on the left side of the webpage
       - Next, enter the **First** credentials:
       - Select “Secret text” for Kind
       - Scope should be Global
       - Secret: Copy and Paste your aws access key
       - ID: AWS_ACCESS_KEY
       - Select Create
       - Now, enter the **Second** credentials:
       - Select “Secret text” for Kind
       - Scope should be Global
       - Secret: Copy and Paste your aws secret key
       - ID: AWS_SECRET_KEY
       - Select Create
## In the GitHub repository review the contents of the Jenkinsfile and initTerraform folders

https://github.com/kura-labs-org/kuralabs_deployment_4
###### There may be some lines you want to update to suit your main.tf file :wink: 
For example region, key_name, and ami_id to name a few.

![](maintfedits.png)

## Next, Create a Pipeline build in Jenkins:

![](firstbuild.png)
###### Once you have successfully run your deployment and check your application. Add a destroy stage to the Jenkinsfile:

```
stage('Destroy') {
       steps {
        withCredentials([string(credentialsId: 'AWS_ACCESS_KEY', variable: 'aws_access_key'),
                        string(credentialsId: 'AWS_SECRET_KEY', variable: 'aws_secret_key')]) {
                            dir('terraform-vpc-d4') {
                              sh 'terraform destroy -auto-approve -var="aws_access_key=$aws_access_key" -var="aws_secret_key=$aws_secret_key"'
                            } 
         }
     }
    }   
  }
 }
```

![](secondbuild.png)

## Create a VPC and deploy your Url-Shortener application to it
Utilize the Terraform documentation in the links below to get started
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance
https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/latest
https://registry.terraform.io/modules/terraform-aws-modules/security-group/aws/latest

## Challenges
###### Original Build
One of the challenges I faced while completing this deployment was getting my build to run successfully after adding the destroy block to the Jenkinsfile. I later realized that it was failing due to syntax issues toward the end of the file. Once I rectified the syntax error, I was able to get the build to complete all stages including init, plan, apply and destroy. 

![](secondbuild.png)



Also, I was unable to get my application to deploy to the VPC I created using Terraform. I am still troubleshooting this error. However, I believe the issue with this challenge lies within my Terraform files so that is where I’ll begin troubleshooting.

###### Build with Cypress Test

Another challenge I encountered was getting my Cypress test to pass. According to the logs from the console output my Cypress configuration file could not be located in the /home/ubuntu/agent02/Workspace folder.

## Author 
Sasheeny Hubbard

Deployment 4 Diagram
