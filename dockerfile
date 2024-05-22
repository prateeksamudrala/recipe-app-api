# This is the base image that we are using. It is a lightweight image that has python installed in it.
FROM python:3.9-alpine3.13 
# this is the metadata that we are adding to the image. It is not necessary but it is a good practice to add it.
LABEL maintainer="tymc" 

# This is to prevent python from buffering the outputs to the console. This is useful for logging purposes.
ENV PYTHONUNBUFFERED 1 
# This is to copy the requirements.txt file to the image. This file contains all the dependencies that are required for the project.
COPY ./requirements.txt /tmp/requirements.txt 
COPY ./requirements.dev.txt /tmp/requirements.dev.txt 
# This is to copy the app folder to the image. This folder contains the source code of the project.
COPY ./app /app 
# this is to set the working directory of the image to /app. This is the directory where the source code is present.
WORKDIR /app 
# this is to expose the port 8000 of the container to the host machine. This is the port where the django server will run.
EXPOSE 8000 
# this is to create a virtual environment in the image.
ARG DEV=false   
RUN python -m venv /py && \ 
# this is to upgrade the pip package to the latest version.
    /py/bin/pip install --upgrade pip && \
# this is to install the dependencies that are present in the requirements.txt file.
    /py/bin/pip install -r /tmp/requirements.txt && \
# this is to remove the temporary files that are present in the /tmp directory.
    if [$DEV = "true"]; \ 
        then /py/bin/pip install -r /tmp/requirements.dev.txt; \ 
    fi && \
    rm -rf /tmp && \
# this is to create a user in the image. This user will be used to run the django server.
    adduser \
        --disabled-password \
        --no-create-home \
        django-user
# this is to set the user to the django-user that we created in the previous step.
# this is to set the path of the virtual environment to the PATH environment variable.
ENV PATH="/py/bin:$PATH"
# this is to set the user to the django-user that we created in the previous step.
USER django-user

