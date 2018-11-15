https://ci.elijahg.com/
 
Jenkins > Nodes > New Node
> Name: jenkins-slave1
> Type: permanent
OK
 
> Remote root directory: /var/jenkins
Save
 
Jenkins > Nodes > jenkins-slave1l
 
# Command
#java -jar slave.jar -jnlpUrl http://ci.elijahg.com/computer/jenkins-slave1/slave-agent.jnlp -secret REMOVED -workDir "/var/jenkins"
 
cd /volume1/docker/docker-images
 
git clone https://git.elijahg.com/elijahg-com/jenkins-slave.git
#Username: egagne
#Password: REMOVED
 
# Build the image
docker build -t eg-jenkins-slave:latest .
 
# Find and set DOCKER_GID
grep docker /etc/group
 
DOCKER_GID=65538
 
# Delete the existing container (if it exists)
docker rm -f jenkins-slave1
 
# Run the container
docker run -d \
--name jenkins-slave1 \
--restart unless-stopped \
-e DOCKER_GID=$DOCKER_GID \
-e JENKINS_REMOTE_ROOT_DIR='/var/jenkins' \
-e JENKINS_JNLP_URL='http://192.168.191.165:4004/computer/jenkins-slave1/slave-agent.jnlp' \
-e JENKINS_SECRET='REMOVED' \
-e TZ=America/New_York \
-v /usr/local/bin/docker:/usr/bin/docker \
-v /var/run/docker.sock:/var/run/docker.sock \
-v /volume1/docker/jenkins-slave1:/var/jenkins \
eg-jenkins-slave:latest
 
# Watch the logs
docker logs -f --tail 10 jenkins-slave1
 
--------
 
# Create a container that can run Docker commands
docker container run --rm -it `
-v /:/host `
-v /usr/local/bin/docker:/usr/bin/docker `
-v /var/run/docker.sock:/var/run/docker.sock `
alpine
 
# From inside the container, create a new container
docker container run -d --name ewgtest httpd
 
# From outside the container, check what's running
C:\Users\egagn> docker ps
CONTAINER ID        IMAGE               COMMAND              CREATED             STATUS              PORTS               NAMES
216ddcc12b5b        httpd               "httpd-foreground"   4 seconds ago       Up 2 seconds        80/tcp              ewgtest
3aca1fbaf7c7        alpine              "/bin/sh"            3 minutes ago       Up 3 minutes                            priceless_franklin
 
 

java -jar agent.jar -jnlpUrl https://ci.nidhi.com/computer/jenkins-slave01/slave-agent.jnlp
