#!/usr/bin/env node

const http = require('http')
const express = require('express')
const app = express()

app.get('/', (req, res) => res.send('Hello, Unit!'))

http.createServer(app).listen()
