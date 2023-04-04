#!/usr/bin/env coffee

> @w5/uridir
  path > join
  @w5/write
  @w5/lang
  @w5/read
  pug

ROOT = uridir(import.meta)

fp = (args...)=>
  join ROOT, ...args

readme = (lang)=>
  "https://github.com/wacdoc/#{lang}/blob/main/README.md#readme"

txt = [
  pug.compileFile(fp 'doc.head.pug')()+'\n'
]

add = (lang, name)=>
  txt.push "## [#{name}](#{readme lang})"


for [l,name] from lang
  md = (read fp l,'README.md').split '\n'

  add l,name
  for i,pos in md
    if i.startsWith '#'
      break

  for i from md[pos+1...]
    if i.startsWith '#'
      break
    txt.push i

  txt.push "[→ #{read(fp l,'_.link.md').trim()}](#{readme l})\n"

write(
  fp 'README.md'
  txt.join('\n')
)

# > @w5/lang:LANG
#   @w5/htm2md
#   @w5/md2htm
#   chalk
#   @w5/read
#   @w5/tran > tranHtml tranText
#   path > join
#   fs > existsSync
#   @w5/bar:Bar
#   pug
#
# {gray} = chalk
#
# BAR = Bar LANG.length - 1
#
#
#
# TXT = do=>
#   li = []
#
#   for i from read(fp 'zh/README.md').split('\n')[2..]
#     if i.startsWith '#'
#       break
#     li.push i
#
#   li.join('\n')
#
# li = [
# ]
#
# TIP = '点此阅读，了解更多'

# ZH = 'zh'
#
# n = 0
# for [lang,name] from LANG
#   BAR.log(lang, name)
#   li.push "# [#{name}](#{readme lang})\n"
#   if lang == 'zh'
#     tip = TIP
#     txt = TXT
#   else
#     # for await i from tranText [TIP], lang, ZH
#     #   tip = i
#     #   break
#
#     # for await i from tranHtml [await md2htm(TXT)], lang, ZH
#     #   htm = i
#     #   break
#     # txt = htm2md htm
#   add(txt, tip, lang)
#   BAR()
#
# out = li.join '\n'
#
#
#
