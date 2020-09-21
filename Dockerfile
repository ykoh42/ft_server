# Step1 : OS
FROM debian:buster

# Step2 : Install
RUN apt-get update && apt-get install -y \
	wget			\
	nginx			\
	php-fpm			\
	mariadb-server	\
	mariadb-client	\
	php-mysql

# Step 3 : Config MySQL
 RUN service mysql start	&& \
echo "CREATE DATABASE wordpress;" | mysql -u root --skip-password && \
echo "GRANT ALL ON wordpress.* TO 'root'@'localhost' WITH GRANT OPTION;" | mysql -u root --skip-password && \
echo "UPDATE mysql.user SET plugin='mysql_native_password' WHERE user='root';" | mysql -u root --skip-password && \
echo "FLUSH PRIVILEGES;" | mysql -u root --skip-password

# Step 4 : Config Nginx
WORKDIR /etc/nginx/sites-available
RUN echo "server {"														>> wordpress && \
	echo "\tlisten 80;"													>> wordpress && \
	echo "\tlisten [::]:80;\n"												>> wordpress && \
	echo "\troot /var/www/wordpress;\n"										>> wordpress && \
	echo "\tindex index.php;\n"												>> wordpress && \
	echo "\tserver_name localhost;\n"										>> wordpress && \
	echo "\tlocation / {"													>> wordpress && \
	echo '\t\ttry_files $uri $uri/ =404;'									>> wordpress && \
	echo "\t}\n"															>> wordpress && \
	echo "\tlocation ~ \.php$ {"											>> wordpress && \
	echo "\tinclude snippets/fastcgi-php.conf;"							>> wordpress && \
	echo "\tfastcgi_pass unix:/var/run/php/php7.3-fpm.sock;"				>> wordpress && \
	echo "\t}"															>> wordpress && \
	echo "}"															>> wordpress && \
	rm /etc/nginx/sites-enabled/default												&& \
	ln -s /etc/nginx/sites-available/wordpress /etc/nginx/sites-enabled/wordpress

# Step 5: Config wordpress
RUN wget -O /tmp/wordpress.tar.gz https://wordpress.org/latest.tar.gz	&& \
	tar -xzvf /tmp/wordpress.tar.gz -C /var/www							&& \
	chown -R www-data.www-data /var/www/wordpress

WORKDIR /var/www/wordpress
RUN mv wp-config-sample.php wp-config.php && \
 	sed -i "s/database_name_here/wordpress/g" wp-config.php && \
 	sed -i "s/username_here/root/g" wp-config.php && \
 	sed -i "s/password_here//g" wp-config.php

# Step 6: Config phpMyAdmin
WORKDIR /var/www/wordpress
RUN wget -O /tmp/phpmyadmin.tar.gz https://www.phpmyadmin.net/downloads/phpMyAdmin-latest-all-languages.tar.gz && \
	tar -xzvf /tmp/phpmyadmin.tar.gz -C /var/www/wordpress && \
	mv php* phpmyadmin && \
	cd phpmyadmin && \
	mv config.sample.inc.php config.inc.php && \
	grep "AllowNoPassword" config.inc.php | sed -i "s/false/true/g" config.inc.php

ADD srcs/init.sh /tmp

EXPOSE 80 443


# ENTRYPOINT bash ~/../tmp/init.sh