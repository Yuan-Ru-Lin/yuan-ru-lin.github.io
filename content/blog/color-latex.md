---
title: How to Use Colors in $\LaTeX$
date: 2022-05-05
summary: So you can write something like $\color{orange} A = \textcolor{blue}{B} \mathbin{\textcolor{red}{-}} \textcolor{green}{C}.$
---

Sometimes, it helps to put colors on your symbols so that your audiences can grasp equations or definitions at a glance, especally when you are giving presentations with lots of them.

A complete solution is given [here](https://tex.stackexchange.com/questions/21598/how-to-color-math-symbols).

I'll just give you an example which goes like

```tex
$$\color{orange} A = \textcolor{blue}{B} \mathbin{\textcolor{red}{-}} \textcolor{green}{C}$$
```

And that gets compiled to be

$$\color{orange} A = \textcolor{blue}{B} \mathbin{\textcolor{red}{-}} \textcolor{green}{C}.$$

## A Remark

What's good about this solution is that it depends only on $\LaTeX$ itself. That is, any platform that supports $\LaTeX$ (plus some basic packages) will support this solution.

For instance, I typically use

* Kenote to make slides,
* $\KaTeX$ to write blogs and
* iA Writer to jot down notes (or logs).

And all of them support this solution.