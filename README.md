
# How to deploy flask app in ECS cluster

# Run on local
```
sudo docker build -t flask_docker .
sudo docker run -p 5000:5000 -dit flask_docker
curl -k http://127.0.0.1:5000 
curl -k http://127.0.0.1:5000/status
```
## Push Docker Image to ECR
```
aws ecr create-repository --repository-name flask_docker 
aws ecr get-login --no-include-email | sh 
IMAGE_REPO=$(aws ecr describe-repositories --repository-names flask_docker --query 'repositories[0].repositoryUri' --output text)
docker tag flask_docker:latest $IMAGE_REPO:v1
docker push $IMAGE_REPO:v1
```
## Create CloudFormation Stacks
```
aws cloudformation create-stack --template-body file://$PWD/infra/vpc.yml --stack-name vpc
aws cloudformation create-stack --template-body file://$PWD/infra/iam.yml --stack-name iam --capabilities CAPABILITY_IAM
aws cloudformation create-stack --template-body file://$PWD/infra/app-cluster.yml --stack-name app-cluster
```
## Edit the api.yml to update Image tag/URL under Task > ContainerDefinitions and, <br>
```
aws cloudformation create-stack --template-body file://$PWD/infra/api.yml --stack-name api
```
