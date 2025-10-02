---
title: "Using PyCall with uv-managed Python Environments"
date: 2025-10-02
draft: false
tags: ["julia", "python", "pycall", "uv"]
---

## The Problem

When using PyCall.jl with Python executables and packages managed by [uv](https://github.com/astral-sh/uv), PyCall can find the Python executable in the virtual environment but doesn't recognize packages installed via `uv add`.

## The Solution

Add the uv virtual environment's site-packages to Python's path before importing packages:

```julia
pushfirst!(pyimport("sys")."path", realpath(".venv/lib/python3.11/site-packages/"))
```

This prepends the uv virtual environment's package directory to Python's module search path, allowing PyCall to find all packages installed via uv.

**Note:** Adjust the Python version in the path (`python3.11`) to match your virtual environment's Python version.