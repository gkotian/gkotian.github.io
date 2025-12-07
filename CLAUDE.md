# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a Jekyll-based personal website hosted on GitHub Pages. It contains a personal homepage, projects page, and a travel blog with posts from 2009-2010.

## Development Commands

**Run locally with Docker:**
```bash
docker-compose up
```
This starts the Jekyll server at http://localhost:80 (maps to Jekyll's port 4000).

**Run with bundler (alternative):**
```bash
bundle install
bundle exec jekyll serve
```

## Architecture

### Layouts (inheritance: master → default/post)
- `_layouts/master.html` - Base HTML template with site header, navigation menu, footer
- `_layouts/default.html` - Extends master, adds header/footer includes
- `_layouts/post.html` - Extends master, adds post date, title, previous/next navigation, related posts

### Key Includes
- `_includes/image.html` - Reusable image component with portrait/landscape modes, optional linking, and image courtesy attribution
- `_includes/video.html` - YouTube embed wrapper with caption support

### Content Structure
- `_posts/` - Published blog posts (HTML format)
- `_drafts/` - Unpublished draft posts (Markdown format)
- `travels/_posts/` - Travel blog posts (Markdown format)
- `assets/travels/` - Travel post images

### Post Front Matter
Posts use standard Jekyll front matter with `layout: post` and `title`. The `<!--more-->` separator (configured in `_config.yml`) marks the excerpt boundary.

### Image Include Usage
```liquid
{% include image.html img="assets/travels/image.jpg" title="Title" caption="Caption text" %}
```
Options: `portrait_image` (boolean), `url` (link), `courtesy` (attribution link)
