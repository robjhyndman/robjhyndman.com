---
date: 2010-10-23 13:30:01+00:00
link: https://robjhyndman.com/hyndsight/xelatex/
slug: xelatex
title: Getting started with XeLaTeX
categories:
- LaTeX
---

By now, most LaTeX users have probably heard of [XeLaTeX](http://en.wikipedia.org/wiki/XeTeX), if only because it is an option in the latest versions of the standard LaTeX editors such as [TeXnicCenter](http://texniccenter.org), [WinEdt](http://www.winedt.com) and [TeXWorks](http://www.tug.org/texworks/). But most LaTeXers have probably not yet become XeLaTeXers. Why should you?

XeLaTeX is essentially a replacement for pdfLaTeX. It was primarily developed to enable better font handling, especially non-Roman scripts. If you want to write in Telugu, then XeLaTeX is going to make your life much easier. For English writers, the main benefit of XeLaTeX is the ability to use the fonts on your computer, just as you can with other software. If you've grown to love using Georgia in MS-Word and always wanted to write a LaTeX document in Georgia, now you can.

Here is a very simple example:

    \documentclass{article}
    \usepackage{fontspec,lipsum}
    \defaultfontfeatures{Ligatures=TeX}
    \usepackage[small,sf,bf]{titlesec}

    \setromanfont{Georgia}
    \setsansfont{Tahoma}

    \begin{document}
    \section{Introduction}

    \lipsum[1]

    \section{Nonsense}

    \lipsum[2-4]
    \end{document}

Note the following features:


  * The `fontspec` package is almost always necessary with XeLaTeX and contains commands to load the required fonts.

  * You usually need the command `\defaultfontfeatures{Ligatures=TeX}`. This is so the new fonts behave in the way we've come to expect with LaTeX, such as allowing an em-dash to be written as `---`.

  * The two fonts that are loaded (Georgia and Tahoma in this example) are fonts available in my Windows fonts directory.

  * The titlesec package is loaded only so headings are in sans-serif bold in order to show the effect of the font changes.

  * The lipsum package provides some nonsense text for testing purposes.

A disadvantage of using XeLaTeX is that most of the fonts on your computer will not come with enough fancy characters (known as glyphs) for mathematics. So maths has to be set using  a standard LaTeX font. Consequently, I am not using XeLaTeX for my mathematical documents, but I have started trying it out on non-mathematical documents.

My first serious XeLaTeX document is [my latest CV](https://github.com/robjhyndman/CV/raw/master/RobHyndmanCV.pdf) where I've used the following font commands:

    \setromanfont{Minion Pro}
    \setsansfont[Colour=AA0000]{Myriad Pro}

For a lot more information, read the [fontspec manual](http://mirrors.ctan.org/macros/unicodetex/latex/fontspec/fontspec.pdf).
