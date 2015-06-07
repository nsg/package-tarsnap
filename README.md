# package-tarsnap

Setup a Ubuntu based container, download and build tarsnap to a nice deb package.

```
$ make package
$ ls tar*
tarsnap_1.0.35_amd64.deb
```

## A newer version?

You need to update `VERSION` in the Dockerfile, and update `tarsnap_1.0.35_amd64.deb` 
in the Makefile.
