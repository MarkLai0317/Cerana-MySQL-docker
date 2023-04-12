FROM mysql:latest

ENV MYSQL_ROOT_PASSWORD=root_password
ENV MYSQL_DATABASE=cerana
ENV MYSQL_USER=your_User_Nmae
ENV MYSQL_PASSWORD=your_password

VOLUME /var/lib/mysql

COPY init.sql /docker-entrypoint-initdb.d/

EXPOSE 3306
