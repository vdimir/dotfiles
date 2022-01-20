#!/usr/bin/env bash

set -eu

TEST_PATH="tests/queries/0_stateless"

LAST_TEST_NO="$(ls -1 ${TEST_PATH}/0*.sql | sort -nr | grep -E -o '\d{2,}' | head -1)"
NEW_TEST_NO=$(expr ${LAST_TEST_NO} + 1)

NEW_TEST_NO=$(printf %05d ${NEW_TEST_NO})


TEST_NAME=${NEW_TEST_NO}_$1

vscode ${TEST_PATH}/${TEST_NAME}.sql ${TEST_PATH}/${TEST_NAME}.reference
