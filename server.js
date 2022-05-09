const express = require('express')
const bodyParser = require('body-parser')
const users = require('./users')
const app = express()

const PORT = 3000


app.use(bodyParser.json())
app.use(bodyParser.urlencoded({extended:true}))

users(app)

app.listen(PORT, ()=>{
    console.log('http://localhost:' + PORT)
})