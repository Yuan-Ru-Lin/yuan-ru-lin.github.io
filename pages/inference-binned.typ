#import "../template.typ": note

= Prologue
<prologue>
This is a record of a workshop on statistics held among the High-Energy Physics group of National Taiwan University in 2022.

The textbook referred to throughout the record is Behnke, O. (2013) #emph[Data analysis in high energy physics a practical guide to statistical methods / edited by Olaf Behnke…\[et al.\].] 1st ed.~Weinheim, Germany: Wiley-VCH.

In this week, we covered Sec.2.4--2.6, which was mainly about the method of least squares and maximum-likelihood fits.

The workshop was to let the participants reproduce the histogram fitting on $M_(mu^(+) mu^(-))$ in Subsubsec.2.4.2.1.

= Tools#footnote[It's assumed that you've already imported the familiar modules i.e.~`import numpy as np; import matplotlib.pyplot as plt; import scipy.stats as st; import scipy.optimize as opt`.]
<toolsimports>
== `np.concatenate`
<np.concatenate>
```python
a = np.asarray([1, 2])
b = np.asarray([3, 4])
c = np.concatenate((a, b))  # Note the ntuple!
print(c)
```

```plaintext
[1 2 3 4]
```

== `plt.hist`
<plt.hist>
Does not just draw a histogram, but also returns the histogram and the bins in use.

```python
entries, bins, _ = plt.hist(st.norm.rvs(size=1000))
```

= Least-Squares Fit
<least-squares-fit>
== Prepare pseudo-data and histograms
<prepare-pseudo-data-and-histograms>
By inspection and information given in the book, it seems that

- the number of bins is 60,
- the background events can be simulated by `st.uniform(loc=2, scale=2)` and the event number is roughly 1000, and
- the signal events can be simulated by `st.norm(loc=3.1, scale=0.05)` and the event number is roughly 100.

#figure(image("../static/inference-binned/data.png", alt: "The dataset should look like this."),
  caption: [
    The dataset should look like this.
  ]
)

== Construct expected number of events in each bin
<construct-expected-number-of-events-in-each-bin>
Assuming we know the exact numbers of background and signal events, then the number of events in each bin is just $ f_i = 1000 dot.op f_i^B + 100 dot.op f_i^S\, $ where $f_i^B$ and $f_i^S$ are probabilities of events in the $i$-th bin i.e.~

$ f_i^B & = integral_(x_i^(upright(l o w)))^(x_i^(upright(u p))) f^B\(x\)thin d x\,\
f_i^S & = integral_(x_i^(upright(l o w)))^(x_i^(upright(u p))) f^S\(x\;M\)thin d x . $

In the discrete case, we can approximate the integral as $ f_i^B = integral_(x_i^(upright(l o w)))^(x_i^(upright(u p))) f^B thin d x approx sum_i f^B\(x_i^c\)thin Delta x_i\, $ and so on, where $x_i^c$ is the center of the bin i.e.~$x_i^c =\(x_i^(upright(u p)) + x_i^(upright(l o w))\)\/2 .$

#figure(image("../static/inference-binned/data_with_pdf.png", alt: "The expected number of events, when drawn on the previous plot, should look like this. Here M = 3.1."),
  caption: [
    The expected number of events, when drawn on the previous plot, should look like this. Here $M = 3.1$.
  ]
)

== Calculate, plot and minimize $chi^2$
<calculate-plot-and-minimize-chi2>
Recall that the (Neyman's) $chi^2$ value can be calculated as $ chi^2\(M\)= sum_(upright("bin") i) frac([ k_i - f_i\(M\)]^2, k_i) . $

#figure(image("../static/inference-binned/chi2.png", alt: "Your \\chi^2 values should look like this."),
  caption: [
    Your $chi^2$ values should look like this.
  ]
)

= Binned Maximum-Likelihood Fits
<binned-maximum-likelihood-fits>
Use the same dataset (and the same histogram) to perform Binned MLE. Note that the log-likelihood in the binned case is $ ln L\(M\)= sum_(i = 1)^B k_i ln P_i\(M\)+ upright("constant")\, $ where $P_i\(M\)$ is the #strong[likelihood] computed with the probability of events falling within the $i$-th bin.

= Remarks
<remarks>
== On Numbers of Generated Events
<on-numbers-of-generated-events>
What would happen if we only generated `st.norm.rvs(loc=3.1, scale=0.05, size=100)` and set bins as `np.linspace(-5, 5, 101)` instead? What assumption of Least-Squares Fit would be violated? What Python error would you get?

== On Assumptions of Event Numbers
<on-assumptions-of-event-numbers>
Recall that we assume that we know the exact numbers of both signal and background events. That is not a common situation in practice, though. We typically need to turn those event numbers into parameters as well. And that is what the next week's workshop is about, Extended Maximum-Likelihood Fits.

== On $chi_(upright("min"))^2$
<on-chi2_textrmmin>
You may get $chi_(upright("min"))^2$ deviated from the expected value, which is 59, as much as, say, 68. Do you think it's reasonable? (Hint: go the wikipedia page of $chi^2$ distribution and look for the quantity related to expected deviation from the expected value.)
