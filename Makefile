.phony: build push test

build:
	docker build . -t levmichael3/jenkins-lint:1.0

push:
	docker push levmichael3/jenkins-lint:1.0

test:
	pre-commit try-repo . docker-jenkinslint --verbose --files Jenkinsfile
