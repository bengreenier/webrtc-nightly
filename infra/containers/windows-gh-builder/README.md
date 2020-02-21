# windows-gh-builder

A windows container that runs the [GitHub Actions Runner](https://github.com/actions/runner).

## Configuration

> Configuration is driven by environment variables. Set these with `-e` when running the container.

- `GH_TOKEN` - A valid runner access token
- `GH_URL` - A valid GitHub repository url
