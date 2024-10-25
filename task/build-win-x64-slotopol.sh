#!/bin/bash -u
# This script compiles project with Megajack games only for Windows amd64.
# It produces static C-libraries linkage.

wd=$(realpath -s "$(dirname "$0")/..")
cp -ruv "$wd/confdata/"* "$GOPATH/bin/config"

buildvers=$(git describe --tags)
# See https://tc39.es/ecma262/#sec-date-time-string-format
# time format acceptable for Date constructors.
buildtime=$(date +'%FT%T.%3NZ')

go env -w GOOS=windows GOARCH=amd64 CGO_ENABLED=1
go build -o "$GOPATH/bin/slot_win_x64_slotopol.exe" -v -tags="jsoniter prod megajack" -ldflags="-linkmode external -extldflags -static -X 'github.com/slotopol/server/config.BuildVers=$buildvers' -X 'github.com/slotopol/server/config.BuildTime=$buildtime'" $wd
