---
title: Einstein's Equivalence Principle in Quantum Mechanics
date: 2020-04-11T5:27:20+08:00
images: ["/images/ashley-bean-LDas7wp3E4I-unsplash.jpg"]
tags: [Physics]
summary: Was Einstein correct even for Quantum Mechanics?
draft: true
math: true
---

Consider a particle in free falling. We have the Schrodinger equation:

$$
i\hbar \frac{\partial \psi}{\partial t} = - \frac{\hbar^2}{2m} \nabla^{2} \psi + V \psi,
$$

where the potential is the potential that it would have in inertial frame plus the gravity potential, i.e., $V(\vec{r})=V_0(\vec{r})+mgz.$

Since Einstein's Equivalence Principle suggests frames under the effect of gravity can be thought nothing but acceleration, we are interested in if there is a transformation of the wavefunction $\psi$ that holds the Schrodinger equation in the accelerated frame, i.e., $t'=t,\ x'=x,\ y'=y,\ z'=z+\frac{1}{2}gt^2.$

### Disclaimer

This is a homework problem for _General Relativity_ by Pei-Ming Ho, National Taiwan University.

## Solution

Assume there is a transformed wavefunction within the accelerated frame, or, the freely falling frame that holds the Schrodinger equation

$$
i\hbar \frac{\partial \psi'}{\partial t'} = - \frac{\hbar^2}{2m} \nabla^{2}{'} \psi' + V_0 \psi'.
$$

Notice the potential term is now $V_0$ as Equivalence Principle suggests.

Expanding $\frac{\partial}{\partial t'} = \frac{\partial}{\partial t} - gt\frac{\partial}{\partial z},$ and keeping $\frac{\partial}{\partial z'} = \frac{\partial}{\partial z},$ we have the equation turning out to be

$$i\hbar (\frac{\partial}{\partial t} - gt\frac{\partial}{\partial z}) \psi' = - \frac{\hbar^2}{2m} \nabla^2 \psi' + V_0 \psi'.$$

The trick we are going to use now is to assume there exists an unitary transformation $e^{f(t, z)}$, where $f$ is pure-imaginary, such that

$$\psi' = e^{f(t,z)} \psi$$

and solve the primed equation for $f(t,z)$.

Seeing the whole equation,

\begin{equation}
i\hbar \underbrace{\big(\frac{\partial}{\partial t} - gt\frac{\partial}{\partial z}\big) \big(e^{f(t,z)} \psi\big)}\_{\text{Part I}} = - \frac{\hbar^2}{2m} \underbrace{\nabla^2 \big(e^{f(t,z)} \psi\big)}_{\text{Part II}} + V_0 e^{f(t,z)} \psi,
\end{equation}

we now calculate Part I, II respectively:

\begin{align}
\text{Part I} = e^{f(t,z)} \frac{\partial f}{\partial t} \psi + e^{f(t,z)} \frac{\partial \psi}{\partial t} - gt e^{f(t,z)} \frac{\partial f}{\partial z} \psi - gt e^{f(t,z)} \frac{\partial \psi}{\partial z},
\end{align}

and

\begin{align}
\text{Part II} &= \nabla \cdot \nabla \big(e^{f(t,z)} \psi\big) \newline
&= \nabla \cdot \big(e^{f(t,z)} \nabla\psi + e^{f(t,z)} \frac{\partial f}{\partial z} \psi \hat{z} \big) \newline
&= \big(e^{f(t,z)} \nabla^2 \psi + e^{f(t,z)} \frac{\partial f}{\partial z} \frac{\partial \psi}{\partial z} +
e^{f(t,z)} (\frac{\partial f}{\partial z})^2 \psi +
e^{f(t,z)} \frac{\partial f}{\partial z} \frac{\partial \psi}{\partial z} \big) \newline
&= \big(e^{f(t,z)} \nabla^2 \psi + 2 e^{f(t,z)} \frac{\partial f}{\partial z} \frac{\partial \psi}{\partial z} +
e^{f(t,z)} (\frac{\partial f}{\partial z})^2 \psi \big)
\end{align}

Plugging them back, then dividing both sides by $e^{f(t,z)},$ we now have

$$
i\hbar\big( \frac{\partial f}{\partial t} \psi + \frac{\partial \psi}{\partial t} - gt \frac{\partial f}{\partial z} \psi - gt  \frac{\partial \psi}{\partial z} \big) = - \frac{\hbar^2}{2m} \big( \nabla^2 \psi + 2 \frac{\partial f}{\partial z} \frac{\partial \psi}{\partial z} + (\frac{\partial f}{\partial z})^2 \psi \big) + V_0 \psi.
$$

Now, since there is $i\hbar \frac{\partial \psi}{\partial t}$ on the LHS and $- \frac{\hbar^2}{2m} \nabla^{2} \psi$ on the RHS, we can use the Schrodinger equation in the inertia frame to get $V\psi=(mgz + V_0)\psi$ on the LHS; canceling $V_0\psi$ on the both sides, we now have:

$$
i\hbar\big( \frac{\partial f}{\partial t} \psi - gt \frac{\partial f}{\partial z} \psi - gt  \frac{\partial \psi}{\partial z} \big) + mgz\psi = - \frac{\hbar^2}{2m} \big( 2 \frac{\partial f}{\partial z} \frac{\partial \psi}{\partial z} + (\frac{\partial f}{\partial z})^2 \psi \big).
$$

But $\frac{\partial \psi}{\partial z}$ should be irrelevant to the determination of $f.$ Thus the terms involving $\frac{\partial \psi}{\partial z}$ must cancel, leading to

$$
-i\hbar gt = - \frac{\hbar^2}{m}\frac{\partial f}{\partial z},
$$

or

$$
f(t,z) = \frac{imgtz}{\hbar} + \frac{i}{\hbar} C(t) = \frac{i}{\hbar}(mgtz + C(t))
$$

for some $C=C(t).$

For the remaining equation, i.e.,

\begin{align}
&i\hbar\big( \frac{\partial f}{\partial t} \psi - gt \frac{\partial f}{\partial z} \psi \big) + mgz\psi = - \frac{\hbar^2}{2m}(\frac{\partial f}{\partial z})^2 \psi, \newline
&\big[ i\hbar\big( \frac{\partial f}{\partial t} - gt \frac{\partial f}{\partial z} \big) + mgz + \frac{\hbar^2}{2m}(\frac{\partial f}{\partial z})^2 \big] \psi = 0,
\end{align}

or

$$
i\hbar\big( \frac{\partial f}{\partial t} - gt \frac{\partial f}{\partial z} \big) + mgz + \frac{\hbar^2}{2m}(\frac{\partial f}{\partial z})^2 = 0,
$$

we plug in $\frac{\partial f}{\partial t}=\frac{i(mgz + C'(t))}{\hbar}$ and $\frac{\partial f}{\partial z}=\frac{imgt}{\hbar}$:

\begin{align}
&i\hbar\big( \frac{i(mgz + C'(t))}{\hbar} - gt \frac{imgt}{\hbar} \big) + mgz + \frac{\hbar^2}{2m}(\frac{imgt}{\hbar})^2 = 0, \newline
&-\big(mgz+C'(t)\big)+mg^2t^2+mgz-\frac{1}{2}mg^2t^2=0, \newline
&C'(t) = \frac{1}{2}mg^2t^2,
\end{align}

which gives $C(t) = \frac{1}{6}mg^2t^3.$

Thus

$$
f(t, z) = \frac{i}{\hbar}(mgtz + \frac{1}{6}mg^2t^3).
$$

## References

1. [_Canonical equivalence of gravity and acceleration — two-page-tutorial_ by Lajos Di ́osi, Wigner Research Center for Physics](http://www.rmki.kfki.hu/~diosi/tutorial/freefalltutor.pdf)
