# Containerizing a web application built using Flask

## Instructions
1. OS – Ubuntu
2. Update apt repo
3. Install dependencies using apt
4. Install python dependencies using pip
5. Copy source code to /apt folder
6. Run the web server using “flask” command


```
FROM Ubuntu

RUN apt-get update
RUN apt-get install python

RUN pip install
RUN pip install flask-mysql

COPY . /apt/source-code

ENTRYPOINT FLASK_APP=/apt/source-code/app.py flask run

```

Once done, build your image using the `docker build` command and specify the docker file as input as well as a tag name for the image. 
```
docker build Dockerfile -t briandev254/my-custom-app
```

This will create an image locally on your system. To make it available on the public Docker Hub registry, run the `docker push` command and specify the name of the image you just created.
```
docker push briandev254/my-custom-app
```


## Dockerfile

Dockerfile is a text file written in a specific format that docker can understand. It is in an instruction and arguments format.

Everything in CAPS is an instruction. They each instruct Docker to perform a specific action while creating the image.

Everything on the right is an argument to those instructions.

### FROM
The first line defines what the `base OS` should be for this container.
```
FROM Ubuntu
```

Every Docker image must be based off of another image. Either an OS or another image that was created before based on an OS. You can find official releases of all operating systems on Docker Hub.

### RUN
The `RUN` instruction instructs Docker to run a particular command on those base images.

```
RUN apt-get update
RUN apt-get install python

RUN pip install
RUN pip install flask-mysql
``` 

At this point, Docker runs the `apt-get update` commands to fetch the updated packages and installs required dependencies on the image.

### COPY
The `COPY` instruction copies files from the local system onto the Docker image.
```
COPY . /apt/source-code
```
In this case, the source code of the application is in the current folder, and is copied to the location `/apt/source-code`

### ENTRYPOINT
This allows us to specify a command that will be run when the image is run as a container.

```
ENTRYPOINT FLASK_APP=/apt/source-code/app.py flask run
```


When Docker builds the images, it builds these in a layered architecture. Each line of instruction creates a new layer in the docker image with just the changes from the previous layer.

When you run the `docker build` command, you can see the various steps involved and the result of each task.

All the layers built are cached, so the layered architecture helps you restart docker build from that particular step in case it fails, or if you were to add new steps in the build process, you wouldn't have to start all over again. All the layers built are cached by Docker, so in case a particular step was to fail and you work to fix the issue and re-run `docker build`, it will re-use the previous layers from cache and continue to build the remaining layers. The same is true if you were to add additional steps in the docker file. 

This way, rebuilding your image is faster and you don't have to wait for docker to build the entire image each time.

Only the layers above the updated layers need to be rebuilt.