# Cerana-MySQL-docker
MySQL local DB for testing

-- start a MySQL server locally
* step 1: build image
    ```
    docker build -t [your image name] .
    ```
    * example
        ```
        docker build -t mysql-cerana:latest .
        ```
* step 2: create volume
    ```
    docker volume create [your volume name]
    ```
    * example
        ```
        docker volume create cerana-test
        ```

* step 3: run a container with image
    ```
    docker run -d --name [your container name] -e MYSQL_ROOT_PASSWORD=[your password] -p [your port]:3306 -v [your volume name]:/var/lib/mysql [your image name]
    ```
    * example
        ```
        docker run -d --name mysql-test-container -e MYSQL_ROOT_PASSWORD=rootpwd -p 3306:3306 -v cerana-test:/var/lib/mysql mysql-cerana:latest
        ```


* if you want to restart container with modified image
    
    * step 1: stop container
    ```
    docker stop [your container name]
    ```

    * step 2: remove container
    ```
    docker rm [your container name]
    ```

    * step 3: remove image
    ```
    docker rmi [your image name]
    ```

    * step 4: remove volume
    ```
    docker volume rm [your volume name]
    ```
    * step 5: go back to "start a MySQL server locally"
    
-- open sql shell
```
docker exec -it [containerID] mysql -p
```