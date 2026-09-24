#import "template.typ": site, site-title, note, comments, rss, page-dir

#let posts = (
  (
    slug: "pycall-with-uv",
    title: "Using PyCall with uv-managed Python Environments",
    date: "2025-10-02",
    summary: "",
    file: "pages/pycall-with-uv.typ",
  ),
  (
    slug: "how-to-passwordless-ssh",
    title: "About passwordless ssh",
    date: "2023-03-27",
    summary: "",
    file: "pages/how-to-passwordless-ssh.typ",
  ),
  (
    slug: "cocktails",
    title: "DIY Cocktails",
    date: "2022-12-19",
    summary: "Get yourself drunk at home, economically",
    file: "pages/cocktails.typ",
  ),
  (
    slug: "belle-population",
    title: "How Physicists Observe Particles, starting from the Belle Experiment and CP-Violation",
    date: "2022-12-12",
    summary: "",
    file: "pages/belle-population.typ",
  ),
  (
    slug: "remote-files-with-http-server",
    title: "How to Browse Remote Files with an HTTP Server",
    date: "2022-05-12",
    summary: "No more `scp` nor `eog`.",
    file: "pages/remote-files-with-http-server.typ",
  ),
  (
    slug: "on-note-taking-softwares",
    title: "On Note-Taking Softwares",
    date: "2022-05-10",
    summary: "Markdown and all that.",
    file: "pages/on-note-taking-softwares.typ",
  ),
  (
    slug: "color-latex",
    title: "How to Use Colors in LaTeX",
    date: "2022-05-05",
    summary: "Put colors on your symbols so an equation reads at a glance.",
    file: "pages/color-latex.typ",
  ),
  (
    slug: "p-value-significance-level",
    title: "Calculation of P-value and Significance Level",
    date: "2022-04-01",
    summary: "Calculation of P-value and significance level",
    file: "pages/p-value-significance-level.typ",
  ),
  (
    slug: "inference-binned",
    title: "Binned Fit — Least-Squares Fit and Binned Maximum-Likelihood Fit",
    date: "2022-03-10",
    summary: "How to fit binned data",
    file: "pages/inference-binned.typ",
  ),
  (
    slug: "inference-mle",
    title: "Inference — Maximum-Likelihood Estimation",
    date: "2022-03-02",
    summary: "Hands-on for Maximum-Likelihood Estimation, with demonstration for confidence intervals.",
    file: "pages/inference-mle.typ",
  ),
  (
    slug: "why-rss",
    title: "Why RSS",
    date: "2021-02-12",
    summary: "RSS is an old-fashioned way to receive feeds from creators directly. It allows you to access information in a way that is stable, free of distraction and untouched by algorithms.",
    file: "pages/why-rss.typ",
  ),
  (
    slug: "how-to-read-a-book",
    title: "How to Read a Book",
    date: "2020-10-24",
    summary: "The key is to serve your interests, and your interests only.",
    file: "pages/how-to-read-a-book.typ",
  ),
  (
    slug: "produce-xor-edit",
    title: "Produce xor Edit",
    date: "2020-10-18",
    summary: "When you write, either produce content or modify what's been written.",
    file: "pages/produce-xor-edit.typ",
  ),
  (
    slug: "when-to-publish",
    title: "When to Publish",
    date: "2020-10-14",
    summary: "Publish when you can't see a better version of your piece.",
    file: "pages/when-to-publish.typ",
  ),
  (
    slug: "zeroth-impression",
    title: "Zeroth Impression",
    date: "2020-05-08",
    summary: "",
    file: "pages/zeroth-impression.typ",
  ),
  (
    slug: "naval",
    title: "你會成功的，翻譯自 Naval",
    date: "2020-04-26",
    summary: "放輕鬆點，你會成功的。",
    file: "pages/naval.typ",
    lang: "zh-Hant",
  ),
  (
    slug: "regularization",
    title: "How to Avoid Over-Training: Regularization",
    date: "2020-04-20",
    summary: "Otherwise you can hardly get your regresssion done.",
    file: "pages/regularization.typ",
    draft: true,
  ),
  (
    unlisted: true,
    slug: "how-i-managed-to-exercise-for-almost-one-month",
    title: "How I Managed to Exercise for (Almost) One Month",
    date: "2020-04-18",
    summary: "All you need are two cups and a handful of coins.",
    file: "pages/how-i-managed-to-exercise-for-almost-one-month.typ",
  ),
  (
    slug: "chinese-font",
    title: "在 matplotlib 顯示中文",
    date: "2020-04-14",
    summary: "",
    file: "pages/chinese-font.typ",
    lang: "zh-Hant",
  ),
  (
    slug: "free-fall",
    title: "Einstein's Equivalence Principle in Quantum Mechanics",
    date: "2020-04-11",
    summary: "Was Einstein correct even for Quantum Mechanics?",
    file: "pages/free-fall.typ",
    draft: true,
  ),
  (
    slug: "rosenbrock",
    title: "How Different Optimizers Perform On Rosenbrock Function",
    date: "2020-04-07",
    summary: "Sometimes you need more than Gradient Descent to converge.",
    file: "pages/rosenbrock.typ",
    draft: true,
  ),
  (
    slug: "so-you-are-learning-python",
    title: "\"So you are learning Python\"",
    date: "2020-04-03",
    summary: "Learning programming as a non-CS major.",
    file: "pages/so-you-are-learning-python.typ",
  ),
  (
    slug: "having-exam",
    title: "如何考試",
    date: "2019-12-22",
    summary: "",
    file: "pages/having-exam.typ",
    lang: "zh-Hant",
  ),
  (
    slug: "mathjax-test",
    title: "測試 MathJax",
    date: "2019-12-03",
    summary: "",
    file: "pages/mathjax-test.typ",
    draft: true,
  ),
  (
    slug: "python-tutor",
    title: "Python 教學隨筆",
    date: "2019-11-24",
    summary: "",
    file: "pages/python-tutor.typ",
    lang: "zh-Hant",
  ),
)

// draft: not built at all. unlisted: built at its URL, but kept out of the
// index and the feed.
#let published = posts.filter(p => not p.at("draft", default: false)).sorted(key: p => p.date).rev()
#let listed = published.filter(p => not p.at("unlisted", default: false))

#for p in published {
  document("blog/" + p.slug + "/index.html", title: p.title)[
    #show: site.with(title: p.title, date: p.date, lang: p.at("lang", default: "en"))
    #page-dir.update(p.slug)
    #include(p.file)
    #comments()
  ]
}

#document("about/index.html", title: "About")[
  #show: site.with(title: "About")
  #page-dir.update("about")
  #include("pages/about.typ")
]

#document("index.html", title: site-title)[
  #show: site.with(title: site-title)
  #html.elem("ul", attrs: (class: "posts"))[
    #for p in listed [
      #html.elem("li")[
        #link("/blog/" + p.slug + "/", p.title)
        #html.elem("time", attrs: (datetime: p.date), p.date)
      ]
    ]
  ]
]

#asset("index.xml", rss(listed))

// Every image() used by any document above is copied to the same path in
// the output, so pages only need to reference files under static/.
#context for path in query(image).map(it => it.source.replace(regex("^(\.\./)+"), "")).dedup() {
  asset(path, read(path, encoding: none))
}
