---
date: 2010-08-06 06:34:14+00:00
link: https://robjhyndman.com/hyndsight/graphics/
slug: graphics
title: Twenty rules for good graphics
categories:
- graphics
- journals
- R
---

One of the things I repeatedly include in referee reports, and in my responses to authors who have submitted papers to the _International Journal of Forecasting_, are comments designed to include the quality of the graphics. Recently someone asked on [stats.stackexchange.com](http://stats.stackexchange.com) about [best practices for producing plots](http://stats.stackexchange.com/questions/396/). So I thought it might be helpful to collate some of the answers given there and add a few comments of my own taken from things I've written for authors.

The following "rules" are in no particular order.


  1. Use vector graphics such as eps or pdf. These scale properly and do not look fuzzy when enlarged. Do not use jpeg, bmp or png files as these will look fuzzy when enlarged, or if saved at very high resolutions will be enormous files. Jpegs in particular are designed for photographs not statistical graphics.

  2. Use readable fonts. For graphics I prefer sans-serif fonts such as Helvetica or Arial. Make sure the font size is readable after the figure is scaled to whatever size it will be printed.

  3. Avoid cluttered legends. Where possible, add labels directly to the elements of the plot rather than use a legend at all. If this won't work, then keep the legend from obscuring the plotted data, and make it small and neat.

  4. If you must use a legend, move it inside the plot, in a blank area.

  5. No dark shaded backgrounds. Excel always adds a nasty dark gray background by default, and I'm always asking authors to remove it. Graphics print much better with a white background. The ggplot for R also uses a gray background (although it is lighter than the Excel default). I don't mind the ggplot version so much as it is used effectively with white grid lines. Nevertheless, even the light gray background doesn't lend itself to printing/photocopying. White is better.

  6. Avoid dark, dominating grid lines (such as those produced in Excel by default). Grid lines can be useful, but they should be in the background (light gray on white or white on light gray).

  7. Keep the axis limits sensible. You don't have to include a zero (even if Excel wants you to). The defaults in R work well. The basic idea is to avoid lots of white space around the plotted data.

  8. Make sure the axes are scaled properly. Another Excel problem is that the horizontal axis is sometimes treated categorically instead of numerically. If you are plotting a continuous numerical variable, then the horizontal axis should be properly scaled for the numerical variable.

  9. Do not forget to specify units.

  10. Tick intervals should be at nice round numbers.

  11. Axes should be properly labelled.

  12. Use linewidths big enough to read. 1pt lines tend to disappear if plots are shrunk.

  13. Avoid overlapping text on plotting characters or lines.

  14. Follow Tufte's principles by removing chart junk and keeping a high data-ink ratio.

  15. Plots should be self-explanatory, so include detailed captions.

  16. Use a sensible aspect ratio. I think width:height of about 1.6 works well for most plots.

  17. Prepare graphics in the final aspect ratio to be used in the publication. Distorted fonts look awful.

  18. Use points not lines if element order is not relevant.

  19. When preparing plots that are meant to be compared, use the same scale for all of them. Even better, combine plots into a single graph if they are related.

  20. Avoid pie-charts. Especially 3d pie-charts. Especially 3d pie-charts with exploding wedges. I promise all my students an instant fail if I ever see anything so appalling.

The classic books on graphics are:

  * [Tufte's "The Visual Display of Quantitative Information" (2nd ed, 2001).](http://buy.geni.us/Proxy.ashx?TSID=140570\&GR_URL=http%3A%2F%2Fwww.amazon.com%2Fdp%2F0961392142)

  * [Cleveland's "The Elements of Graphing Data" (2nd ed, 1994).](http://buy.geni.us/Proxy.ashx?TSID=140570\&GR_URL=http%3A%2F%2Fwww.amazon.com%2Fdp%2F0963488414)

These are both highly recommended.
