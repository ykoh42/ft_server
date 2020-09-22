# Welcome to the ft_server! ![score](https://img.shields.io/badge/0/100-5cb85c?style=for-the-badge) 
> ft_server is the project, which studies system administration.

This project is intended to introduce you to the basics of system and network administration. It will allow you to install a complete web server, using a deployment technology named Docker.

---

## Getting started
1. Build container.

    ```shell
    docker build -t wordpress .
    ```

2. Run container.

    ```shell
    docker run -it -p 80:80 -p 443:443 wordpress
    ```

---

## Checklist

- [ ] Place all the necessary files in `srcs` folder
- [ ] `Dockerfile` at the root of repository
- [ ] Don't use docker-compose
- [ ] Only one container
- [ ] Debian buster
- [ ] Nginx
- [ ] WordPress
- [ ] phpMyAdmin
- [ ] MySQL
- [ ] SSL protocol
- [ ] Run several services at the same time
- [ ] Database works with the WordPress and phpMyAdmin
    - WordPress data like sign up or post can be monitored in phpMyAdmin
- [ ] Redirect to the correct website depending on the URL
    - [ ] [http -> https redirection](http://localhost)
    - [ ] [404 Not Found](http://localhost/index.html)
- autoindex
    - [ ] [autoindex](http://localhost/wp-admin/js/)
    - [ ] Disable autoindex

---

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