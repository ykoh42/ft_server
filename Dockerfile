# Step 1 : From
FROM	debian:buster

# Step 2 : Install
RUN	apt-get update && apt-get install -y	\
	wget					\
	nginx					\
	php-fpm					\
	mariadb-server				\
	php-mysql

# Step 3 : Config SSL(CSR)
RUN	openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/localhost.key -out /etc/ssl/certs/localhost.crt -subj "/C=KR/ST=Seoul/O=42Seoul/CN=localhost"

# Step 4 : Config Nginx && SSL
RUN	cd /etc/nginx/sites-available					&& \
	echo "server {"							>> wordpress && \
	echo "\tlisten 80;"						>> wordpress && \
	echo "\tlisten [::]:80;\n"					>> wordpress && \
	echo "\tlisten 443;"						>> wordpress && \
	echo "\tlisten [::]:443;\n"					>> wordpress && \
	echo "\tssl on;"						>> wordpress && \
	echo "\tssl_certificate_key /etc/ssl/private/localhost.key;"	>> wordpress && \
	echo "\tssl_certificate /etc/ssl/certs/localhost.crt;\n"	>> wordpress && \
	echo "\troot /var/www/wordpress;\n"				>> wordpress && \
	echo "\tindex index.php;\n"					>> wordpress && \
	echo "\tserver_name localhost;\n"				>> wordpress && \
	echo '\terror_page 497 https://$host$request_uri;\n'		>> wordpress && \
	echo "\tlocation / {"						>> wordpress && \
	echo "\t\tautoindex on;"					>> wordpress && \
	echo '\t\ttry_files $uri $uri/ =404;'				>> wordpress && \
	echo "\t}\n"							>> wordpress && \
	echo "\tlocation ~ \.php$ {"					>> wordpress && \
	echo "\t\tinclude snippets/fastcgi-php.conf;"			>> wordpress && \
	echo "\t\tfastcgi_pass unix:/var/run/php/php7.3-fpm.sock;"	>> wordpress && \
	echo "\t}"							>> wordpress && \
	echo "}"							>> wordpress && \
	rm /etc/nginx/sites-enabled/default				&& \
	ln -s /etc/nginx/sites-available/wordpress /etc/nginx/sites-enabled/wordpress

# Step 5 : Config MySQL
RUN	service mysql start												&& \
	echo "CREATE DATABASE wordpress;" | mysql -u root --skip-password						&& \
	echo "GRANT ALL ON wordpress.* TO 'root'@'localhost' WITH GRANT OPTION;" | mysql -u root --skip-password	&& \
	echo "UPDATE mysql.user SET plugin='mysql_native_password' WHERE user='root';" | mysql -u root --skip-password	&& \
	echo "FLUSH PRIVILEGES;" | mysql -u root --skip-password

# Step 6 : Config wordpress
RUN	wget -O /tmp/wordpress.tar.gz https://wordpress.org/latest.tar.gz	&& \
	tar -xzvf /tmp/wordpress.tar.gz -C /var/www				&& \
	chown -R www-data.www-data /var/www/wordpress				&& \
	cd /var/www/wordpress							&& \
	mv wp-config-sample.php wp-config.php					&& \
 	sed -i "s/database_name_here/wordpress/g" wp-config.php			&& \
 	sed -i "s/username_here/root/g" wp-config.php				&& \
 	sed -i "s/password_here//g" wp-config.php

# Step 7 : Config phpMyAdmin
RUN	cd /var/www/wordpress 												&& \
	wget -O /tmp/phpmyadmin.tar.gz https://www.phpmyadmin.net/downloads/phpMyAdmin-latest-all-languages.tar.gz	&& \
	tar -xzvf /tmp/phpmyadmin.tar.gz -C /var/www/wordpress								&& \
	mv php* phpmyadmin												&& \
	cd phpmyadmin													&& \
	mv config.sample.inc.php config.inc.php										&& \
	grep "AllowNoPassword" config.inc.php | sed -i "s/false/true/g" config.inc.php

# Step 8 : Config port
EXPOSE	80 443

# Step 9 : Run container
CMD	service nginx start		&& \
	service php7.3-fpm start	&& \
	service mysql start		&& \
	/bin/bash
