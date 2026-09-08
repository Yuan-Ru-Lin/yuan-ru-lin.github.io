#import "../template.typ": note

Consider a particle in free falling. We have the Schrodinger equation:

$ i ℏ frac(partial psi, partial t) = - frac(ℏ^2, 2 m) nabla^2 psi + V psi\, $

where the potential is the potential that it would have in inertial frame plus the gravity potential, i.e., $V\(arrow(r)\)= V_0\(arrow(r)\)+ m g z .$

Since Einstein's Equivalence Principle suggests frames under the effect of gravity can be thought nothing but acceleration, we are interested in if there is a transformation of the wavefunction $psi$ that holds the Schrodinger equation in the accelerated frame, i.e., $t' = t\,med x' = x\,med y' = y\,med z' = z + 1 / 2 g t^2 .$

== Disclaimer
<disclaimer>
This is a homework problem for #emph[General Relativity] by Pei-Ming Ho, National Taiwan University.

= Solution
<solution>
Assume there is a transformed wavefunction within the accelerated frame, or, the freely falling frame that holds the Schrodinger equation

$ i ℏ frac(partial psi', partial t') = - frac(ℏ^2, 2 m) nabla^2' psi' + V_0 psi' . $

Notice the potential term is now $V_0$ as Equivalence Principle suggests.

Expanding $frac(partial, partial t') = frac(partial, partial t) - g t frac(partial, partial z)\,$ and keeping $frac(partial, partial z') = frac(partial, partial z)\,$ we have the equation turning out to be

$ i ℏ\(frac(partial, partial t) - g t frac(partial, partial z)\)psi' = - frac(ℏ^2, 2 m) nabla^2 psi' + V_0 psi' . $

The trick we are going to use now is to assume there exists an unitary transformation $e^(f\(t\,z\))$, where $f$ is pure-imaginary, such that

$ psi' = e^(f\(t\,z\)) psi $

and solve the primed equation for $f\(t\,z\)$.

Seeing the whole equation,

we now calculate Part I, II respectively:

and

Plugging them back, then dividing both sides by $e^(f\(t\,z\))\,$ we now have

$ i ℏ ( frac(partial f, partial t) psi + frac(partial psi, partial t) - g t frac(partial f, partial z) psi - g t frac(partial psi, partial z) ) = - frac(ℏ^2, 2 m) ( nabla^2 psi + 2 frac(partial f, partial z) frac(partial psi, partial z) +\(frac(partial f, partial z)\)^2 psi ) + V_0 psi . $

Now, since there is $i ℏ frac(partial psi, partial t)$ on the LHS and $- frac(ℏ^2, 2 m) nabla^2 psi$ on the RHS, we can use the Schrodinger equation in the inertia frame to get $V psi =\(m g z + V_0\)psi$ on the LHS; canceling $V_0 psi$ on the both sides, we now have:

$ i ℏ ( frac(partial f, partial t) psi - g t frac(partial f, partial z) psi - g t frac(partial psi, partial z) ) + m g z psi = - frac(ℏ^2, 2 m) ( 2 frac(partial f, partial z) frac(partial psi, partial z) +\(frac(partial f, partial z)\)^2 psi ) . $

But $frac(partial psi, partial z)$ should be irrelevant to the determination of $f .$ Thus the terms involving $frac(partial psi, partial z)$ must cancel, leading to

$ - i ℏ g t = - ℏ^2 / m frac(partial f, partial z)\, $

or

$ f\(t\,z\)= frac(i m g t z, ℏ) + i / ℏ C\(t\)= i / ℏ\(m g t z + C\(t\)\) $

for some $C = C\(t\).$

For the remaining equation, i.e.,

or

$ i ℏ ( frac(partial f, partial t) - g t frac(partial f, partial z) ) + m g z + frac(ℏ^2, 2 m)\(frac(partial f, partial z)\)^2 = 0\, $

we plug in $frac(partial f, partial t) = frac(i\(m g z + C'\(t\)\), ℏ)$ and $frac(partial f, partial z) = frac(i m g t, ℏ)$:

which gives $C\(t\)= 1 / 6 m g^2 t^3 .$

Thus

$ f\(t\,z\)= i / ℏ\(m g t z + 1 / 6 m g^2 t^3\). $

= References
<references>
+ #link("http://www.rmki.kfki.hu/~diosi/tutorial/freefalltutor.pdf")[#emph[Canonical equivalence of gravity and acceleration --- two-page-tutorial] by Lajos Di ́osi, Wigner Research Center for Physics]
