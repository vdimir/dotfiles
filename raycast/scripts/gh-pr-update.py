#!/usr/bin/env python3

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title GitHub Pull Request Update
# @raycast.mode compact

# Optional parameters:
# @raycast.icon 🔄
# @raycast.argument1 { "type": "text", "placeholder": "num", "optional": true }
# @raycast.argument2 { "type": "dropdown", "placeholder": "ClickHouse", "optional": true, "data": [ {"title": "ClickHouse", "value": "ClickHouse/ClickHouse"}, {"title": "clickhouse-private", "value": "ClickHouse/clickhouse-private"} ] }

# Documentation:
# @raycast.author vdimir

import subprocess
import sys
import re
import json
from urllib.parse import urlparse, parse_qs


def try_get_message(text, default=None):
    if not text:
        return default
    try:
        return json.loads(text).get("message", default)
    except json.JSONDecodeError:
        return default


def update_github_pr(repo, prnum, sha):
    """
    Update a GitHub pull request branch with the specified SHA using the GitHub CLI.

    Args:
        repo (str): The GitHub repository in the format "owner/repo".
        prnum (str): The pull request number.
        sha (str): The SHA hash of the expected head.
    """

    command = [
        "gh", "api",
        "--method", "PUT",
        "-H", "Accept: application/vnd.github+json",
        "-H", "X-GitHub-Api-Version: 2022-11-28",
        f"/repos/{repo}/pulls/{prnum}/update-branch",
        "-f", f"expected_head_sha={sha}"
    ]

    try:
        result = subprocess.run(command, check=True, capture_output=True, text=True)
        message = try_get_message(result.stdout, result.stdout)
        print(f"Updated #{prnum} successfully: {message}")
    except subprocess.CalledProcessError as e:
        raise ValueError(try_get_message(e.stdout, e.stderr))

REPORT_URL_PREFIXES = {
    "https://s3.amazonaws.com/clickhouse-test-reports/": "ClickHouse/ClickHouse",
    "https://d1k2gkhrlfqv31.cloudfront.net/clickhouse-test-reports-private/": "ClickHouse/clickhouse-private",
}


def parse_report_url(input_value):
    """
    Parse a CI report URL (json.html, praktika.html, ...) into (repo, prnum, sha).
    Returns None if input_value is not a known report URL.
    """
    for prefix, url_repo in REPORT_URL_PREFIXES.items():
        if not input_value.startswith(prefix):
            continue
        query = parse_qs(urlparse(input_value).query)
        prnum = query.get("PR", [None])[0]
        sha = query.get("sha", [None])[0]
        if not prnum or not sha:
            raise ValueError("Report URL must contain PR and sha query parameters")
        return url_repo, prnum, sha
    return None


GITHUB_PR_URL_RE = re.compile(
    r"^https?://github\.com/([^/]+/[^/]+)/pull/(\d+)/(?:changes|commits|files)/([0-9a-f]{40})(?:[/?#].*)?$"
)


def parse_github_pr_url(input_value):
    """
    Parse a GitHub PR URL like
    https://github.com/ClickHouse/ClickHouse/pull/123325/changes/<sha>
    into (repo, prnum, sha). Returns None if it does not match.
    """
    match = GITHUB_PR_URL_RE.match(input_value)
    if not match:
        return None
    return match.group(1), match.group(2), match.group(3)


def parse_input(repo, input_value):
    input_value = input_value.strip()
    parsed = parse_report_url(input_value) or parse_github_pr_url(input_value)
    if parsed:
        return parsed

    parts = input_value.split("/")
    if len(parts) != 2:
        parts = input_value.split("&sha=")
    if len(parts) != 2:
        raise ValueError("Argument must be in the format prnum/sha, a CI report URL, or a GitHub PR URL")
    return repo, *parts

def get_clipboard():
    result = subprocess.run(["pbpaste"], capture_output=True, text=True)
    return result.stdout.strip()


def main():
    input_value = sys.argv[1] if len(sys.argv) > 1 else ""
    if not input_value:
        input_value = get_clipboard()
    if not input_value:
        raise ValueError("No input provided and clipboard is empty")
    default_repo = "ClickHouse/ClickHouse"
    repo = sys.argv[2] if len(sys.argv) > 2 and sys.argv[2] != "" else default_repo

    repo, prnum, sha = parse_input(repo, input_value)
    if not prnum.isnumeric():
        raise ValueError("PR number must be a number")
    if not re.match(r"^[0-9a-f]{40}$", sha):
        raise ValueError("SHA must be a 40-character hexadecimal string")

    update_github_pr(repo, prnum, sha)


if __name__ == "__main__":
    try:
        main()
    except ValueError as e:
        print(f"Error: {e}")
        sys.exit(1)
