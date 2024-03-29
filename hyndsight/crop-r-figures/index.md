---
date: 2013-02-22 00:22:46+00:00
link: https://robjhyndman.com/hyndsight/crop-r-figures/
slug: crop-r-figures
title: Removing white space around R figures
categories:
- beamer
- computing
- graphics
- LaTeX
- R
- seminars
---

When I want to insert figures generated in R into a LaTeX document, it looks better if I first remove the white space around the figure. Unfortunately, R does not make this easy as the graphs are generated to look good on a screen, not in a document.

There are two things that can be done to fix this problem.<!-- more -->

First, you can reduce the white space generated by R. I use the following function when saving figures in R.


    savepdf <- function(file, width=16, height=10)
    {
      fname <- paste("figures/",file,".pdf",sep="")
      pdf(fname, width=width/2.54, height=height/2.54,
          pointsize=10)
      par(mgp=c(2.2,0.45,0), tcl=-0.4, mar=c(3.3,3.6,1.1,1.1))
    }

The `width` and `height` are in centimetres. The ratio is about right for a beamer presentation, and also to fit two figures on an A4 page.

Then I use the commands


    savepdf("filename")
    # Plotting commands here
    dev.off()

That will generate a pdf figure of about the right size and shape for a document, and with narrow margins of white space, and save it in my figures sub-directory.

The second trick is to trim the pdf files so there is no white space left. On a unix system, this is easily achieved as follows.


    pdfcrop filename.pdf filename.pdf

There are probably windows and mac versions of the same, but I haven't used them. Adobe Acrobat will also crop pdfs, but not from the command line as far as I know.

To apply `pdfcrop` to every file in a directory (using unix), save the following to a file called `cropall.sh`:


    #!/bin/bash

    for FILE in ./*.pdf; do
      pdfcrop "${FILE}" "${FILE}"
    done

Make the file executable and run it.

In my [post on Makefiles](https://robjhyndman.com/hyndsight/makefiles/), I explain how to include `pdfcrop` within a Makefile.

If you just use `pdfcrop` without first reducing the white space in R, the proportions come out a little odd. So I tend to use both approaches together.
