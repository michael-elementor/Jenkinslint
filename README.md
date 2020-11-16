
pre-commit-jenkinslint
========================

## What is this?

This code provides a [pre-commit](http://pre-commit.com) hook package to detect issues in your Jenkinsfile.

## How does this work?
- local Jenkins container runs validator on your Jenkinsfile
- Note that you can also use a `.groovy ` file as well!

## How to setup Jenkinslint?

- Run the `docker-compose up -d` command to make sure the jenkins local container will run and the Jenkinslint can run verifications against
(in TBD: Add all needed "Pipeline" plugins automated installations.)




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

- Install the pre-commit hook.
```script
> pre-commit install
Running in migration mode with existing hooks at .git/hooks/pre-commit.legacy
Use -f to use only pre-commit.
pre-commit installed at .git/hooks/pre-commit
```

[EXAMPLE]:
- Wreak havoc in the Jenkinsfile and make Jenkinslint save your a$$

```

> vi Jenkinsfile
> git add Jenkinsfile
> git commit -m "FAIL"
[INFO] Initializing environment for https://github.com/michael-elementor/Jenkinslint.
Lint Jenkinsfile.........................................................Failed
- hook id: validate
- exit code: 1

Validating Jenkinsfile
Errors encountered validating Jenkinsfile:
WorkflowScript: 5: Not a valid section definition: "vdsvasd". Some extra configuration is required. @ line 5, column 1.
   vdsvasd
   ^

WorkflowScript: 6: Not a valid section definition: "asd". Some extra configuration is required. @ line 6, column 1.
   asd

```

# Jenkinslint

### TODO:
- Add a Dockerfile with instructions to create the docker contianer.
