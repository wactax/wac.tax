#!/usr/bin/env coffee

> @w5/walk
  @w5/uridir
  path > sep basename dirname
  zx/globals:

ROOT = uridir import.meta


update = (fp)=>
  cd dirname(fp)
  await $'git pull'
  await $'ncu -u'
  await $'ni'
  await $'git add -u'
  await $'sh -c \'git commit -m"update package.json" || true\''
  await $'git push'
  return

for await fp from walk(
  ROOT
  (i)=>
    p = i.lastIndexOf(sep)
    name = i.slice(p+1)
    [
      '.pnpm'
      'node_modules'
      'target'
      '.direnv'
      '.git'
      'npm'
      'napi-rs'
    ].includes(name)
)
  if basename(fp) == 'package.json'
    await update fp
