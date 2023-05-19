#!/usr/bin/env coffee

> @w5/walk
  @w5/uridir
  path > sep basename dirname
  zx/globals:

ROOT = uridir import.meta


update = (fp)=>
  dir = dirname(fp)

  run = (cmd)=>
    $"sh -c 'cd #{dir} && #{cmd.split(' ')}'"

  await run 'git pull'
  await run 'ncu -u'
  await run 'ni'
  await run 'git add -u'
  await run 'git commit -m"update package.json" || true'
  await run 'git push'
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
