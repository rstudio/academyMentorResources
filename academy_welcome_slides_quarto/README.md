# Academy welcome slides using Quarto and revealJS

Slides for three Academy courses can be found in three files:

- course-tidyverse.qmd
- course-pinr.qmd
- course-shiny.qmd

Other files are used to build up these course slides from common resources. For instance "_s-..." is a slide used for multiple courses, and "_project-..." is a project, while "_metadata.yml" defines all the common header fields shared by the courses. The "_course-*.qmd" files organize them all with Quarto includes before `flatten_qmd()` makes the no-underscore files, which are easier to customize.

Things render correctly using Quarto v. 1.8 with R version 4.5.0 and the following packages installed: `glue`, `htmltools`, `lubridate`, `rmarkdown`, `stringr`.

To get started with the template for whatever course you're leading, open up "**course-tidyverse.qmd**" or "**course-pinr.qmd**" or "**course-shiny.qmd**" and follow the steps below.

## 1. Set parameters

At the top of your "**course_....qmd**" Quarto file, change these parameters:

- `date` (the date of your welcome meeting)
- `mentor` (your name)
- `scheduler` (your URL to schedule 1:1 meetings)
- `campsite` (the URL to access your group's tutorials)
- `new_campsite` (whether your Tidyverse campsite uses the 2026 redesign)
- `communication` ("Teams" or "Slack" or something else)
- `group` (the name of the group)
- `weeks` (how many weeks you're meeting)
- `day1` (the first day meeting each week, e.g., "Tuesday")
- `day2` (the second day meeting each week, e.g., "Thursday")
- `become` (a string to used in an early slide)
- `lesson1` (the name of the first lesson on the campsite)

## 2. Choose your project

Near the bottom of "**course-tidyverse.qmd**" or "**course-pinr.qmd**", look for the project your group has been assigned. The relevant lines will start with `{{< include _project-tidyverse-mdrd.qmd >}}` or `{{< include _project-pinr-rhc.qmd >}}` Make sure that your project is not commented out---and then comment out the other projects.

## 3. Decide if you want to do introductions 

The welcome meeting goes faster if you skip introductions. Moreover, when you mention later that you're using Teams or Slack to communicate, you can use that moment to hit "Send" on a pre-made introduction of yourself, thereby encouraging others to respond (and hopefully getting them to use that channel more regularly). But this is up to you. The files currently skip intros in the welcome meeting. If you'd prefer to keep intros, uncomment the lines near the top of your "**course-....qmd**" file. While you're at it, be sure to include *your* details, and drop a picture of yourself in "**images/**".

(A slide deck that begins with commented-out lines will add a blank slide when rendering. Just delete those lines if they're not needed.)

## 4. Render

When you're done, hit "Render" to get a standalone HTML file.

Or on the terminal type `quarto render course-tidyverse.qmd --output my-presentation.html`
