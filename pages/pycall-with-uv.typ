#import "../template.typ": note

= The Problem
<the-problem>
When using PyCall.jl with Python executables and packages managed by #link("https://github.com/astral-sh/uv")[uv], PyCall can find the Python executable in the virtual environment but doesn't recognize packages installed via `uv add`.

= The Solution
<the-solution>
Add the uv virtual environment's site-packages to Python's path before importing packages:

```julia
pushfirst!(pyimport("sys")."path", realpath(".venv/lib/python3.11/site-packages/"))
```

This prepends the uv virtual environment's package directory to Python's module search path, allowing PyCall to find all packages installed via uv.

#strong[Note:] Adjust the Python version in the path (`python3.11`) to match your virtual environment's Python version.
