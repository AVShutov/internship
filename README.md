<img src="exadel_logo.svg"><br>

# Exadel Internship

## Task 1. Git

* log.txt
* status.txt

## Task 2. AWS/Clouds

1. [WebServer Link](http://ec2-3-120-189-89.eu-central-1.compute.amazonaws.com/ "AWS Intership Example page")
2. The environment is deployed with terraform (./task2/aws)
    * BASH script for installing a web server in this folder as well (./task2/aws/client_data.sh)
    * Primary and secondary VPCs are connected using VPC peering

    <img src="peering-intro-diagram.png"><br>

## Task 3. Docker

1. Bash script for installing Docker and environment ([./task3/1-environment/install_docker.sh](https://github.com/AVShutov/internship/blob/master/task3/1-environment/install_docker.sh))
2. Image with html page ([./task3/2-Image/index.html](https://github.com/AVShutov/internship/blob/master/task3/2-Image/index.html))
```
docker run -d --name my-apache-app -p 8080:80 -e -v "$PWD"/index.html:/usr/local/apache2/htdocs/index.html httpd:2.4
```
3. Clear basic image - CentOS. An environment variable DEVOPS=username passed inside container to a web page with simple PHP code
    * [./task3/3-Dockerfile](https://github.com/AVShutov/internship/tree/master/task3/3-Dockerfile) or with command<br>
    ```
    docker run -d --name my-apache-app -p 8080:80 -e DEVOPS="111" -v "$PWD"/index.html:/usr/local/apache2/htdocs/index.html httpd:2.4
    ```
4. Created GitHub Action to DockerHub for each push.
    * https://hub.docker.com/repository/docker/shutoffalexey/my-httpd
5. Created docker-compose with env files ([./task3/5-docker-compose](https://github.com/AVShutov/internship/tree/master/task3/5-docker-compose))