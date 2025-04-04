# Choosing between Quarto and R Markdown

Quarto and R Markdown are very similar. If you're already comfortable using R Markdown, there might be less reason for you to make the switch to Quarto. But if you're still getting the hang of either, it's probably wiser to build muscle memory with Quarto. Between the two, there's a lot of overlap in format, use, and compatibility, so skills used in one will largely map to skills that are useful in the other. Below are some arguments for choosing Quarto over R Markdown, prepared only based on the *untrue* premise that only one tool can be used.

## Quarto is the future

As an open source project, Quarto is actively maintained by Posit, with continual improvements and [a roadmap](https://github.com/quarto-dev/quarto-cli/milestones) for future releases. Meanwhile, the rmarkdown package is also maintained by Posit, but its development is far less active, with [a roadmap](https://github.com/rstudio/rmarkdown/milestones) suggesting less attention. The R Markdown format is more than the package---and the format *isn't* going away---but it's also expected to remain comparatively stagnant.

## Quarto does more

The modular format of R Markdown means that it relies on R packages to extend its functionality to support different formats. On the contrary, Quarto bundles these up and actively maintains and includes them. And because Quarto supports multiple formats natively, it means that all of them gain support for Quarto features like figure cross references---which in R Markdown are only available in certain output formats made available by another package. Likewise, Quarto has support for `{{< include file.qmd >}}` to drop in other files, making it easier to include commonly repeated contents. And it has support for `_quarto.yml` to set project-wide defaults. And it has support for `_variables.yml` for storing variables centrally. And it has support for `_brand.yml` for setting consistent color defaults. And it has... *you get the drift.*

## Quarto has better syntax

Speaking of figure cross references, Quarto's feature set is generally easier to use. In R Markdown with the bookdown package, we need to say something like `\@ref(fig:dog)` using LaTeX syntax to reference a figure made by the code chunk labelled `dog`. But in Quarto, the same figure is referenced natively with just `@fig-dog`. Similarly, both R Markdown and Quarto allow you to create a footnote with a carrot, like this: `^[This is a footnote.]`. But only(?) Quarto will also support naming footnote to define them outside of the particular context,`^[fn2]` thereby freeing up the flow of your writing.`^[additional]` 

`^[fn2]: After all, it can be annoying to write a sentence in the middle of another sentence.`

`^[additional]: The "only(?)" is used here because it's hard to find a straight answer online. Instead, there are many pages sharing simple "fixes" to get this kind of syntax working in certain kinds of R Markdown output. It seems like it maybe might work some of the time, but only with bandaids added. Meanwhile, Quarto supports it fully.`

## Quarto is language agnostic

Both formats can work with multiple coding languages, but R Markdown documents will always be rendered using R. If you're already typically an R user, this won't make any difference for you, but it means that anyone whose primary language is Python will need to install R to use R Markdown. Moreover, while both R Markdown and Quarto support inline code for R using something like `` `{r} 1+2` `` to return the value of a variable or calculation using R, only Quarto supports inline code like `` `{python} 1+2` `` doing the same thing with Python.

## Conclusion

Except in a collaborative environment, it's probably not anyone's place to tell you to change from a system that works for you. Having said that, many R Markdown afficionados have already made the switch, whether by adopting Quarto when starting new projects, by going back to convert a few older things, or both. 

It's good to get other opinions, so here are three links describing differences and setting things out for R Markdown's future:

- "FAQ for R Markdown Users" - https://quarto.org/docs/faq/rmarkdown.html
- "I'm an R user: Quarto or R Markdown?" - https://www.jumpingrivers.com/blog/quarto-rmarkdown-comparison/
- "With Quarto Coming, is R Markdown Going Away? No." - https://yihui.org/en/2022/04/quarto-r-markdown/
