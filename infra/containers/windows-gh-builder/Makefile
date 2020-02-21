all: build publish

build:
	docker build . -t docker.pkg.github.com/bengreenier/webrtc-nightly/windows-gh-builder:latest

publish:
	docker push docker.pkg.github.com/bengreenier/webrtc-nightly/windows-gh-builder:latest
