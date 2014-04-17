bodyParser = require "body-parser"
express    = require "express"
exec       = require("child_process").exec
uuid       = require "node-uuid"

app = express()

app.use bodyParser()

app.post "/earnings", (req, res) ->
  email    = req.body.email
  password = req.body.password
  guid     = uuid.v1()

  cmd = "casperjs earnings.coffee --email=#{email} --password='#{password}'"
  cmd += " --output=#{guid}"

  console.log "running", cmd

  exec cmd, (error, stdout, stderr) ->
    res.sendfile "tmp/#{guid}.xml"

app.post "/orders", (req, res) ->
  email    = req.body.email
  password = req.body.password
  guid     = uuid.v1()

  cmd = "casperjs orders.coffee --email=#{email} --password='#{password}'"
  cmd += " --output=#{guid}"

  console.log "running", cmd

  exec cmd, (error, stdout, stderr) ->
    res.sendfile "tmp/#{guid}.xml"

app.listen process.env.PORT || 3000
