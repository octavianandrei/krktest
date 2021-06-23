# 1. Docker
* Dockerfile created + start_docker.sh ( added comments on both files )
# 2. K8S
* statefulset.yml created to use local(docker+k8s for desktop) k8s cluster and the local docker image created in step 1.
# 3. Jenkins
* deploy.Jenkinsfile for deployment of Dockerfile ( creates the image without starting the container ) + kubectl apply -f statefulset.yml to deploy the app.
# 4. Script kid
* a simple script in bash where I tried to use almost all commands in order to get an output
# 5. Py script that does the same as the one at step 4.
* In progress
# 6. Terraform module
* In progress
