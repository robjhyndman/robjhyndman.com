---
title: "The future of scholarly books"
date: 2026-10-29
image: /img/fpp3_cover.jpg
categories:
  - otexts
  - fpp
  - writing
  - teaching
  - AI
description: On Monday, I took part in a Springer Nature roundtable on "The Future of Scholarly Books", held in Melbourne.
---

Around the table were publishers, librarians and authors.
We had a wide-ranging discussion about how scholarly books are valued, used, funded and trusted.

I was invited both as an author of [scholarly books](https://robjhyndman.com/publications/#category=Books) and as a publisher of them through [OTexts](https://OTexts.com).
I described how OTexts started, how it is run, and what I think the future might look like.
This post summarises what I said.

## The beginning of OTexts

My first textbook was [*Forecasting: methods and applications*](/forecasting/), written with Spyros Makridakis and Steve Wheelwright and published by Wiley in 1998.
Not long after it appeared, I used it for teaching and found that my students weren't buying it because it was too expensive.
One student even asked me to sign a pirated copy they had bought at a market in Bangladesh!
Most of the others were searching online for material to replace the textbook, and much of what they found was riddled with errors.

So I decided that my next book would be free online, with a print edition for those who wanted one.
Unfortunately, no publisher at the time would consider printing a book that was also freely available online.
Consequently, I started my own publishing business instead, and [OTexts](https://OTexts.com) was born around 2012.

The first OTexts book was a new forecasting textbook, coauthored with George Athanasopoulos.
It was originally hosted on WordPress, then Drupal, then bookdown, and now [Quarto](https://quarto.org).
([Here](https://web.archive.org/web/20120419134321/http://otexts.com/fpp/) is an early draft on WordPress.)
Each change of platform made the book easier to maintain, and made it easier to produce the online and print versions from the same source.
(The first edition was produced before bookdown or Quarto existed, and the separate source files for the web and print editions needed to be manually kept in sync.)

I originally planned to host books by other authors too.
But bookdown and Quarto made it easy for authors to publish their own books online, and some mainstream academic publishers now allow open-access online editions.
So I decided to restrict OTexts to my own books.

## Forecasting: principles and practice

The [forecasting book](https://OTexts.com/fpp3) is now available in R and Python versions.
The R version has been translated from English into eight other languages, with six more translations in progress.
All translations are done by expert human translators, with additional language experts reviewing them.

Across all OTexts books there are over 15,000 pageviews per day, from almost every country on earth.
That is too much traffic for a free host such as GitHub Pages, so I use a paid service.
Print sales, plus some [GitHub sponsorship](https://github.com/sponsors/robjhyndman/), help fund it.

Almost all the code is visible to the reader.
It can be copied and pasted to replicate the examples, and modified for further analysis.

The book is a living document.
When a reader reports an error, or a software change breaks the embedded code, the correction is usually online within a day or two, and synced across all translations.

On Monday, I argued that Springer and other publishers could use a similar model, with print sales funding open-access online versions of their books.
The idea wasn't met with enthusiasm!

## The future of online scholarly books

The standard format of a static print book seems anachronistic, especially for textbooks, where interactivity and other dynamic elements greatly enhance learning.
At present, the forecasting book has only a couple of interactive figures (both using webR), but we plan to add many more in the coming months.

Students are also increasingly learning with AI tutors.
At some stage we will probably build an AI chat interface into the book, so that students can learn from an agent trained specifically on its content.

The forecasting book isn't the only one.
I have nearly finished another OTexts book, on [anomaly detection](https://OTexts.com/weird/), which uses the same [Quarto template](https://github.com/OTexts/quarto-otexts).

## Libraries

Academic publishers now take a large proportion of university library budgets through journal bundles, leaving much less for books than in the past.
Collective schemes such as [Knowledge Unlatched](https://knowledgeunlatched.org) and [Opening the Future](https://www.openingthefuture.net) are trying to help.

I would like to see libraries move from gatekeeper to curator and preserver.
That means looking after discoverability, metadata and long-term archiving of open books, not just linking to a publisher's website.
Few libraries link to OTexts, despite the popularity of the forecasting book, because it isn't regarded as a mainstream publisher.
The question is whether libraries will index and promote open titles alongside the ones they pay for.

## Open access

I founded OTexts because I wanted high-quality textbooks that were free online, with revenue coming from optional print and ebook sales.
It has been sustainable for nearly 15 years.
To be fair, our costs have stayed low because I do this in my spare time, and the translators and others who have helped have also volunteered their time.

I strongly oppose charging authors for open access.
It just moves the burden from readers to authors, and hurts those without the means to pay.
I would rather see open-access online books funded through print sales and institutional or consortium funding.
The costs are lower than ever: online hosting is relatively cheap, and print-on-demand has eliminated warehousing.

## Trust

There is a pervasive attitude that if something is freely available, it can't be good.
Self-serving commercial publishers sometimes reinforce this view.
Self-published books also attract some (understandable) suspicion: if the book is any good, why isn't it published by a recognised academic publisher?

As I hope is clear from this post, I would gladly have published the forecasting book with a regular academic publisher, but 15 years ago none was willing to adopt an innovative publishing model.
The book is now so widely used that I don't need a recognised publisher's help.
I probably will partner with a regular academic publisher for the print edition of my [anomaly detection book](https://OTexts.com/weird).

The online open-access model also has advantages that should help build reader trust:

1. **Openness.** Books can be developed in public on GitHub, with visible errata, version history, and reproducible code and data for every example.
   See [the GitHub repo for the Python edition](https://github.com/OTexts/fpppy/), for example.

2. **Real peer review and community feedback.** Reader issues and forum discussions over the life of a book catch much more than a single review before publication.
   The [OTexts discussion forum](https://github.com/orgs/OTexts/discussions) lets readers ask questions, report typos, and discuss topics beyond what the books explicitly cover.

Both also show that there are real human authors behind the book, which guards against paper-mill-style AI-generated books.
