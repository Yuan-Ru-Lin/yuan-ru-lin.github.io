---
authors:
    - Leon Lin
date: 2020-04-07T23:30:37+08:00
title: "How Different Optimizers Perform On Rosenbrock Function"
tags: ["Machine Learning"]
images: ["/images/index_7_1.png"]
summary: Sometimes you need more than Gradient Descent to converge.
draft: true
math: true
---

In Machine Learning, an important concept is an optimizer. An optimizer is – in layman's term – how we plan to arrive to the global miminum of a given function.

A heuristic method is Gradient Descent (**GD**), which is essentially the very start of every machine learning course. However, there are other modified methods such as Gradient Descent with Classic Momentum (**GDM**), Nesterov Accelerated Gradient (**NAG**), Root-Mean-Square Propagation (**RMSProp**), and Adaptive Momentum Estimation (**ADAM**).

In this notebook, we examine how each method mentioned above perform on a simple function named Rosenbrock function.

### Disclaimer

This is the first homework for the course _Machine Learning and Manybody Physics_ by Prof. Ying-Jer Kao, National Taiwan University.

## Imports

```python
import numpy as np
import matplotlib as mpl
mpl.rcParams.update({
    'figure.dpi': 150,
    'figure.facecolor': 'white',
})
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D
```

## Exploratory Analysis

We define the Rosenbrock function below: $$f(x,y) = (a-x)^2 + b(y-x^2)^2.$$

```python
def rosenbrock(x, y, a=1, b=100):
    return (a-x)**2 + b * (y-x**2)**2
```

```python
fig = plt.figure()
ax = fig.add_subplot(111, projection='3d')
x = np.linspace(-3, 3, 601)
y = np.linspace(-1, 5, 601)
X, Y = np.meshgrid(x, y)
ax.plot_surface(X, Y, Z=np.vectorize(rosenbrock)(X, Y))
ax.view_init(elev=50, azim=260)
ax.set_title("Rosenbrock function")
```

{{< figure src="./index_7_1.png" >}}

**Remarks:**

- There are three parts: a upper hill, a valley, and a rapidly-rising wall.
- Generally speaking, it's not that rugged.

## Modeling

We define the gradient of $f,\ \nabla f$ below:

```python
def gradient(x, y, a=1., b=100.):
    return np.array([2 * (x-a) + 2 * b * x * (x**2 - y), 2 * b * (y - x**2)])
```

Then we define each learning method as the lecture notebook did:

```python
def learn(x, y, gamma=0., eta=0.001, iteration=10000,
          NAG=False,
          RMSProp=False,
          ADAM=False,
          beta1=0.9, beta2=0.999, epsilon=1e-8):

    location = np.array([x, y])
    history = [[*location, rosenbrock(*location)]]
    velocity = np.array([0., 0.])
    square = 0
    momentum = 0

    for i in range(iteration):
        if NAG:
            velocity = gamma * velocity + eta * gradient(*(location - gamma * velocity))
        elif RMSProp:
            square = square * beta1 + (1-beta1) * gradient(*location)**2
            velocity = eta * gradient(*location) / np.sqrt(square + epsilon)
        elif ADAM:
            momentum = momentum * beta1 + (1-beta1) * gradient(*location)
            square = square * beta2 + (1-beta2) * gradient(*location)**2
            velocity = eta * momentum / np.sqrt(square + epsilon)
        else:
            velocity = gamma * velocity + eta * gradient(*location)
        location -= velocity

        history.append([*location, rosenbrock(*location)])

    return history
```

To examine how each method works in different setting (e.g. learning rate, initial point), we define a function plotting trajectories of each methods:

```python
def plot(eta, iteration, initial_location):
    GD_history = learn(*initial_location, eta=eta, iteration=iteration)
    GDClassicMoment_history = learn(*initial_location, gamma=0.9, eta=eta, iteration=iteration)
    NAG_history = learn(*initial_location, eta=eta, gamma=0.5, NAG=True, iteration=iteration)
    RMSProp_history = learn(*initial_location, eta=eta, RMSProp=True, iteration=iteration)
    ADAM_history = learn(*initial_location, eta=eta, ADAM=True, iteration=iteration)

    x = np.linspace(-3, 3, 901)
    y = np.linspace(-5, 6, 1101)
    X, Y = np.meshgrid(x, y)
    fig, ax = plt.subplots()
    ax.contourf(X, Y, np.vectorize(rosenbrock)(X, Y), 30, alpha=.75, cmap=plt.cm.hot)
    ax.plot(*list(zip(*GD_history))[:2], color='#1f77b4', ls='-', label='GD')
    ax.plot(*list(zip(*GDClassicMoment_history))[:2], color='#ff7f0e', ls='--', ms=1., label='GDM')
    ax.plot(*list(zip(*NAG_history))[:2], color='#2ca02c', ls='--', label='NAG')
    ax.plot(*list(zip(*RMSProp_history))[:2], color='#d62728', ls='--', label='RMSProp')
    ax.plot(*list(zip(*ADAM_history))[:2], color='#9467bd', ls='--', label='ADAM')
    ax.scatter(*initial_location, color='r', marker='*', s=40, label='Start')
    ax.scatter(1., 1., color='#1a55FF', marker='^', s=10, label='Minimum')
    ax.set_title(r'$\eta = $' + str(eta) + ', iteration: ' + str(iteration) + r', $\theta_0 = $' + str(initial_location))
    ax.legend(prop={'size': 6})

    return ax
```

## Analysis

### Starting on the upper plane

Here we observe how each method approaches to the minimum from $\theta_0 = (0, 5)$.

```python
plot(0.001, 1000, (0., 5.))
```

{{< figure src="./index_19_1.png" >}}

In this case, we saw:

- **GDM** has a benefit of early arriving despite the route is messy.
- **NAG** has much less curvature than **GDM** has, but still it can have more variation than pure **GD** does.
- **RMSProp** and **ADAM** don't behave as well as in the lecture  since they require more iteration.

### Starting in the valley

Here we observe how each method approaches to the minimum from $\theta_0 = (2, 4)$.

```python
plot(0.001, 1000, (2., 4.))
```

{{< figure src="./index_23_1.png" >}}

In this case, we saw **GDM** still arrived the minimum earlier than any other method. What's noteworthy is that **NAG** had a little oscillation at the start (but later converged anyway); it resembled a ball placed at a slightly tilted plane.

### Starting from the wall

Here we observe how each method approaches to the minimum from $\theta_0 = (2.75, 3)$.

Note that I shrank the learning rate $\eta$ to $0.0005$ and doubled the iteration here; otherwise **GDM** would blow up.

```python
plot(0.0005, 2000, (2.75, 3))
```

{{< figure src="./index_27_1.png" >}}

In this case, we saw:

- **GDM** again arrived the minimum while others didn't;
- **NAG** resembled **GD** at first, became like **GDM** in the middle, and then went back being **GD** at the end;
- **RMSProp** and **ADAM** didn't have enough iteration.

### Starting near the minimum

In the end, we observe the case where each method starts near the minimum.

Note that I enlarged the learning rate $\eta$ to $0.004$ and shrank the iteration time to 5.

```python
plot(0.004, 5, (1.2, 1.2))
```

{{< figure src="./index_31_1.png" >}}

In this case, we saw:

- **GD** and **NAG** had trouble converging to the minimum for the learning rate was too large;
- **GDM**, on the other hand, had no trouble converging;
- **RMSProp** and **ADAM** converged slowly.

## Summary

The Rosenbrock function under the given setting is a rather simple function. In such simple case, **GDM** and **NAG** or even **GD** have performance better than **RMSProp** and **ADAM** do. However, in reality, it's often not the case and the latter two will would have more advantages.

## Reference

1. [Notebooks for "A high bias low-variance introduction to Machine Learning for physicists."](https://gitlab.com/yingjerkao/mlphysics)
2. [Adagrad、RMSprop、Momentum and Adam – 特殊的學習率調整方式](https://hackmd.io/@allen108108/H1l4zqtp4)
3. [ML Lecture, Hung-yi Lee](https://www.youtube.com/watch?v=CXgbekl66jc&list=PLJV_el3uVTsPy9oCRY30oBPNLCo89yu49)
