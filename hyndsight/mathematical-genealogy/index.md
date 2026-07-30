---
date: 2026-07-30
title: Mathematical genealogy
categories:
  - genealogy
  - mathematics
---

Having a PhD student is like having a child.
I have had many such "children" graduate, and have another two "on the way".
(See [here](/research-team) for my offspring.)

Going in the other direction, here is my family tree, compiled from the
[Mathematics Genealogy Project](https://www.mathgenealogy.org) (MGP).
Each person advised the one below them.
Hover over a portrait (or tap it) to see who they were.

Many people have two or more advisors, so there are multiple "lines of ascent" (as there are with regular family trees).
I am showing two of many possible ancestry lines here, which happened to
reconnect in the 1600s.

```{=html}
<style>
.gen {
  --gen-fig: 56px;
  --gen-rail: 27px;      /* centre of the portrait, minus the 2px rail width */
  --gen-gap: 2rem;
  --gen-line: rgba(128,128,128,.45);
  --gen-line: color-mix(in srgb, currentColor 30%, transparent);
  --gen-pop-bg: var(--bs-body-bg, #fff);
  --gen-pop-fg: var(--bs-body-color, inherit);
  margin: 2rem 0 1rem;
  font-size: .95rem;
}

/* ---- rows ---------------------------------------------------------- */
.gen ol { list-style: none; margin: 0; padding: 0; }
.gen-chain { position: relative; }
.gen-chain::before {                       /* the vertical rail */
  content: ""; position: absolute; z-index: 0;
  left: var(--gen-rail); top: 0; bottom: 0; width: 2px;
  background: var(--gen-line);
}
.gen-row {
  position: relative; z-index: 1;
  display: flex; align-items: center; gap: .7rem;
  padding: 3px 0;
}
.gen-row:hover, .gen-row:focus-within { z-index: 2; }
.gen-row--spacer { height: calc(var(--gen-fig) + 6px); }
.gen-node {
  display: flex; align-items: center; gap: .7rem;
  border: 0; background: none; padding: 0; margin: 0;
  font: inherit; color: inherit; text-align: left; cursor: help;
}
.gen-node:focus-visible { outline: 2px solid currentColor; outline-offset: 3px; border-radius: 4px; }

.gen-fig {
  position: relative; flex: 0 0 auto;
  width: var(--gen-fig); height: var(--gen-fig);
  border-radius: 50%; overflow: hidden;
  background: var(--gen-line);
  display: grid; place-items: center;
}
.gen-fig::after {                          /* initials, shown if the photo is missing */
  content: attr(data-initials);
  font-size: .8rem; font-weight: 600; letter-spacing: .02em; opacity: .8;
}
.gen-fig img {
  position: absolute; inset: 0; z-index: 1;
  width: 100%; height: 100%; object-fit: cover; object-position: top center;
  margin: 0;
}
.gen-name { font-weight: 600; line-height: 1.2; }
.gen-meta { display: block; font-size: .78rem; font-style: italic; opacity: .75; }

/* ---- pop-ups ------------------------------------------------------- */
.gen-pop {
  position: absolute; z-index: 30; top: -4px; left: calc(var(--gen-fig) + 1rem);
  width: min(24rem, 46vw);
  opacity: 0; visibility: hidden; transform: translateY(-4px);
  transition: opacity .12s ease, transform .12s ease;
  background: var(--gen-pop-bg); color: var(--gen-pop-fg);
  border: 1px solid var(--gen-line); border-radius: 6px;
  padding: .7rem .85rem; font-size: .82rem; line-height: 1.45;
  box-shadow: 0 8px 24px rgba(0,0,0,.18);
}
.gen-pop p { margin: 0 0 .45rem; }
.gen-pop p:last-child { margin-bottom: 0; }
.gen-pop .gen-caveat { opacity: .8; font-size: .95em; }
.gen-pop .gen-inset {
  float: right; width: 64px; margin: 0 0 .4rem .6rem; border-radius: 3px;
}
.gen-pop-head {
  --gen-fig: 34px;
  display: flex; align-items: center; gap: .6rem;
  margin: -.7rem -.85rem .6rem; padding: .6rem .85rem;
  border-bottom: 1px solid var(--gen-line);
}
.gen-pop-head .gen-name { font-size: .95rem; }
.gen-pop-head .gen-meta { font-size: .72rem; }
.gen-branch--right .gen-pop { left: auto; right: calc(var(--gen-fig) + 1rem); }
.gen-row:hover .gen-pop,
.gen-row:focus-within .gen-pop { opacity: 1; visibility: visible; transform: none; }

/* ---- fork and merge ------------------------------------------------ */
.gen-branches { display: grid; grid-template-columns: 1fr 1fr; gap: var(--gen-gap); }
.gen-join { display: grid; grid-template-columns: 1fr 1fr; gap: var(--gen-gap); height: 1.4rem; }
.gen-join > span { position: relative; }
.gen-join > span::before {                 /* the two legs */
  content: ""; position: absolute; left: var(--gen-rail); top: 0; bottom: 0;
  width: 2px; background: var(--gen-line);
}
.gen-join--fork > span:first-child::after,
.gen-join--merge > span:first-child::after {   /* the crossbar */
  content: ""; position: absolute; left: var(--gen-rail);
  width: calc(100% + var(--gen-gap)); height: 2px; background: var(--gen-line);
}
.gen-join--fork  > span:first-child::after { top: 0; }
.gen-join--merge > span:first-child::after { bottom: 0; }
.gen-join--merge > span:last-child::before { bottom: 2px; }

.gen-label {
  font-size: .75rem; text-transform: uppercase; letter-spacing: .06em;
  opacity: .6; margin: 0 0 .35rem calc(var(--gen-fig) + .7rem);
}
.gen-caption { font-size: .8rem; opacity: .75; margin: .6rem 0 0; }

/* ---- narrow screens ------------------------------------------------ */
@media (max-width: 700px) {
  .gen-branches { grid-template-columns: 1fr; gap: 0; }
  .gen-join, .gen-join--fork, .gen-join--merge { display: none; }
  .gen-branch + .gen-branch { margin-top: 1.5rem; }
  .gen-pop {
    position: static; width: auto; display: none; opacity: 1; visibility: visible;
    transform: none; margin: .4rem 0 .4rem calc(var(--gen-fig) + .7rem);
    box-shadow: none;
  }
  .gen-row { flex-wrap: wrap; }
  .gen-row:hover .gen-pop, .gen-row:focus-within .gen-pop { display: block; }
  .gen-branch--right .gen-pop { right: auto; }
  .gen-pop-head { display: none; }
  .gen-row--spacer { display: none; }
}
@media (prefers-reduced-motion: reduce) {
  .gen-pop { transition: none; }
}
</style>

<div class="gen">

<!-- ============ shared root ============ -->
<ol class="gen-chain">
  <li class="gen-row">
    <button type="button" class="gen-node">
      <span class="gen-fig" data-initials="JT"><img src="/genealogy/thomasius.jpg" alt="Jakob Thomasius"></span>
      <span class="gen-name">Jakob Thomasius<span class="gen-meta">Universität Leipzig, 1643</span></span>
    </button>
    <span class="gen-pop">
      <span class="gen-pop-head"><span class="gen-fig" data-initials="JT"><img src="/genealogy/thomasius.jpg" alt="Jakob Thomasius"></span><span class="gen-name">Jakob Thomasius<span class="gen-meta">Universität Leipzig, 1643</span></span></span>
      <p>B. 1622, Leipzig. D. 1684, Leipzig.</p>
      <p>Philosopher and philologist at Leipzig, and the teacher both branches share. He supervised Leibniz's 1666 philosophy degree and Otto Mencke's 1665 thesis, which is where the two lines below separate.</p>
      <p><a href="https://en.wikipedia.org/wiki/Jakob_Thomasius">Wikipedia</a></p>
    </span>
  </li>
</ol>

<div class="gen-join gen-join--fork"><span></span><span></span></div>

<!-- ============ the two branches ============ -->
<div class="gen-branches">

<!-- ---------- left branch: through Adrian Raftery ---------- -->
<div class="gen-branch gen-branch--left">
<ol class="gen-chain">

  <li class="gen-row">
    <button type="button" class="gen-node">
      <span class="gen-fig" data-initials="GL"><img src="/genealogy/leibniz.jpg" alt="Gottfried Leibniz"></span>
      <span class="gen-name">Gottfried Leibniz<span class="gen-meta">Dr. jur. Universität Altdorf, 1667</span></span>
    </button>
    <span class="gen-pop">
      <span class="gen-pop-head"><span class="gen-fig" data-initials="GL"><img src="/genealogy/leibniz.jpg" alt="Gottfried Leibniz"></span><span class="gen-name">Gottfried Leibniz<span class="gen-meta">Dr. jur. Universität Altdorf, 1667</span></span></span>
      <img class="gen-inset" src="/genealogy/weigel.jpg" alt="Erhard Weigel">
      <p>B. 1646, Leipzig. D. 1716, Hanover.</p>
      <p>German philosopher, mathematician and logician, best known for inventing calculus independently of Newton.</p>
      <p class="gen-caveat">His other advisors were Erhard Weigel at Jena (pictured, professor of mathematics there from 1653), Bartholomäus Schwendendörffer at Altdorf, and Christiaan Huygens in Paris.</p>
      <p><a href="https://en.wikipedia.org/wiki/Gottfried_Wilhelm_Leibniz">Wikipedia</a></p>
    </span>
  </li>

  <li class="gen-row">
    <button type="button" class="gen-node">
      <span class="gen-fig" data-initials="NM"><img src="/genealogy/malebranche.jpg" alt="Nicolas Malebranche"></span>
      <span class="gen-name">Nicolas Malebranche<span class="gen-meta">Oratoire de France, Paris</span></span>
    </button>
    <span class="gen-pop">
      <span class="gen-pop-head"><span class="gen-fig" data-initials="NM"><img src="/genealogy/malebranche.jpg" alt="Nicolas Malebranche"></span><span class="gen-name">Nicolas Malebranche<span class="gen-meta">Oratoire de France, Paris</span></span></span>
      <p>B. 1638, Paris. D. 1715, Paris.</p>
      <p>Oratorian priest and Cartesian philosopher, author of <em>De la recherche de la vérité</em> (1674). He came to mathematics late, after reading Descartes, and his Paris circle carried the new calculus into France.</p>
      <p class="gen-caveat">The MGP records his link to Leibniz to mark intellectual descent, not an actual supervision, so treat this edge as a courtesy.</p>
      <p><a href="https://en.wikipedia.org/wiki/Nicolas_Malebranche">Wikipedia</a></p>
    </span>
  </li>

  <li class="gen-row">
    <button type="button" class="gen-node">
      <span class="gen-fig" data-initials="JB"><img src="/genealogy/jabernoulli.jpg" alt="Jacob Bernoulli"></span>
      <span class="gen-name">Jacob Bernoulli<span class="gen-meta">Dr. hab. Universität Basel, 1684</span></span>
    </button>
    <span class="gen-pop">
      <span class="gen-pop-head"><span class="gen-fig" data-initials="JB"><img src="/genealogy/jabernoulli.jpg" alt="Jacob Bernoulli"></span><span class="gen-name">Jacob Bernoulli<span class="gen-meta">Dr. hab. Universität Basel, 1684</span></span></span>
      <p>B. 1654, Basel. D. 1705, Basel.</p>
      <p>One of the famous Bernoulli family. His contributions include the law of large numbers in probability theory and work on the convergence of infinite series.</p>
      <p><a href="https://en.wikipedia.org/wiki/Jacob_Bernoulli">Wikipedia</a></p>
    </span>
  </li>

  <li class="gen-row">
    <button type="button" class="gen-node">
      <span class="gen-fig" data-initials="JB"><img src="/genealogy/jobernoulli.jpg" alt="Johann Bernoulli"></span>
      <span class="gen-name">Johann Bernoulli<span class="gen-meta">Universität Basel, 1690, 1694</span></span>
    </button>
    <span class="gen-pop">
      <span class="gen-pop-head"><span class="gen-fig" data-initials="JB"><img src="/genealogy/jobernoulli.jpg" alt="Johann Bernoulli"></span><span class="gen-name">Johann Bernoulli<span class="gen-meta">Universität Basel, 1690, 1694</span></span></span>
      <p>B. 1667, Basel. D. 1748, Basel.</p>
      <p>Jacob's brother, elected a fellow of the academies of Paris, Berlin, London, St Petersburg and Bologna. Known as the "Archimedes of his age", he solved the catenary problem (alongside Leibniz and Huygens), and the rule for limits of functions commonly attributed to his student de l'Hôpital is his.</p>
      <p><a href="https://en.wikipedia.org/wiki/Johann_Bernoulli">Wikipedia</a></p>
    </span>
  </li>

  <li class="gen-row">
    <button type="button" class="gen-node">
      <span class="gen-fig" data-initials="LE"><img src="/genealogy/euler.jpg" alt="Leonhard Euler"></span>
      <span class="gen-name">Leonhard Euler<span class="gen-meta">Universität Basel, 1726</span></span>
    </button>
    <span class="gen-pop">
      <span class="gen-pop-head"><span class="gen-fig" data-initials="LE"><img src="/genealogy/euler.jpg" alt="Leonhard Euler"></span><span class="gen-name">Leonhard Euler<span class="gen-meta">Universität Basel, 1726</span></span></span>
      <p>B. 1707, Basel. D. 1783, St Petersburg.</p>
      <p>One of the most prolific mathematicians in history, with over 800 papers covering every branch of mathematics known in his day, an influential series of calculus textbooks, and books on a dozen other fields.</p>
      <p><a href="https://en.wikipedia.org/wiki/Leonhard_Euler">Wikipedia</a></p>
    </span>
  </li>

  <li class="gen-row">
    <button type="button" class="gen-node">
      <span class="gen-fig" data-initials="JL"><img src="/genealogy/lagrange.jpg" alt="Joseph Lagrange"></span>
      <span class="gen-name">Joseph Lagrange<span class="gen-meta">Università di Torino, 1754</span></span>
    </button>
    <span class="gen-pop">
      <span class="gen-pop-head"><span class="gen-fig" data-initials="JL"><img src="/genealogy/lagrange.jpg" alt="Joseph Lagrange"></span><span class="gen-name">Joseph Lagrange<span class="gen-meta">Università di Torino, 1754</span></span></span>
      <p>B. 1736, Turin. D. 1813, Paris.</p>
      <p>Developed the theory of differential equations and produced many new results in number theory. His earlier work on permutations of the roots of polynomial equations is now seen as a forerunner of group theory, and he is remembered in the Lagrange multiplier.</p>
      <p class="gen-caveat">Lagrange was never Euler's student in any formal sense. The MGP lists the relationship as "epistolary correspondence" on the calculus of variations.</p>
      <p><a href="https://en.wikipedia.org/wiki/Joseph-Louis_Lagrange">Wikipedia</a></p>
    </span>
  </li>

  <li class="gen-row">
    <button type="button" class="gen-node">
      <span class="gen-fig" data-initials="SP"><img src="/genealogy/poisson.jpg" alt="Siméon Poisson"></span>
      <span class="gen-name">Siméon Poisson<span class="gen-meta">École Polytechnique, 1800</span></span>
    </button>
    <span class="gen-pop">
      <span class="gen-pop-head"><span class="gen-fig" data-initials="SP"><img src="/genealogy/poisson.jpg" alt="Siméon Poisson"></span><span class="gen-name">Siméon Poisson<span class="gen-meta">École Polytechnique, 1800</span></span></span>
      <p>B. 1781, Pithiviers. D. 1840, Sceaux.</p>
      <p>"Life is only good for two things: to do mathematics and to teach it." Best known for his work on probability, including the Poisson distribution. Laplace was his second advisor.</p>
      <p><a href="https://en.wikipedia.org/wiki/Siméon_Denis_Poisson">Wikipedia</a></p>
    </span>
  </li>

  <li class="gen-row">
    <button type="button" class="gen-node">
      <span class="gen-fig" data-initials="MC"><img src="/genealogy/chasles.jpg" alt="Michel Chasles"></span>
      <span class="gen-name">Michel Chasles<span class="gen-meta">École Polytechnique, 1814</span></span>
    </button>
    <span class="gen-pop">
      <span class="gen-pop-head"><span class="gen-fig" data-initials="MC"><img src="/genealogy/chasles.jpg" alt="Michel Chasles"></span><span class="gen-name">Michel Chasles<span class="gen-meta">École Polytechnique, 1814</span></span></span>
      <p>B. 1793, Épernon. D. 1880, Paris.</p>
      <p>Worked on projective and enumerative geometry, and wrote a history of geometric method that shaped how the subject was taught. The Chasles relation for directed segments is his.</p>
      <p class="gen-caveat">Late in life he spent a fortune on thousands of forged letters purportedly from Pascal, Newton and Galileo, and defended their authenticity for years before the forger was tried and convicted.</p>
      <p><a href="https://en.wikipedia.org/wiki/Michel_Chasles">Wikipedia</a></p>
    </span>
  </li>

  <li class="gen-row">
    <button type="button" class="gen-node">
      <span class="gen-fig" data-initials="GD"><img src="/genealogy/darboux.jpg" alt="Gaston Darboux"></span>
      <span class="gen-name">Gaston Darboux<span class="gen-meta">Université de Paris, 1866</span></span>
    </button>
    <span class="gen-pop">
      <span class="gen-pop-head"><span class="gen-fig" data-initials="GD"><img src="/genealogy/darboux.jpg" alt="Gaston Darboux"></span><span class="gen-name">Gaston Darboux<span class="gen-meta">Université de Paris, 1866</span></span></span>
      <p>B. 1842, Nîmes. D. 1917, Paris.</p>
      <p>Geometer at the Sorbonne who reshaped the differential geometry of surfaces. Anyone who has taught introductory analysis knows him through Darboux sums and the Darboux integral.</p>
      <p><a href="https://en.wikipedia.org/wiki/Jean_Gaston_Darboux">Wikipedia</a></p>
    </span>
  </li>

  <li class="gen-row">
    <button type="button" class="gen-node">
      <span class="gen-fig" data-initials="ÉG"><img src="/genealogy/goursat.jpg" alt="Édouard Goursat"></span>
      <span class="gen-name">Édouard Goursat<span class="gen-meta">Université de Paris, 1881</span></span>
    </button>
    <span class="gen-pop">
      <span class="gen-pop-head"><span class="gen-fig" data-initials="ÉG"><img src="/genealogy/goursat.jpg" alt="Édouard Goursat"></span><span class="gen-name">Édouard Goursat<span class="gen-meta">Université de Paris, 1881</span></span></span>
      <p>B. 1858, Lanzac. D. 1936, Paris.</p>
      <p>Sharpened Cauchy's integral theorem by dropping the continuity assumption on the derivative, giving the Cauchy–Goursat theorem. His three-volume <em>Cours d'analyse mathématique</em> trained a generation of French analysts.</p>
      <p><a href="https://en.wikipedia.org/wiki/Édouard_Goursat">Wikipedia</a></p>
    </span>
  </li>

  <li class="gen-row">
    <button type="button" class="gen-node">
      <span class="gen-fig" data-initials="GD"><img src="/genealogy/darmois.png" alt="Georges Darmois"></span>
      <span class="gen-name">Georges Darmois<span class="gen-meta">Université de Paris, 1921</span></span>
    </button>
    <span class="gen-pop">
      <span class="gen-pop-head"><span class="gen-fig" data-initials="GD"><img src="/genealogy/darmois.png" alt="Georges Darmois"></span><span class="gen-name">Georges Darmois<span class="gen-meta">Université de Paris, 1921</span></span></span>
      <p>B. 1888, Éply. D. 1960, Paris.</p>
      <p>Started in differential geometry, then turned to statistics, joining the Institut de Statistique de l'Université de Paris (founded by Émile Borel) in 1925 and later becoming its second director. The first statistician in my line: the Darmois–Koopman–Pitman theorem characterises the exponential family, and the Darmois–Skitovich theorem characterises the normal distribution.</p>
      <p><a href="https://en.wikipedia.org/wiki/Georges_Darmois">Wikipedia</a></p>
    </span>
  </li>

  <li class="gen-row">
    <button type="button" class="gen-node">
      <span class="gen-fig" data-initials="DD"><img src="/genealogy/dugue.jpg" alt="Daniel Dugué"></span>
      <span class="gen-name">Daniel Dugué<span class="gen-meta">Université de Paris, 1937</span></span>
    </button>
    <span class="gen-pop">
      <span class="gen-pop-head"><span class="gen-fig" data-initials="DD"><img src="/genealogy/dugue.jpg" alt="Daniel Dugué"></span><span class="gen-name">Daniel Dugué<span class="gen-meta">Université de Paris, 1937</span></span></span>
      <p>B. 1912. D. 1987.</p>
      <p>French probabilist who worked on estimation theory and characteristic functions, and who succeeded Darmois in directing the Paris statistics institute.</p>
      <p><a href="https://en.wikipedia.org/wiki/Daniel_Dugué">Wikipedia</a></p>
    </span>
  </li>

  <li class="gen-row">
    <button type="button" class="gen-node">
      <span class="gen-fig" data-initials="PD"><img src="/genealogy/deheuvels.jpg" alt="Paul Deheuvels"></span>
      <span class="gen-name">Paul Deheuvels<span class="gen-meta">Université Paris VI, 1974</span></span>
    </button>
    <span class="gen-pop">
      <span class="gen-pop-head"><span class="gen-fig" data-initials="PD"><img src="/genealogy/deheuvels.jpg" alt="Paul Deheuvels"></span><span class="gen-name">Paul Deheuvels<span class="gen-meta">Université Paris VI, 1974</span></span></span>
      <p>B. 1948. D. 2026</p>
      <p>Works on empirical processes, extreme value theory and dependence. His 1979 paper on the empirical dependence function, building on related work by Rüschendorf a few years earlier, gave the empirical copula used in dependence modelling today its lasting form. Elected to the Académie des Sciences.</p>
      <p><a href="https://en.wikipedia.org/wiki/Paul_Deheuvels">Wikipedia</a></p>
    </span>
  </li>

  <li class="gen-row">
    <button type="button" class="gen-node">
      <span class="gen-fig" data-initials="AR"><img src="/genealogy/raftery.jpg" alt="Adrian Raftery"></span>
      <span class="gen-name">Adrian Raftery<span class="gen-meta">Université Paris VI, 1980</span></span>
    </button>
    <span class="gen-pop">
      <span class="gen-pop-head"><span class="gen-fig" data-initials="AR"><img src="/genealogy/raftery.jpg" alt="Adrian Raftery"></span><span class="gen-name">Adrian Raftery<span class="gen-meta">Université Paris VI, 1980</span></span></span>
      <p>B. 1955, Dublin.</p>
      <p>Bayesian model averaging, model-based clustering, and the probabilistic population projections the United Nations now uses. Professor of Statistics and Sociology at the University of Washington.</p>
      <p><a href="https://en.wikipedia.org/wiki/Adrian_Raftery">Wikipedia</a></p>
    </span>
  </li>

</ol>
</div>

<!-- ---------- right branch: through Peter Guttorp ---------- -->
<div class="gen-branch gen-branch--right">
<ol class="gen-chain">

  <li class="gen-row gen-row--spacer" aria-hidden="true"></li>

  <li class="gen-row">
    <button type="button" class="gen-node">
      <span class="gen-fig" data-initials="OM"><img src="/genealogy/mencke.jpg" alt="Otto Mencke"></span>
      <span class="gen-name">Otto Mencke<span class="gen-meta">Universität Leipzig, 1665</span></span>
    </button>
    <span class="gen-pop">
      <span class="gen-pop-head"><span class="gen-fig" data-initials="OM"><img src="/genealogy/mencke.jpg" alt="Otto Mencke"></span><span class="gen-name">Otto Mencke<span class="gen-meta">Universität Leipzig, 1665</span></span></span>
      <p>B. 1644, Oldenburg. D. 1707, Leipzig.</p>
      <p>Professor of moral philosophy at Leipzig, and founder in 1682 of <em>Acta Eruditorum</em>, the first learned journal in Germany. Leibniz published much of his calculus there.</p>
      <p><a href="https://en.wikipedia.org/wiki/Otto_Mencke">Wikipedia</a></p>
    </span>
  </li>

  <li class="gen-row">
    <button type="button" class="gen-node">
      <span class="gen-fig" data-initials="JW"><img src="/genealogy/wichmannshausen.jpg" alt="Johann Christoph Wichmannshausen"></span>
      <span class="gen-name">J. C. Wichmannshausen<span class="gen-meta">M.A. Universität Leipzig, 1685</span></span>
    </button>
    <span class="gen-pop">
      <span class="gen-pop-head"><span class="gen-fig" data-initials="JW"><img src="/genealogy/wichmannshausen.jpg" alt="Johann Christoph Wichmannshausen"></span><span class="gen-name">J. C. Wichmannshausen<span class="gen-meta">M.A. Universität Leipzig, 1685</span></span></span>
      <p>B. 1663, Ilsenburg. D. 1727, Wittenberg.</p>
      <p>Orientalist and professor at Wittenberg, and Mencke's son-in-law. His dissertation was on divorce under natural law, which makes him the least mathematical of my ancestors.</p>
      <p><a href="https://en.wikipedia.org/wiki/Johann_Christoph_Wichmannshausen">Wikipedia</a></p>
    </span>
  </li>

  <li class="gen-row">
    <button type="button" class="gen-node">
      <span class="gen-fig" data-initials="CH"><img src="/genealogy/hausen.jpg" alt="Christian August Hausen"></span>
      <span class="gen-name">Christian August Hausen<span class="gen-meta">Universität Halle-Wittenberg, 1713</span></span>
    </button>
    <span class="gen-pop">
      <span class="gen-pop-head"><span class="gen-fig" data-initials="CH"><img src="/genealogy/hausen.jpg" alt="Christian August Hausen"></span><span class="gen-name">Christian August Hausen<span class="gen-meta">Universität Halle-Wittenberg, 1713</span></span></span>
      <p>B. 1693, Dresden. D. 1743, Leipzig.</p>
      <p>Professor of mathematics at Leipzig. He built one of the early electrostatic friction machines and studied the sparks it produced.</p>
      <p><a href="https://en.wikipedia.org/wiki/Christian_August_Hausen">Wikipedia</a></p>
    </span>
  </li>

  <li class="gen-row">
    <button type="button" class="gen-node">
      <span class="gen-fig" data-initials="AK"><img src="/genealogy/kastner.jpg" alt="Abraham Gotthelf Kästner"></span>
      <span class="gen-name">A. G. Kästner<span class="gen-meta">Universität Leipzig, 1739</span></span>
    </button>
    <span class="gen-pop">
      <span class="gen-pop-head"><span class="gen-fig" data-initials="AK"><img src="/genealogy/kastner.jpg" alt="Abraham Gotthelf Kästner"></span><span class="gen-name">A. G. Kästner<span class="gen-meta">Universität Leipzig, 1739</span></span></span>
      <p>B. 1719, Leipzig. D. 1800, Göttingen.</p>
      <p>Professor at Göttingen, prolific textbook writer, historian of mathematics, and a well-known writer of epigrams. Gauss studied at Göttingen during Kästner's time there, though he reportedly found Kästner's lectures too elementary to attend.</p>
      <p><a href="https://en.wikipedia.org/wiki/Abraham_Gotthelf_Kästner">Wikipedia</a></p>
    </span>
  </li>

  <li class="gen-row">
    <button type="button" class="gen-node">
      <span class="gen-fig" data-initials="JM"><img src="/genealogy/mayer.jpg" alt="Johann Tobias Mayer"></span>
      <span class="gen-name">Johann Tobias Mayer<span class="gen-meta">Universität Göttingen, 1773</span></span>
    </button>
    <span class="gen-pop">
      <span class="gen-pop-head"><span class="gen-fig" data-initials="JM"><img src="/genealogy/mayer.jpg" alt="Johann Tobias Mayer"></span><span class="gen-name">Johann Tobias Mayer<span class="gen-meta">Universität Göttingen, 1773</span></span></span>
      <p>B. 1752, Göttingen. D. 1830, Göttingen.</p>
      <p>Physicist and mathematician at Göttingen, and son of the astronomer Tobias Mayer. He wrote on geometry and on the design of angle-measuring instruments.</p>
      <p><a href="https://en.wikipedia.org/wiki/Johann_Tobias_Mayer">Wikipedia</a></p>
    </span>
  </li>

  <li class="gen-row">
    <button type="button" class="gen-node">
      <span class="gen-fig" data-initials="ED"><img src="/genealogy/dirksen.jpg" alt="Enno Heeren Dirksen"></span>
      <span class="gen-name">Enno Heeren Dirksen<span class="gen-meta">Universität Göttingen, 1820</span></span>
    </button>
    <span class="gen-pop">
      <span class="gen-pop-head"><span class="gen-fig" data-initials="ED"><img src="/genealogy/dirksen.jpg" alt="Enno Heeren Dirksen"></span><span class="gen-name">Enno Heeren Dirksen<span class="gen-meta">Universität Göttingen, 1820</span></span></span>
      <p>B. 1788, Eilsum. D. 1850, Paris.</p>
      <p>Professor in Berlin, where his students included Jacobi, Göpel and Heine. His own work was on the calculus of variations and transcendental analysis.</p>
      <p><a href="https://en.wikipedia.org/wiki/Enno_Dirksen">Wikipedia</a></p>
    </span>
  </li>

  <li class="gen-row">
    <button type="button" class="gen-node">
      <span class="gen-fig" data-initials="CJ"><img src="/genealogy/jacobi.jpg" alt="Carl Gustav Jacob Jacobi"></span>
      <span class="gen-name">Carl Gustav Jacob Jacobi<span class="gen-meta">Universität Berlin, 1825</span></span>
    </button>
    <span class="gen-pop">
      <span class="gen-pop-head"><span class="gen-fig" data-initials="CJ"><img src="/genealogy/jacobi.jpg" alt="Carl Gustav Jacob Jacobi"></span><span class="gen-name">Carl Gustav Jacob Jacobi<span class="gen-meta">Universität Berlin, 1825</span></span></span>
      <p>B. 1804, Potsdam. D. 1851, Berlin.</p>
      <p>Founded the theory of elliptic functions alongside Abel, and gave us the Jacobian determinant and the Hamilton–Jacobi equation. His advice to students was to invert.</p>
      <p><a href="https://en.wikipedia.org/wiki/Carl_Gustav_Jacob_Jacobi">Wikipedia</a></p>
    </span>
  </li>

  <li class="gen-row">
    <button type="button" class="gen-node">
      <span class="gen-fig" data-initials="WS"><img src="/genealogy/scheibner.jpg" alt="Wilhelm Scheibner"></span>
      <span class="gen-name">Wilhelm Scheibner<span class="gen-meta">Universität Halle-Wittenberg, 1848</span></span>
    </button>
    <span class="gen-pop">
      <span class="gen-pop-head"><span class="gen-fig" data-initials="WS"><img src="/genealogy/scheibner.jpg" alt="Wilhelm Scheibner"></span><span class="gen-name">Wilhelm Scheibner<span class="gen-meta">Universität Halle-Wittenberg, 1848</span></span></span>
      <p>B. 1826, Ölsnitz. D. 1908, Leipzig.</p>
      <p>Professor at Leipzig, working on analysis and number theory.</p>
      <p class="gen-caveat">Story's other Leipzig advisor was Carl Neumann, who also studied under Jacobi (through Hesse and Richelot), so both routes rejoin here.</p>
    </span>
  </li>

  <li class="gen-row">
    <button type="button" class="gen-node">
      <span class="gen-fig" data-initials="WS"><img src="/genealogy/Story.jpg" alt="William Story"></span>
      <span class="gen-name">William Story<span class="gen-meta">Universität Leipzig, 1875</span></span>
    </button>
    <span class="gen-pop">
      <span class="gen-pop-head"><span class="gen-fig" data-initials="WS"><img src="/genealogy/Story.jpg" alt="William Story"></span><span class="gen-name">William Story<span class="gen-meta">Universität Leipzig, 1875</span></span></span>
      <p>B. 1850, Boston. D. 1930, Worcester.</p>
      <p>Worked on algebraic problems and was an important player in the development of American mathematics. He helped found the <em>American Journal of Mathematics</em>.</p>
      <p><a href="https://en.wikipedia.org/wiki/William_Edward_Story">Wikipedia</a></p>
    </span>
  </li>

  <li class="gen-row">
    <button type="button" class="gen-node">
      <span class="gen-fig" data-initials="SL"><img src="/genealogy/lefschetz.jpg" alt="Solomon Lefschetz"></span>
      <span class="gen-name">Solomon Lefschetz<span class="gen-meta">Clark University, 1911</span></span>
    </button>
    <span class="gen-pop">
      <span class="gen-pop-head"><span class="gen-fig" data-initials="SL"><img src="/genealogy/lefschetz.jpg" alt="Solomon Lefschetz"></span><span class="gen-name">Solomon Lefschetz<span class="gen-meta">Clark University, 1911</span></span></span>
      <p>B. 1884, Moscow. D. 1972, Princeton.</p>
      <p>Russian-born mathematician who became the main source of the algebraic aspects of topology.</p>
      <p><a href="https://en.wikipedia.org/wiki/Solomon_Lefschetz">Wikipedia</a></p>
    </span>
  </li>

  <li class="gen-row">
    <button type="button" class="gen-node">
      <span class="gen-fig" data-initials="JT"><img src="/genealogy/tukey.jpg" alt="John Tukey"></span>
      <span class="gen-name">John Tukey<span class="gen-meta">Princeton University, 1939</span></span>
    </button>
    <span class="gen-pop">
      <span class="gen-pop-head"><span class="gen-fig" data-initials="JT"><img src="/genealogy/tukey.jpg" alt="John Tukey"></span><span class="gen-name">John Tukey<span class="gen-meta">Princeton University, 1939</span></span></span>
      <p>B. 1915, New Bedford. D. 2000, New Brunswick.</p>
      <p>The most innovative statistician of the 20th century. He invented the box plot and the stem-and-leaf plot, co-invented the fast Fourier transform, and contributed heavily to jackknife estimation and spectral density estimation. He is also credited with the words "software" and "bit".</p>
      <p><a href="https://en.wikipedia.org/wiki/John_Tukey">Wikipedia</a></p>
    </span>
  </li>

  <li class="gen-row">
    <button type="button" class="gen-node">
      <span class="gen-fig" data-initials="DB"><img src="/genealogy/brillinger.jpg" alt="David Brillinger"></span>
      <span class="gen-name">David Brillinger<span class="gen-meta">Princeton University, 1961</span></span>
    </button>
    <span class="gen-pop">
      <span class="gen-pop-head"><span class="gen-fig" data-initials="DB"><img src="/genealogy/brillinger.jpg" alt="David Brillinger"></span><span class="gen-name">David Brillinger<span class="gen-meta">Princeton University, 1961</span></span></span>
      <p>B. 1937, Toronto.</p>
      <p>Prolific researcher with over 200 papers, best known for his work on stochastic processes and time series, especially spectral analysis and earthquakes. His 1975 book <em>Time Series: Data Analysis and Theory</em> has been particularly influential. At the University of California, Berkeley.</p>
      <p><a href="https://en.wikipedia.org/wiki/David_R._Brillinger">Wikipedia</a></p>
    </span>
  </li>

  <li class="gen-row">
    <button type="button" class="gen-node">
      <span class="gen-fig" data-initials="PG"><img src="/genealogy/guttorp.jpg" alt="Peter Guttorp"></span>
      <span class="gen-name">Peter Guttorp<span class="gen-meta">University of California, Berkeley, 1980</span></span>
    </button>
    <span class="gen-pop">
      <span class="gen-pop-head"><span class="gen-fig" data-initials="PG"><img src="/genealogy/guttorp.jpg" alt="Peter Guttorp"></span><span class="gen-name">Peter Guttorp<span class="gen-meta">University of California, Berkeley, 1980</span></span></span>
      <p>B. 1949.</p>
      <p>Uses stochastic models in hydrology, atmospheric science, geophysics, environmental science and haematology. At the University of Washington.</p>
      <p><a href="https://en.wikipedia.org/wiki/Peter_Guttorp">Wikipedia</a></p>
    </span>
  </li>

</ol>
</div>

</div><!-- /.gen-branches -->

<div class="gen-join gen-join--merge"><span></span><span></span></div>

<!-- ============ back to one line ============ -->
<ol class="gen-chain">
  <li class="gen-row">
    <button type="button" class="gen-node">
      <span class="gen-fig" data-initials="GG"><img src="/img/GaryGrunwald.jpg" alt="Gary Grunwald"></span>
      <span class="gen-name">Gary Grunwald<span class="gen-meta">University of Washington, 1987</span></span>
    </button>
    <span class="gen-pop">
      <span class="gen-pop-head"><span class="gen-fig" data-initials="GG"><img src="/img/GaryGrunwald.jpg" alt="Gary Grunwald"></span><span class="gen-name">Gary Grunwald<span class="gen-meta">University of Washington, 1987</span></span></span>
      <p>B. 1954.</p>
      <p>Gary spent the first part of his career on time series analysis, particularly non-Gaussian time series. Then he worked at the University of Colorado on nutrition, physiology, and cardiovascular health. Guttorp and Raftery jointly supervised his thesis, which is why the tree above has two branches. <a href="https://coloradosph.cuanschutz.edu/resources/directory/directory-profile/Grunwald-Gary-UCD13990">Website</a></p>
    </span>
  </li>
  <li class="gen-row">
    <button type="button" class="gen-node">
      <span class="gen-fig" data-initials="RH"><img src="/img/population.jpg" alt="Rob J Hyndman"></span>
      <span class="gen-name">Rob J Hyndman<span class="gen-meta">University of Melbourne, 1993</span></span>
    </button>
    <span class="gen-pop">
      <span class="gen-pop-head"><span class="gen-fig" data-initials="RH"><img src="/img/population.jpg" alt="Rob J Hyndman"></span><span class="gen-name">Rob J Hyndman<span class="gen-meta">University of Melbourne, 1993</span></span></span>
      <p>B. 1967, Melbourne.</p>
      <p>Peter Brockwell was also my advisor, and he was supervised by Joe Moyal, but then the line stops --- the MGP does not record who Moyal's advisor was.</p>
      <p><a href="https://en.wikipedia.org/wiki/Rob_J._Hyndman">Wikipedia</a></p>
    </span>
  </li>
</ol>


</div>

<script>
document.querySelectorAll('.gen .gen-fig img').forEach(function (img) {
  img.addEventListener('error', function () { img.remove(); });
});
</script>
```
