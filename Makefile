# Copyright 2016 Victor Palma
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#     http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
PROJECT_NAME = "peas"
BUILD_FLAGS :=  "-s -w -X main.gitVersion=`git rev-parse HEAD`"
SYSTEM = `uname -s`


#example-app CLI
.PHONY: default
default: clean test coverage build

.PHONY: linux-binary
linux-binary:
	CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -ldflags $(BUILD_FLAGS) -o builds/Linux/$(PROJECT_NAME) cmd/$(PROJECT_NAME)/main.go

.PHONY: darwin-binary
darwin-binary:
	CGO_ENABLED=0 GOOS=darwin go build -a -installsuffix cgo -ldflags $(BUILD_FLAGS) -o builds/Linux/$(PROJECT_NAME) cmd/$(PROJECT_NAME)/main.go

.PHONY: windows-binary
windows-binary:
	CGO_ENABLED=0 GOOS=windows go build -a -installsuffix cgo -ldflags $(BUILD_FLAGS) -o builds/Linux/$(PROJECT_NAME) cmd/$(PROJECT_NAME)/main.go

.PHONY: build
build:  test
	go build -a -ldflags $(BUILD_FLAGS) -o builds/$(SYSTEM)/$(PROJECT_NAME) cmd/$(PROJECT_NAME)/main.go

.PHONY: install
install: build mv-bin

.PHONY: mv-bin
mv-bin:
	cp builds/$(SYSTEM)/$(PROJECT_NAME) ${GOPATH}/bin/

.PHONY: clean
clean:
	rm -f builds/Darwin/$(PROJECT_NAME)
	rm -f builds/Linux/$(PROJECT_NAME)
	rm -f builds/Windows/$(PROJECT_NAME)

.PHONY: test
test:
	@rm -f cmd/coverage/coverage.txt
	@rm -f cmd/coverage/coverage.tmp
	echo 'mode: atomic' > cmd/coverage/coverage.txt && go list ./cmd/... | xargs -n1 -I{} sh -c 'go test -covermode=atomic -coverprofile=./cmd/coverage/coverage.tmp {} && tail -n +2 ./cmd/coverage/coverage.tmp >> ./cmd/coverage/coverage.txt'

.PHONY: coverage
coverage:
	go tool cover -html=./cmd/coverage/coverage.txt -o ./cmd/coverage/full-report.html

.PHONY: release
release: clean test coverage darwin-binary linux-binary windows-binary
