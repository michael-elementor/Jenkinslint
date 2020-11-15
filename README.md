
pre-commit-jenkinslint
========================

## What is this?

This provides a [pre-commit](http://pre-commit.com)
package to detect issues in your Jenkinsfile.

## How does this work?

## How would I use this repository with pre-commit?

Install pre-commit as per instructions at https://pre-commit.com/#install.
You'll also need to use at least version 0.10.0 of pre-commit.

Add this to your `.pre-commit-config.yaml` in root of your repo:

```yaml
-   repo: https://github.com/michael-elementor/Jenkinslint
    rev: v0.1.1
    hooks:
    -   id: validate


```

Install the pre-commit hook.
`pre-commit install`
# Jenkinslint
