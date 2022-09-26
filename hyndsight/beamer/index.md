---
date: 2012-08-01 06:17:27+00:00
link: https://robjhyndman.com/hyndsight/beamer/
slug: beamer
title: Bare bones beamer
categories:
- beamer
- LaTeX
- seminars
---

Beamer is far and away the most popular software for presentations amongst researchers in mathematics and statistics. Most conference and seminar talks I attend these days use beamer. Unfortunately, they all look much the same. I think people find beamer themes too hard to modify easily, so a small number of templates get shared around. Even the otherwise wonderful [LaTeX Templates](http://www.latextemplates.com/) site has no beamer examples.

[The beamer user guide](http://mirrors.ctan.org/macros/latex/contrib/beamer/doc/beameruserguide.pdf) explains how to make changes but it is not for the faint-hearted (although it is a fantastic resource once you have some expertise).

So I thought it might be useful to produce a very simple beamer template that is easy to extend and modify.<!-- more -->

This template also includes two example slides showing some of the most common things you might want to do.



    \documentclass[14pt,xcolor=dvipsnames]{beamer}

    % Specify theme
    \usetheme{Madrid}
    % See http://goo.gl/Wxlyy for alternative themes

    % Specify base color
    \usecolortheme[named=OliveGreen]{structure}
    % See http://goo.gl/p0Phn for alternative colors

    % Specify other colors and options as required
    \setbeamercolor{alerted text}{fg=Maroon}
    \setbeamertemplate{items}[square]

    % Title and author information
    \title{Title goes here}
    \author{Name goes here}

    \begin{document}

    \begin{frame}
    \titlepage
    \end{frame}

    \begin{frame}{Outline}
    \tableofcontents
    \end{frame}

    \section{Introduction}

    \begin{frame}{Forecasting functional data}
    \begin{itemize}[<+-| alert@+>]
    \item Observed values are discrete but underlying structures are
    continuous functions.
    \item Observed values may be noisy but underlying functions are
    smooth.
    \item \textbf{Problem:} To forecast the \textbf{whole function} for
    future time periods.
    \end{itemize}
    \end{frame}

    \begin{frame}{Forecasting functional data}
    \structure{Some notation}

    Let $y_t(x_i)$ be the observed data in period $t$ at location $x_i$,
    $i=1,\dots,p$, $t=1,\dots,n$.
    \pause

    \begin{block}{}
    \[
    y_t(x_i) = f_t(x_i) + \sigma_t(x_i)\varepsilon_{t,i}
    \]
    where $\varepsilon_{t,i}$ is iid N(0,1) and $\sigma_t(x_i)$ allows the
    amount of noise to vary with $x$.
    \end{block}
    \pause

    \begin{enumerate}[<+-| alert@+>]
    \item We assume $f_t(x)$ is a smooth function of $x$.
    \item We need to estimate $f_t(x)$ from the data for $x_1 < x < x_p$.
    \end{enumerate}
    \end{frame}

    \end{document}



**[Download file](https://robjhyndman.com/research/talktemplate.tex)**
