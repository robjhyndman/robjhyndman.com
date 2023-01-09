---
date: 2012-01-18 23:30:12+00:00
slug: surveys
title: Internet surveys
categories:
- R
- statistics
- technology
---

I received the following email today:

>I am preparing a thesis ... I need to conduct the widest possible poll, and it occurred to me that perhaps you could guide me toward an internet-based way in which this can be done easily. I have a ten-question questionnaire prepared, that I wish to have an random sample of the population respond to. I have no budget for this, so I hope you can suggest a way in which a good number of responses can be harvested using blogs or sites you may be aware of.

Here is my response.<!-- more -->

There are two issues here. The first is to find a convenient web-based data-collection tool. One popular approach is to use a **survey form on [Google Docs](http://docs.google.com)**. The results are automatically saved to a Google spreadsheet. There are many online explanations of how to set up your survey form including [this from Google help](http://support.google.com/docs/bin/answer.py?hl=en&answer=87809) or [this from digital inspirations](http://www.labnol.org/software/google-docs-forms-for-surveys/10056/). A more sophisticated tool for more complex surveys is **[SurveyMonkey](http://www.surveymonkey.com)**. This allows skipping questions based on previous responses, response validation, and other useful features. For researchers collecting data, I generally recommend that they use [SurveyMonkey](http://www.surveymonkey.com). But for a quick poll of a small group, Google Docs is adequate. Using either tool, the responses can be downloaded and imported into R or some other statistical analysis package. Web-based data collection avoids all the problems associated with entering and encoding data, although one drawback is the tech barrier for some audiences. You won't be able to use web-based data collection for a survey of the elderly, or of remote Amazonian tribes, or of many other populations where not everyone uses the internet. But if it is reasonable to assume that all members of the population use the internet, then web-based collection is much better than paper-based forms.

The second issue is more difficult. That is, how to get a random sample of the population. Here, there are no magic tech solutions. Advertising on blogs or other sites will simply give you a biased sample favouring those who read the blogs and have the time and interest to respond. Then you have to make the courageous assumption that the responders are representative of the population of interest. It is better to identify the population of interest first, and find some way of randomly sampling it where each member of the population has equal probability of being selected in the sample. How this can be done depends on the particular population being studied. I suggest you discuss a sampling strategy with the statisticians at your university. There are also some good online references including ["Best practices"](https://www.aapor.org/Standards-Ethics/Best-Practices.aspx) from the AAPOR, and ["What is a survey?"](https://web.archive.org/web/20181204214013/https://whatisasurvey.info/) by Fritz Scheuren. A useful textbook is _[Sampling: Design and Analysis](http://buy.geni.us/Proxy.ashx?TSID=140570\&GR_URL=http%3A%2F%2Fwww.amazon.com%2Fdp%2F0495105279)_ by Sharon Lohr (Duxbury Press, 2009, 2nd ed.).
