## Script used for building docker images and running container
Docker_image_name=streamlit-app
image_tag=latest
Docker_container_name=streamlit-app-container


docker stop $Docker_container_name
docker rm $Docker_container_name

docker build -t $Docker_image_name:$image_tag .

docker run -p 9009:80 --name $Docker_container_name $Docker_image_name:$image_tag