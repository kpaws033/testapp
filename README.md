# testapp
env: AWS Codepipelines, python, Docker, AWS CLI, Terraform
ECS, ECR, AWS Fargate serverless applications

1. Run terraform code to setup networking and ecs clusters
terraform init
terraform plan
terraform apply


2. Create ASS Elastic Container Registry (ECR) and create repositories for both frontend and backen applications, and provide access AmazonEC2ContainerRegistryFullAccess to the user role.


3. Install python, aws cli, pip and docker on the EC2 or local machine for setup the configuration.
Docker install
sudo yum update -y
sudo yum install docker -y
sudo service docker start
to avoid using sudo command and continue to use ec2 user for next time
sudo usermod -a -G docker ec2-user
sudo groupadd docker
sudo usermod -aG docker $USER

4. Test flask applications (frondend and backend) locally and test creating docker containers.
docker build -t appname .

5. Configure CI/CD pipeline using AWS Codepipelines to use the github repository as source.
place 

Git local repository
-> clone the repository to local.
-> make sure Applications completed successfully.

6. Create Codepipeline build project to use github repository as source 

Codepipeline use below buildspecification.yml file

phases:
  pre_build:
    commands:
      - $(aws ecr get-login --no-include-email --region eu-west-2)
  build:
    commands:

      - docker build -t frontendrepo:latest .
      - docker tag frontendrepo:latest 926450130867.dkr.ecr.eu-west-2.amazonaws.com/frontendrepo:latest
      - docker build -t backendrepo .
      - docker tag backendrepo:latest 926450130867.dkr.ecr.eu-west-2.amazonaws.com/backendrepo:latest

  post_build:
    commands:
      - docker push 926450130867.dkr.ecr.eu-west-2.amazonaws.com/frontendrepo:latest
      - docker push 926450130867.dkr.ecr.eu-west-2.amazonaws.com/backendrepo:latest
      - printf '[{"name":"fapptask","imageUri":"%s"}]' 926450130867.dkr.ecr.eu-west-2.amazonaws.com/frontendrepo:latest  > imagedefinitions.json
artifacts:
      - printf '[{"name":"fapptask","imageUri":"%s"}]' 926450130867.dkr.ecr.eu-west-2.amazonaws.com/frontendrepo:latest  > imagedefinitions2.json
artifacts:
 
  files: imagedefinitions.json imagedefinitions2.json

7. Once the pipeline completes, the application available on the loadbalancer public dns port 
