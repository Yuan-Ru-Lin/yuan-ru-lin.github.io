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

// Remote photo: a bare path is a key in the R2 bucket at photo-base; a full
// URL is used as is. Emits a lazy-loaded <img> in HTML. Typst cannot fetch
// URLs, so the paged preview shows a link instead.
#let photo(path, alt: "", caption: none) = context {
  let url = if path.starts-with("http") { path } else { photo-base + path.trim("/", at: start) }
  if target() == "html" {
    html.elem("figure")[
      #html.elem("img", attrs: (src: url, alt: alt, loading: "lazy"))
      #if caption != none { html.elem("figcaption", caption) }
    ]
  } else {
    block(stroke: (left: 1.5pt + gray), inset: 0.8em)[Photo: #link(url) #if caption != none [— #caption]]
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
