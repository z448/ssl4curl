#ssl4curl

# SYNOPSIS

- Download and setup Mozilla certificates for curl SSL/TLS
- a.k.a fixes error bellow

    curl: (60) SSL certificate problem: unable to get local issuer certificate ...

# GIF

![ssl4curl](https://raw.githubusercontent.com/z448/ssl4curl/master/ssl4curl.gif)

# INSTALLATION

```bash
#clone repository
git clone https://github.com/z448/ssl4curl
#initialize from command line as root or use sudo
sudo ssl4curl -i
```

# USAGE

```bash
#add to ~/.bashrc to check/download and setup certificates on start of every session
export `ssl4curl -p`
#execute on command line to check/download certificates and list export string. You can add output string into your ~/.bashrc in which case certificate setup will be skiped on start of session.
`ssl4curl`
#print help
`ssl4curl -h`
```
