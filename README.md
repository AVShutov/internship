# Exadel Internship

![image info](./exadel_logo.svg)

## Task 1. Git

* log.txt
* status.txt

## Task 2. AWS/Clouds

1. [WebServer Link](http://ec2-3-120-189-89.eu-central-1.compute.amazonaws.com/ "AWS Intership Example page")
2. The environment is deployed with terraform (./task2/aws)
    * BASH script for installing a web server in this folder as well (./task2/aws/client_data.sh)
    * Primary and secondary VPCs are connected using VPC peering

    ![image info](./peering-intro-diagram.png)

## Task 3. Docker

1. Bash script for installing Docker and environment ([./task3/1-environment/install_docker.sh](https://github.com/AVShutov/internship/blob/master/task3/1-environment/install_docker.sh))

2. Image with html page ([./task3/2-Image/index.html](https://github.com/AVShutov/internship/blob/master/task3/2-Image/index.html))

```bash
docker run -d --name my-apache-app -p 8080:80 -e -v "$PWD"/index.html:/usr/local/apache2/htdocs/index.html httpd:2.4
```

3. Clear basic image - CentOS. An environment variable DEVOPS=username passed inside container to a web page with simple PHP code
    * [./task3/3-Dockerfile](https://github.com/AVShutov/internship/tree/master/task3/3-Dockerfile) or with command&nbsp;

    ```bash
    docker run -d --name my-apache-app -p 8080:80 -e DEVOPS=$(echo $USER) -v "$PWD"/index.html:/usr/local/apache2/htdocs/index.html httpd:2.4
    ```

4. Created GitHub Action to DockerHub for each push.
    * https://hub.docker.com/repository/docker/shutoffalexey/my-httpd
5. Created docker-compose with env files ([./task3/5-docker-compose](https://github.com/AVShutov/internship/tree/master/task3/5-docker-compose))
## Task 4. Ansible

1. Infrastructure deployed with terraform (https://github.com/AVShutov/internship/tree/master/task4-ansible/1-environment). Ansible and it's dependensies installed with "remote-exec" provisioner. Repo with playbooks git cloned to the Control plane machine.

```terraform
  provisioner "remote-exec" {
    inline = [
      "sudo yum update -y",
      "sudo yum install -y curl git mc",
      "pip3 install --user ansible paramiko docker-compose boto3 botocore",
      "ansible-galaxy collection install amazon.aws",
      "ansible-galaxy collection install community.docker",
      "git clone https://github.com/AVShutov/internship.git",
      "sudo chmod 400 ~/.ssh/frankfurt_key.pem"
    ]
```

2. The Docker deployment playbook is here (https://github.com/AVShutov/internship/tree/master/task4-ansible/lamp). LAMP cloned during installation from third party free repository (thanks man!). Secrets are encrypted with Ansible-vault and transferred with jinja2 template to the executable VMs.

```yaml
$ ansible-vault encrypt ./vault.yml --vault-password-file ~/.ansible/vault.txt
```

```yaml
$ ansible-playbook -i ~/internship/task4-ansible/lamp/inventory/lamp_aws_ec2.yml lamp_install.yml --vault-password-file "~/.ansible/vault.txt" -vv
```

3. Used EC2 dynamic inventory source plugin. To install it use: ```ansible-galaxy collection install amazon.aws```.

```ini
ansible.cfg
[inventory]
enable_plugins = aws_ec2
```

```yaml
$ ansible-inventory -i ~/internship/task4-ansible/lamp/inventory/lamp_aws_ec2.yml --graph

$ansible-inventory -i ~/internship/task4-ansible/lamp/inventory/lamp_aws_ec2.yml --list
```

## Task 5. Jenkins

1. Jenkins deployed with Ansible playbook (https://github.com/AVShutov/internship/blob/master/task5-jenkins/jenkins/jenkins_install.yml) in Docker using Dockerfile (https://github.com/AVShutov/internship/blob/master/task5-jenkins/jenkins/Dockerfile) for this.

2. Docker Registry deployed with docker-compose (https://github.com/AVShutov/internship/blob/master/task5-jenkins/jenkins/docker-compose.yml)

3. Jenkinsfile (https://github.com/AVShutov/internship/blob/master/task5-jenkins/jenkins/Jenkinsfile)
    * PASSWORD variable passed into container with standart Jenkiks Credentials module

4. [![Build Status](http://ec2-3-68-158-210.eu-central-1.compute.amazonaws.com:8080/buildStatus/icon?job=Docker)](http://ec2-3-68-158-210.eu-central-1.compute.amazonaws.com:8080/job/Docker/)