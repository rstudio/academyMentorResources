library(fs)
library(stringr)
library(purrr)
library(readr)
library(glue)

split_front_matter <- function(text) {
  lines <- strsplit(text, "\n")[[1]]
  if (length(lines) >= 2 && trimws(lines[1]) == "---") {
    end_idx <- which(trimws(lines[-1]) == "---")
    if (length(end_idx) > 0) {
      end_idx <- end_idx[1] + 1
      yml  <- paste(lines[1:end_idx], collapse = "\n") # includes both --- lines
      if (end_idx < length(lines)) {
        body <- paste(lines[(end_idx + 1):length(lines)], collapse = "\n")
      } else {
        body <- ""
      }
      return(list(yaml_block = yml, body = body))
    }
  }
  list(yaml_block = NULL, body = text)
}

expand_shortcode_includes <- function(body, base_dir, skip_prefixes, keep_included_yaml, seen = character()) {
  should_skip_include <- function(full_path) {
    nm <- path_file(full_path)
    any(map_lgl(skip_prefixes, ~ str_starts(nm, .x)))
  }

  pattern <- "\\{\\{<\\s*include\\s+([^>]+?)\\s*>\\}\\}"
  out <- body

  skip_map <- character(0)
  skip_i <- 0L

  repeat {
    m <- str_match(out, pattern)
    if (is.na(m[1, 1])) break

    shortcode <- m[1, 1]
    raw_arg   <- str_trim(m[1, 2])
    rel_path  <- str_replace_all(raw_arg, "^['\"]|['\"]$", "")
    full_path <- path_norm(path(base_dir, rel_path))

    if (!file_exists(full_path)) {
      stop(glue("Include file not found: {full_path}"))
    }
    if (full_path %in% seen) {
      stop(glue("Include cycle detected: {paste(c(seen, full_path), collapse = ' -> ')}"))
    }

    if (should_skip_include(full_path)) {
      # if (verbose) message(glue("Skipping include (exception rule): {full_path}"))
      skip_i <- skip_i + 1L
      sentinel <- glue("<<__QMD_INCLUDE_SKIPPED_{skip_i}__>>")
      skip_map[sentinel] <- shortcode
      out <- sub(pattern, sentinel, out)
      next
    }

    inc_text <- readr::read_file(full_path)

    inc_inline <- if (keep_included_yaml) {
      expand_shortcode_includes(inc_text, path_dir(full_path), skip_prefixes, keep_included_yaml, seen = c(seen, full_path))
    } else {
      inc_parts <- split_front_matter(inc_text)
      expand_shortcode_includes(inc_parts$body, path_dir(full_path), skip_prefixes, keep_included_yaml, seen = c(seen, full_path))
    }

    # if (verbose) message(glue("Inlined: {full_path}"))
    out <- stringr::str_replace(out, pattern, ~ inc_inline)
  }

  # restore skipped shortcodes
  if (length(skip_map) > 0) {
    for (s in names(skip_map)) out <- str_replace(out, fixed(s), skip_map[[s]])
  }

  out
}

flatten_qmd <- function(
    infile,
    outfile,
    skip_prefixes = c("_content", "_project"),
    keep_included_yaml = TRUE
) {
  write_utf8 <- function(path, text) {
    dir_create(path_dir(path))
    readr::write_file(text, path)
    }

  infile <- path_norm(infile)
  base_dir <- path_dir(infile)

  text  <- readr::read_file(infile)
  parts <- split_front_matter(text)

  new_body <- expand_shortcode_includes(parts$body, base_dir, skip_prefixes, keep_included_yaml = keep_included_yaml)

  if (!is.null(parts$yaml_block)) {
    out_text <- paste0(parts$yaml_block, "\n", new_body)
  } else {
    out_text <- new_body
  }

  write_utf8(path_norm(outfile), out_text)
  invisible(path_norm(outfile))
}

# Flatten all the course files
list.files(pattern = "_course.*[.]qmd") |>
  walk(\(x) {
    flatten_qmd(
      infile = x,
      outfile = str_replace(x, "^_", "")
      )
    })
