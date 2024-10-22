# Sqlcmd-Go with Scratch

Are you in need of a compact `SQLCMD` (Go) container image? Look no further than `sqlcmd-go-scratch`. With a size of approximately 19 MB, this image offers the portability and flexibility required for executing queries using `SQLCMD` seamlessly within containers.

## Examples

### Image build
```docker
docker build . -t sqlcmd-go-scratch
````

### Checking `SQLCMD` help
```docker
docker container run --rm -it mssql-tools-alpine sqlcmd --help
```

### Using `SQLCMD` through local network
```docker
docker container run -it --network host sqlcmd-go-scratch sqlcmd -S <HOSTNAME|PORT> -U <USER> -P <PASSWORD>
```

## Questions?
If you have questions or comments about this demo, don't hesitate to contact me at <contact@croblesm.com>

## Follow me
[![N|Solid](http://dbamastery.com/wp-content/uploads/2018/08/if_twitter_circle_color_107170.png)](https://twitter.com/croblesmr) [![N|Solid](http://dbamastery.com/wp-content/uploads/2018/08/if_github_circle_black_107161.png)](https://github.com/croblesm) [![N|Solid](http://dbamastery.com/wp-content/uploads/2018/08/if_linkedin_circle_color_107178.png)](https://www.linkedin.com/in/croblesm) 
