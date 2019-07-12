# washreads
A [Goodreads] plugin for [Wash].

This is an external plugin for [Wash] built according to docs at https://puppetlabs.github.io/wash/docs/external_plugins.

## Requirements

The goodreads script is written in Ruby. It uses oauth for authentication with the [Goodreads API] and Nokogiri for processing its XML.
```
gem install oauth nokogiri --user-install
```

You'll also need a [Goodreads] account and a developer key/secret from https://www.goodreads.com/api/keys stored in GOODREADS_KEY and GOODREADS_SECRET environment variables.

You can try the plugin out by adding it to your `~/.puppetlabs/wash/wash.yaml` config:
```
external-plugins:
  - script: '/path/to/washreads/goodreads'
```

## How it was made

The Goodreads script documents the steps in which it was created, which are reproduced here as a high-level guide to how to incrementally create an external plugin.

1. Figure out authentication: we need to authenticate against the [Goodreads API] each time we make a request. We can either initialize that as part of Wash's `init` call to our script and have it passed back as state data to each call, or cache it in a file to be reloaded each time the script is run. Since authentication in this case requires following a link to a website, we want to do that as infrequently as possible so we initialize it once and save to a file, to be reloaded every time the script is run.
1. Provide a basic `init` method: get any data we'll want throughout the lifetime of the plugin. In this case we save the ID of the user we authenticated with.
1. List the plugin root: respond to a `list /goodreads` request with a list of bookshelves from Goodreads.
1. Add state we can use to keep track of what we're interacting with: pass information about the shelf - name and number of books - back as state that will be provided when listing those shelves.
1. List books on a shelf: respond to a `list /goodreads/<shelf>` request with a list of books on that shelf. The Goodreads API paginates the book data for a shelf, so we use the number of books to determine how many pages to load. We also make use of state - where we included a `type: shelf` field - to match this type of request rather than relying on string munging of the path.

[Goodreads]: https://goodreads.com
[Wash]: https://puppetlabs.github.io/wash
[Goodreads API]: https://www.goodreads.com/api
