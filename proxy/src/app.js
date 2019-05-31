const express = require('express')
const request = require('request')
const app = express()

// catch all requests
app.all('*', (req, res, next) => {
  // Set CORS headers: allow all origins, methods, and headers
  res.header('Access-Control-Allow-Origin', '*')
  res.header('Access-Control-Allow-Methods', 'GET, PUT, PATCH, POST, DELETE')
  res.header('Access-Control-Allow-Headers', req.header('access-control-request-headers'))

  // catch cors preflight request
  if (req.method === 'OPTIONS') {
    res.send()

  // all other requests
  } else {
    const targetURL = req.header('Target-URL')
    if (!targetURL) return res.send(412, { error: 'Missing Target-URL header' })

    request({ url: targetURL + req.url, method: req.method, json: req.body }, //, headers: { 'Authorization': req.header('Authorization') }
      (err, res2, body) => {
        if (err) console.error(err)
        res.json(JSON.parse(body))
      })
  }
})

app.set('port', process.env.PORT || 3001)
app.listen(app.get('port'), () => {
  console.log(`scanmeds-proxy is now listening on port ${app.get('port')}`)
})
