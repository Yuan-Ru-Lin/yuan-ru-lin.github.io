#import "../template.typ": note

Working on a remote machine, I had a problem when I wanted to check out figures that I saved from a laborious work. Two naïve approaches that I tried are

+ opening the figures with `eog` and
+ `scp`ing the figures back to my local machine.

They both got the jobs done at the time, but when I had more and more figures and had to iterate the task several times, these solutions became too tedious to practice in real-life situations.

A nifty alternative that I found is to

+ open an HTTP server on the remote machine and
+ get the port forwarded to the local machine via SSH.#footnote[For port forwarding via SSH, one may refer to #link("https://software.belle2.org/sphinx/release-06-00-03/online_book/prerequisites/ssh.html#port-forwarding")[this section of the online textbook for BASF2].]

If you are confused about the terms, you may try the following instructions to the idea.

= Instructions
<instructions>
Login to your remote server while forwarding a port, say, 8010, to the same port on the local machine.

```bash
ssh <your remote server> -L 8010:localhost:8010
```

On the remote server, open an HTTP server on port `8010` by executing a Python module called `http.server` with an argument being the port number.#footnote[If you're using Python2, the equivalent command is `python -m SimpleHTTPServer 8010`.]

```bash
python3 -m http.server 8010
```

You should be prompted as follows.

```
Serving HTTP on 0.0.0.0 port 8010 (http://0.0.0.0:8010/) ...
```

Back on your local machine, open a browser, type `http://localhost:8010/` on the address bar and press enter.

Now you should be able to nagivate the file system on your remote machine within that page!

= Remarks
<remarks>
There are advantages of this solution. First, notice that the requirements of this solution are

+ that you have access to the remote machine, which is default true if you are searching for this solution and
+ that there is Python installed on that remote machine, which I can't imagine not being true.#footnote[You should have realised by now that we didn't install any package via `pip`. That's because the module is in the standard library and boy, is that good!]#footnote[An alternative is to #link("https://github.com/caddyserver/caddy/releases")[download an release of Caddy], extract the executable as, say, `./caddy` and then do `./caddy file-server --browse --listen :8010`.]

Second, this solution works for #emph[any] file. It can be JPG, PNG, PDF or even ROOT. (Binary files such as ROOT files will be downloaded to the local machines if you click them in the navigation page.)
