#!/bin/bash

protoc --dart_out=. msg.proto --plugin=protoc-gen-dart=$HOME/.pub-cache/bin/protoc-gen-dart