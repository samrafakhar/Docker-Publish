#!/bin/bash
read -p 'Container: ' container
read -p 'Repository: ' repo
read -p 'Tag: ' tag
read -p 'Username: ' Uname
read -sp 'Password: ' Pwd
sudo docker login --username=$Uname --password=$Pwd
mkdir l174031
cd l174031
touch index.html
cat > index.html << EOF
<!DOCTYPE html>
<html>
<body >
Samra Fakhar 
L17-4031 
Introduction to Cloud Computing 
8A
</body>
</html> 
EOF
cd ..
sudo docker pull nginx:latest
sudo docker run -it -d --name $container nginx
cont_id=$(sudo docker ps -qf "name=$container")
sudo docker exec $container rm -rf /usr/share/nginx/html/index.html
sudo docker cp $(pwd)/l174031/index.html  $cont_id:/usr/share/nginx/html
sudo docker commit $container $Uname/$repo:$tag
sudo docker push $Uname/$repo:$tag
sudo docker stop $container
sudo docker logout
