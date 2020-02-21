all: build publish

build:
	docker build . -t docker.pkg.github.com/bengreenier/webrtc-nightly/linux-gh-builder:latest

publish:
	docker push docker.pkg.github.com/bengreenier/webrtc-nightly/linux-gh-builder:latest
