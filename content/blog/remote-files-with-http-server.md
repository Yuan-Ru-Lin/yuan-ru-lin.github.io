---
title: How to Browse Remote Files with an HTTP Server
date: 2022-05-12
summary: No more `scp` nor `eog`.
thanks: Thanks to [Cheng-Hao Yang](https://github.com/hare1039) for reading a draft of this and informing me of Caddy!
---

Working on a remote machine, I had a problem when I wanted to check out figures that I saved from a laborious work. Two naïve approaches that I tried are

1. opening the figures with `eog` and
2. `scp`ing the figures back to my local machine.

They both got the jobs done at the time, but when I had more and more figures and had to iterate the task several times, these solutions became too tedious to practice in real-life situations.

A nifty alternative that I found is to

1. open an HTTP server on the remote machine and
2. get the port forwarded to the local machine via SSH.[^port-forwarding]

[^port-forwarding]: For port forwarding via SSH, one may refer to [this section of the online textbook for BASF2](https://software.belle2.org/sphinx/release-06-00-03/online_book/prerequisites/ssh.html#port-forwarding).

If you are confused about the terms, you may try the following instructions to the idea.

## Instructions

Login to your remote server while forwarding a port, say, 8010, to the same port on the local machine.

```bash
ssh <your remote server> -L 8010:localhost:8010
```

On the remote server, open an HTTP server on port `8010` by executing a Python module called `http.server` with an argument being the port number.[^py2]

[^py2]: If you're using Python2, the equivalent command is `python -m SimpleHTTPServer 8010`.

```bash
python3 -m http.server 8010
```

You should be prompted as follows.

```
Serving HTTP on 0.0.0.0 port 8010 (http://0.0.0.0:8010/) ...
```

Back on your local machine, open a browser, type `http://localhost:8010/` on the address bar and press enter.

Now you should be able to nagivate the file system on your remote machine within that page!

## Remarks

There are advantages of this solution. First, notice that the requirements of this solution are

1. that you have access to the remote machine, which is default true if you are searching for this solution and
2. that there is Python installed on that remote machine, which I can't imagine not being true.[^no-installation][^caddy]

[^no-installation]: You should have realised by now that we didn't install any package via `pip`. That's because the module is in the standard library and boy, is that good!

[^caddy]: An alternative is to [download an release of Caddy](https://github.com/caddyserver/caddy/releases), extract the executable as, say, `./caddy` and then do `./caddy file-server --browse --listen :8010`.

Second, this solution works for *any* file. It can be JPG, PNG, PDF or even ROOT. (Binary files such as ROOT files will be downloaded to the local machines if you click them in the navigation page.)