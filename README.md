# Bridgetown Writebook

A Bridgetown plugin to add [WriteBook](https://once.com/writebook) style books to your static website.

## Installation

Run this command to add this plugin to your site's Gemfile:

```shell
bundle add bridgetown_writebook
```

## Usage

After installation, the plugin provides a complete book management system for your Bridgetown site. Books are organized as collections, with each book containing multiple chapters.

### Creating Your First Book

1. **Set up the books infrastructure** (one-time setup):
   ```shell
   bridgetown book setup
   ```
   This creates the necessary folder structure and adds the books collection to your Bridgetown configuration.

2. **Create a new book**:
   ```shell
   bridgetown book new --title "My Awesome Book"
   ```
   This creates a folder under `src/_books/` with an initial metadata file.

3. **Add chapters to your book**:
   ```shell
   bridgetown book chapters add --book "My Awesome Book" --title "Introduction"
   ```
   Chapters are automatically numbered and added to your book's folder.

### Book Structure

Each book consists of:
- A metadata file (`00-meta.md`) containing title, subtitle, and authors
- Numbered chapter files (e.g., `01-introduction.md`, `02-getting-started.md`)
- An optional cover image (`cover.png` in the book's folder)

### Accessing Your Books

The plugin automatically generates:
- A books index page at `/books/` listing all your books
- Individual book pages at `/books/[book-slug]/` showing chapters
- Chapter pages with navigation between previous/next chapters

----

## Releasing (you can delete this section in your own plugin repo)

To release a new version of the plugin, simply bump up the version number in both `version.rb` and
`package.json`, and then run `script/release`. This will require you to have a registered account
with both the [RubyGems.org](https://rubygems.org) and [NPM](https://www.npmjs.com) registries.
You can optionally remove the `package.json` and `frontend` folder if you don't need to package frontend
assets for Webpack.

If you run into any problems or need further guidance, please check out our [Bridgetown community resources](https://www.bridgetownrb.com/docs/community)
where friendly folks are standing by to help you build and release your plugin or theme.

**NOTE:** make sure you add the `bridgetown-plugin` [topic](https://github.com/topics/bridgetown-plugin) to your
plugin's GitHub repo so the plugin or theme will show up on [Bridgetown's official Plugin Directory](https://www.bridgetownrb.com/plugins)! (There may be a day or so delay before you see it appear.)
