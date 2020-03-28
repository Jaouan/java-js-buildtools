# Java & JavaScript build tools

A Docker image that contains some build tools.

## How to get an image fat ?
Put Docker and some Java and JavaScript tools inside.

This image contains :
- Docker.
- Docker-compose.
- [Jabba](https://github.com/shyiko/jabba) as Java version manager.
- [NVM](https://github.com/nvm-sh/nvm) as NodeJS version manager.
- [Yarn](https://github.com/yarnpkg/yarn) as NodeJS dependency manager.
- Some tools like Git, Subversion, Nano, ...

Please note that you need to use `--privileged` flag because of docker-inception.
