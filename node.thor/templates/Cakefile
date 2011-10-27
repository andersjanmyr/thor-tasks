{spawn, exec} = require 'child_process'
fs = require 'fs'


task 'build', 'continually build the src library with --watch', ->
  server = spawn 'coffee', ['-cw', '-o', 'lib', 'src/server']
  server.stdout.on 'data', (data) -> console.log data.toString().trim()

  client = spawn 'coffee', ['-cw', '-o', 'public/js/lib', 'src/client']
  client.stdout.on 'data', (data) -> console.log data.toString().trim()

  client = spawn 'coffee', ['-cw', '-o', 'public/js/lib', 'src/common']
  client.stdout.on 'data', (data) -> console.log data.toString().trim()

  client = spawn 'coffee', ['-cw', '-o', 'lib', 'src/common']
  client.stdout.on 'data', (data) -> console.log data.toString().trim()


task 'doc', 'rebuild the Docco documentation', ->
  exec([
    'docco app/*.coffee'
  ].join(' && '), (err) ->
    throw err if err
  )

