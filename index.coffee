bodyParser = require "body-parser"
express    = require "express"
exec       = require("child_process").exec
uuid       = require "node-uuid"

app = express()

app.use bodyParser()

app.post "/", (req, res) ->
  email    = req.body.email
  password = req.body.password
  guid     = uuid.v1()

  cmd = "casperjs downloader.coffee --email=#{email} --password='#{password}'"
  cmd += " --output=#{guid}"

  exec cmd, (error, stdout, stderr) ->
    res.sendfile "tmp/#{guid}.tsv"

app.listen process.env.PORT || 3000


