---
date: 2020-04-20T17:19:45+08:00
title: "How to Avoid Over-Training: Regularization"
images: ["/images/regularization.png"]
summary: Otherwise you can hardly get your regresssion done.
draft: true
math: true
---

In [the previous post](https://yuan-ru-lin.github.io/posts/rosenbrock/), we saw how different optimizers performed on Rosenbrock function. It seems as long as we chose the right optimizer and the right initial point, we can always arrive the minimum point of the loss function and the story will turn out good.

The sad truth is, even if you can minimumize the loss function, the story may still turn out dissappointing in real life.

In real life, we only have some data points sampled from a unknown function. In such case, we can only assume the function lay inside a set of function, e.g., 4th-order polynomials, and make sure the coefficients minimize the loss function. In other words, we need to perform regression study.

Problems arise more than that. When there are noises in the data used to fit the function, you could over-train your model.

{{< figure src="./overtraining.png" >}}

The curly shape, or, analytically speaking, large higher-order derivatives of the loss function, are essentially the large magnitude of the weights $w^i$.

So, if we can keep the weights small, we can at least mitigate over-training to some extent. Such methodology is called regularization.

{{< figure src="./regularization.png" >}}

The implementation is simple: besides the sum of residual squares, we add another term involving the magnitude of the weights into our loss function.

If the term is $L^2$-norm of the weights parameters, we call the minimization **Ridge Regression**. If the term is $L^1$-norm instead, we call the minimization **LASSO**. That is,

\begin{align}
\textbf{w}_{Ridge}(\lambda) = \underset{\textbf{w}\in\mathbb{R}^p}{\operatorname{argmin}} ||\textbf{X}\textbf{w}-\textbf{y}||^2_2+\lambda||\textbf{w}||_2^2, \newline \textbf{w}\_{LASSO}(\lambda) = \underset{\textbf{w}\in\mathbb{R}^p}{\operatorname{argmin}}||\textbf{X}\textbf{w}-\textbf{y}||^2_2+\lambda||\textbf{w}||_1.
\end{align}

We call the $L^1$-norm or $L^2$-norm regularization terms. The parameter $\lambda$ is another hyperparamete that is set before the training process.

In the example below, we would see

- how each weight go to zero as $\lambda$ goes larger, and
- how weights and performance scale as $\lambda$ goes larger.

### Disclaimer

This is the second homework for the course _Machine Learning and Manybody Physics_ by Prof. Ying-Jer Kao, National Taiwan University.

## Imports

```python
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import matplotlib as mpl
import matplotlib.gridspec as gridspec
mpl.rcParams.update({
    'figure.dpi': 150,
    'figure.facecolor': 'white',
})
```

## Download the dataset

Here we download the assigned dataset and write it on the disk as `output.zip`.

```python
from urllib.request import urlopen
download_url = 'https://archive.ics.uci.edu/ml/machine-learning-databases/00440/sgemm_product_dataset.zip'
output = open('output.zip', 'wb')
output.write(urlopen(download_url).read())
output.close()
```

## Preprocessing

After reading the content from `output.zip`, we calculate the average run time `df['avg_run']` by taking the mean of the four running time columns.

```python
from zipfile import ZipFile
with ZipFile('output.zip') as myZip:
    with myZip.open('sgemm_product.csv') as myCsv:
        df = pd.read_csv(myCsv)
```

```python
df['avg_run'] = df.iloc[:,-4:18].mean(axis=1)
```

```python
from sklearn.model_selection import train_test_split
X_train, X_test, y_train, y_test = train_test_split(df.iloc[:,:14], df['avg_run'])
```

## Training with Ridge Regression and LASSO respectively

The regressions are already implemented in `sklearn.liner_model`. So I will just call them.

The performance of the training is evaluated by the coefficients of determination $R^2$:

$$R^2 = 1 - \frac{(y_{pred}-y_{true})^2}{(y_{true}-\langle y_{true}\rangle)^2}.$$

It would result in 1 if the prediction is perfect, but no lower bound.

```python
from sklearn.linear_model import Ridge, Lasso

ridge_train_r2 = []
ridge_test_r2 = []
ridge_coefs = np.zeros(shape=(11, 14))
lasso_train_r2 = []
lasso_test_r2 = []
lasso_coefs = np.zeros(shape=(11, 14))
alphas = 10 ** np.linspace(-4, 6, 11)

for i in range(len(alphas)):
    clf = Ridge(alpha=alphas[i], copy_X=True, solver='saga')
    clf.fit(X_train, y_train)
    ridge_train_r2.append(clf.score(X_train, y_train))
    ridge_test_r2.append(clf.score(X_test, y_test))
    ridge_coefs[i] = clf.coef_

    clf2 = Lasso(alpha=alphas[i], copy_X=True)
    clf2.fit(X_train, y_train)
    lasso_train_r2.append(clf2.score(X_train, y_train))
    lasso_test_r2.append(clf2.score(X_test, y_test))
    lasso_coefs[i] = clf2.coef_
```

```python
fig = plt.figure(tight_layout=True)
gridspec.GridSpec(2,2)

x = np.linspace(-4, 6, 11)
plt.subplot2grid((2,2), (1,0), colspan=2, rowspan=1)
plt.plot(x, np.array(ridge_train_r2), label='Ridge Train')
plt.plot(x, np.array(ridge_test_r2), label='Ridge Test')
plt.plot(x, np.array(lasso_train_r2), label='LASSO Train')
plt.plot(x, np.array(lasso_test_r2), label='LASSO Test')
plt.xlabel('$log(\lambda)$')
plt.ylabel('$R^2$')
plt.title('Performance')
plt.legend(loc='lower left')
plt.subplot2grid((2,2), (0,0), colspan=1, rowspan=1)
plt.plot(x, ridge_coefs)
plt.xlabel('$log(\lambda)$')
plt.ylabel('$w^i$')
plt.title('$w^i$ of Ridge Regression')
plt.subplot2grid((2,2), (0,1), colspan=1, rowspan=1)
plt.plot(x, lasso_coefs)
plt.xlabel('$log(\lambda)$')
plt.ylabel('$w^i$')
plt.title('$w^i$ of LASSO')
```

{{< figure src="./index_15_1.png" >}}

## Summary

- The magnitudes of weights go to 0 eventually. Weights in Ridge Regression converge faster than those in LASSO.
- The performance difference between training and testing are few in both cases.
- The performance in LASSO decay within $\lambda \in [100, 1000],$ while that in Ridge Regression remains even when $\lambda=10^6.$
- Weights in LASSO shrink to zero when $\lambda = 10^4$ which corresponds to the vanishing performance, and the model becomes a constant model after $\lambda = 10^4.$
