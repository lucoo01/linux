## vhost/c.loen.wang.conf

```
server { 
    listen       80; 
    server_name  c.loen.wang; 
    #access_log /root/log/c.loen.access.log main;
    location / { 
	proxy_pass http://localhost:8089; 
	proxy_set_header Host $host:$server_port;
    proxy_set_header   X-NginX-Proxy true;
	proxy_set_header   X-Real-IP   $remote_addr; 
	proxy_set_header   X-Forwarded-For $proxy_add_x_forwarded_for; 
	proxy_redirect off;
    } 
} 
```