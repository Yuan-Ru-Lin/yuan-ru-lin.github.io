#let site-title = "Yuan-Ru Lin"
#let site-url = "https://yuanruleonlin.com"
#let photo-base = "https://img.yuanruleonlin.com/"

#let nav() = html.elem("nav")[
  #link("/")[Home]
  #link("/about/")[About]
  #link("/index.xml")[RSS]
  #link("https://github.com/Yuan-Ru-Lin")[GitHub]
  #link("mailto:yuanruleonlin@gmail.com")[Email]
]

// Site chrome. Under HTML it owns <html>, <head> and <body>; under the paged
// target it just returns the body so pages/*.typ can be previewed on their own.
#let site(title: "", date: none, lang: "en", body) = context if target() == "html" {
  show image: it => html.elem("img", attrs: (
    src: "/" + it.source.replace(regex("^(\.\./)+"), ""),
    alt: if it.alt == none { "" } else { it.alt },
    loading: "lazy",
  ))
  show footnote: it => html.elem("span", attrs: (class: "note"), it.body)
  set figure(numbering: none)

  html.elem("html", attrs: (lang: lang))[
    #html.elem("head")[
      #html.elem("meta", attrs: (charset: "utf-8"))
      #html.elem("meta", attrs: (name: "viewport", content: "width=device-width, initial-scale=1"))
      #html.elem("title", if title == site-title { title } else { title + " · " + site-title })
      #html.elem("link", attrs: (rel: "alternate", type: "application/rss+xml", title: site-title, href: "/index.xml"))
      #html.elem("style", read("style.css"))
    ]
    #html.elem("body")[
      #nav()
      #html.elem("main")[
        #html.elem("header")[
          #html.elem("h1", title)
          #if date != none { html.elem("time", attrs: (datetime: date), date) }
        ]
        #body
      ]
    ]
  ]
} else { body }

// Margin note: floated sidenote in HTML, left-ruled block in paged preview.
#let note(body) = context if target() == "html" {
  html.elem("aside", attrs: (class: "note"), body)
} else {
  block(stroke: (left: 1.5pt + blue), inset: 0.8em, body)
}

// Let a figure or photo break out of the text column, centered on the page.
#let wide(body) = context if target() == "html" {
  html.elem("div", attrs: (class: "wide"), body)
} else { body }

// Folder of the page being built (its slug). main.typ sets it per document so
// photo("x.jpeg") finds <slug>/x.jpeg without the page repeating its own name.
#let page-dir = state("page-dir", none)

// Photo with optional caption. A bare filename lives in the current page's
// folder; a path containing "/" is used as written. By default that path is a
// key in the R2 bucket at photo-base (a full URL is used as is) and the paged
// preview shows a link, since Typst cannot fetch URLs. With local: true it is
// relative to static/ and the file ships with the site like any other image().
#let photo(path, alt: "", caption: none, local: false) = context {
  let dir = page-dir.get()
  let bare = not path.contains("/")
  let key = if bare and dir != none { dir + "/" + path } else { path }
  if local and bare and dir == none {
    // Standalone preview of a single page: the folder is unknown.
    block(stroke: (left: 1.5pt + gray), inset: 0.8em)[Photo: #path (shown in the full site build)]
  } else if local {
    figure(image("static/" + key, alt: alt), caption: caption)
  } else {
    let url = if key.starts-with("http") { key } else { photo-base + key.trim("/", at: start) }
    if target() == "html" {
      html.elem("figure")[
        #html.elem("img", attrs: (src: url, alt: alt, loading: "lazy"))
        #if caption != none { html.elem("figcaption", caption) }
      ]
    } else {
      block(stroke: (left: 1.5pt + gray), inset: 0.8em)[Photo: #link(url) #if caption != none [— #caption]]
    }
  }
}

// Colored math: MathML mathcolor in HTML, text fill in paged preview.
#let colored(color, body) = context if target() == "html" {
  html.elem("mstyle", attrs: (mathcolor: color), body)
} else {
  text(fill: eval(color), body)
}

#let divider() = context if target() == "html" { html.elem("hr") } else { line(length: 100%) }

#let comments() = context if target() == "html" {
  html.elem("section", attrs: (class: "comments"))[
    #html.elem("script", attrs: (
      src: "https://utteranc.es/client.js",
      repo: "Yuan-Ru-Lin/yuan-ru-lin.github.io",
      "issue-term": "pathname",
      theme: "github-light",
      crossorigin: "anonymous",
      async: "",
    ))
  ]
}

// Embed a tweet from its URL. Twitter's widget script replaces the blockquote
// with the rendered card; without JS (or in PDF) only the link remains.
#let tweet(url) = context if target() == "html" {
  html.elem("blockquote", attrs: (class: "twitter-tweet"))[
    #html.elem("a", attrs: (href: url), url)
  ]
  html.elem("script", attrs: (src: "https://platform.twitter.com/widgets.js", async: "", charset: "utf-8"))
} else { link(url) }

// RSS 2.0 feed as a string, for asset("index.xml", ...).
#let rss(posts) = {
  let esc = s => s.replace("&", "&amp;").replace("<", "&lt;").replace(">", "&gt;")
  let rfc822 = d => datetime(
    year: int(d.slice(0, 4)), month: int(d.slice(5, 7)), day: int(d.slice(8, 10)),
  ).display("[weekday repr:short], [day] [month repr:short] [year] 00:00:00 +0000")
  let item(p) = {
    let url = site-url + "/blog/" + p.slug + "/"
    (
      "<item><title>" + esc(p.title) + "</title>",
      "<link>" + url + "</link><guid>" + url + "</guid>",
      "<pubDate>" + rfc822(p.date) + "</pubDate>",
      "<description>" + esc(p.summary) + "</description></item>",
    ).join()
  }
  (
    "<?xml version=\"1.0\" encoding=\"utf-8\"?>",
    "<rss version=\"2.0\" xmlns:atom=\"http://www.w3.org/2005/Atom\"><channel>",
    "<title>" + site-title + "</title><link>" + site-url + "/</link>",
    "<description>Recent posts on " + site-title + "</description><language>en</language>",
    "<atom:link href=\"" + site-url + "/index.xml\" rel=\"self\" type=\"application/rss+xml\"/>",
    ..posts.map(item),
    "</channel></rss>",
  ).join("\n") + "\n"
}

#let refs(..args) = bibliography("Blog.bib", title: [References], style: "american-physics-society", ..args)
