
# Run on local
sudo docker build -t flask_docker .
sudo docker run -p 5000:5000 -dit flask_docker
curl -k http://127.0.0.1:5000
curl -k http://127.0.0.1:5000/status

Push Docker Image to ECR

aws ecr create-repository --repository-name flask_docker
aws ecr get-login --no-include-email | sh
IMAGE_REPO=$(aws ecr describe-repositories --repository-names books-api --query 'repositories[0].repositoryUri' --output text)
docker tag books-api:latest $IMAGE_REPO:v1
docker push $IMAGE_REPO:v1
