## How to use ##
Clone this repo
1. Install docker
2. ```cd /home```
3. If you wish to save the progress create a docker volume ```sudo docker volume create <volume_name>```(volume name could be anything)
4. ```sudo docker build -t <image_name> .``` (image name could be anything)
5. For running the image do ```sudo docker run -it -p 8080:80 --name <container_name> -v <volume_name>:/home <image_name>``` (the container name could be anthing)
6. After this you will be logged in as a root user into a docker container running this image where you can use all the aliases (like ```userGen```, ```domainPref``` etc)
7. To access the file locally in the browser type ```tmux new-session -d -s apache 'apache2ctl -D FOREGROUND'``` in the terminal (This will run the apache server in a new terminal in the background)
8. If you wish to exit the docker container you can just type ```exit``` or use ```ctrl + d```
9. If you wish to start the server again then use ```sudo docker start <container_name>``` and then ```sudo docker exec -it <container_name> bash``` to run the container in interactive state.
10. To access the ```mentees_domain.txt``` file from the browser go to ```http://localhost:8080/mentees_domain.txt```
