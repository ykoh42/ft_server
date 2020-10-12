# Welcome to the ft_server! ![score](https://img.shields.io/badge/0/100-5cb85c?style=for-the-badge) 
> ft_server is the project, which studies system administration.

This project is intended to learn the basics of system and network administration. It will allow to install a complete web server, using a deployment technology named "Docker".

## Getting started
1. Build container.

    ``` shell
    docker build -t wordpress .
    ```

2. Run container.

    ``` shell
    # Default
    docker run -p 80:80 -p 443:443 -d wordpress

    # autoindex on
    docker run -p 80:80 -p 443:443 -e AUTOINDEX=on -d wordpress 

    # autoindex off
    docker run -p 80:80 -p 443:443 -e AUTOINDEX=off -d wordpress 
    ```

## Checklist

- [x] Place all the necessary files in `srcs` folder
- [x] `Dockerfile` at the root of repository
- [x] Only one container
- [x] Debian buster
- [x] Nginx
- [x] Run the `docker build .` command.
- [x] Run the `docker run xxx` command. (xxx is the container just built)
- [x] Launch the container with flags.
- [x] Run multiple services
    - [x] [WordPress](https://localhost/index.php)
    - [x] [phpMyAdmin](https://localhost/phpmyadmin)
- [x] Redirect to the correct website, according to the url
    - [x] [http://localhost](http://localhost)
    - [x] [https://localhost](https://localhost)
    - [x] [http://localhost:80](http://localhost:80)
    - [x] [https://localhost:80](https://localhost:80)
    - [x] [http://localhost:443](http://localhost:443)
    - [x] [https://localhost:443](https://localhost:443)
    - [x] [404 Not Found](https://localhost/index.html)
- [x] SSL protocol
    - [x] [https://localhost](https://localhost)
    - [x] Certificate
- [x] Autoindex which can be deactivated when the container is launched
    - [x] [autoindex](http://localhost/wp-admin/js/)
- [x] Database(MySQL) works with the WordPress and phpMyAdmin
    - [x] [phpMyAdmin](https://localhost/phpmyadmin)

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