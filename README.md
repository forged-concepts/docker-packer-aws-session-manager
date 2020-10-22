# docker-packer-aws-session-manager

Docker container with packer and aws-session-manager

# Instructions for Use

To use docker-packer-aws-session-manager, you have two options:

Pass in the following environment variables:
  - `AWS_ACCESS_KEY_ID`
  - `AWS_SECRET_ACCESS_KEY`
  - `AWS_DEFAULT_REGION`

# Example Use

## This mounts the credentials file in the container for use

```
docker run --rm -it --entrypoint /bin/sh forgedconcepts/packer-aws-session-manager:latest
```

# dockerhub
You can find the container here:

https://hub.docker.com/r/forgedconcepts/packer-aws-session-manager

# More Information
For more information on environment variables and aws, please refer to the following link:

https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-envvars.html

# Issues
If you have any issues with this Dockerfile, please create an issue or submit a pull request with a fix.