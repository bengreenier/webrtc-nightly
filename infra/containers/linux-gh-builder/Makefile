all: build publish

# Build the container
build:
	docker build . -t docker.pkg.github.com/bengreenier/webrtc-nightly/linux-gh-builder:latest

# This should only run in CD, ideally
publish:
	docker push docker.pkg.github.com/bengreenier/webrtc-nightly/linux-gh-builder:latest
