# Welcome to the ft_server! ![score](https://img.shields.io/badge/0/100-5cb85c?style=for-the-badge) 
> ft_server is the project, which studies system administration.

This project is intended to introduce you to the basics of system and network administration. It will allow you to install a complete web server, using a deployment technology named Docker.

## Getting started
1. Build container.

    ```shell
    docker build -t wordpress .
    ```

2. Run container.

    ```shell
    docker run -it -p 80:80 -p 443:443 wordpress
    ```


## Checklist

- [x] Place all the necessary files in `srcs` folder
- [x] `Dockerfile` at the root of repository
- [x] Don't use docker-compose
- [x] Only one container
- [x] Debian buster
- [x] Nginx
- [x] WordPress
- [x] [phpMyAdmin](http://localhost/phpmyadmin)
- [x] MySQL
- [x] SSL protocol
- [x] Run several services at the same time
- [x] Database works with the WordPress and phpMyAdmin
    - WordPress data like sign up or post can be monitored in phpMyAdmin
- [x] Redirect to the correct website depending on the URL
    - [x] [http -> https redirection](http://localhost)
    - [x] [404 Not Found](http://localhost/index.html)
- autoindex
    - [x] [autoindex](http://localhost/wp-admin/js/)
    - [x] Disable autoindex


## Mandatory part

- Place all the necessary files in `srcs` folder
- `Dockerfile` at the root of repository
- Don't use docker-compose
- Only one container
- Debian buster
- Nginx
- WordPress
- phpMyAdmin
- MySQL
- SSL protocol
- Run several services at the same time
- Database works with the WordPress and phpMyAdmin
- Redirect to the correct website depending on the URL
- Disableable autoindex