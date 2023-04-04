#!/usr/bin/env coffee

> @w5/lang/zh:LANG

{ GITHUB_ACCESS_TOKEN } = process.env

ORG = 'wacdoc'
createRepo = (repoName) =>
  # url = "https://api.github.com/repos/wacdev/#{repoName}"
  # console.log url
  # (
  #   await fetch(
  #     url
  #     method: "DELETE"
  #     headers:
  #       "Authorization": "Bearer #{GITHUB_ACCESS_TOKEN}"
  #   )
  # ).text()
  (
    await fetch(
      "https://api.github.com/orgs/#{ORG}/repos"
      method: 'POST'
      headers:
        Authorization: "Bearer #{GITHUB_ACCESS_TOKEN}"
        'Content-Type': 'application/json'
      body: JSON.stringify
        name: repoName
        auto_init: false
    )
  ).json()

LANG.reverse()

for [code,name] from LANG
  console.log code+'/'
  # console.log await createRepo code

