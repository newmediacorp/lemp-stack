# lemp-stack
LEMP stack for PHP development environment with docker-compose

## Pre-requsites

### 1. Remap docker user namespace (Linux hosts)
If your host OS is Linux-based, to avoid permission issues with docker volumes you need to modify the `/etc/subuid` and `/etc/subgid` to contain:
```
<your-username>:1000:1
<your-username>:100000:65535
```
Then add a docker configuration file at `/etc/docker/daemon.json` with the following contents:
```json
{
  "userns-remap": "<your-username>"
}
```

And finally restart the docker daemon
```
$ sudo systemctl restart docker
```

More info about the docker volume permissions issues:
https://denibertovic.com/posts/handling-permissions-with-docker-volumes/

More info about docker user namespaces:
https://blog.yadutaf.fr/2016/04/14/docker-for-your-users-introducing-user-namespace/

### 2. Run a local nginx proxy
To be able to access the project via `http://<project-name>.local` URL, we need to run a local nginx proxy like:
```
$ docker run --restart=always -d -p 80:80 -v /var/run/docker.sock:/tmp/docker.sock:ro jwilder/nginx-proxy
```

### 3. Modify docker-compose.yml
Replace the `<project-name>` placeholder in `docker-compose.yml` with your actual project name.  
Replace the `<mysql-host-port>` placeholder in `docker-compose.yml` with the port you'd want mysql to be accessible on your host.

### 4. Add hosts entry
In your hosts file (`/etc/hosts` on Linux, or `C:\Windows\System32\drivers\etc\hosts` on Windows), add the following entry: 
```
127.0.0.1 <project-name>.local
```

## Running the project
Add your project files in the root directory and run `docker-compose up -d`.  
Access the project at `http://<project-name>.local` URL.
