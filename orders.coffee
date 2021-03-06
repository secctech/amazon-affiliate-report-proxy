casper  = require("casper").create()

loginURL = "https://affiliate-program.amazon.com/gp/associates/join/landing/main.html"

reportURL = "https://affiliate-program.amazon.com/gp/associates/network/reports/report.html?tag=&reportType=ordersReport&periodType=preSelected&preSelectedPeriod=yesterday&submit.download_XML.x=32&submit.download_XML.y=10&submit.download_XML=Download+report+%28XML%29"

casper.userAgent "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1)"

casper.start loginURL, ->
  this.fill "form[name=sign_in]",
    username: casper.cli.get "email"
    password: casper.cli.get "password"
  , true

casper.then ->
  this.waitForText "Welcome to Associates Central", ->
    console.log "login successful"

casper.then ->
  guid  = casper.cli.get "output"
  fname = "tmp/#{guid}.xml"

  casper.download reportURL, fname

casper.run ->
  this.echo("report downloaded").exit()
