const express = require('express')
const bodyParser = require('body-parser')
const mysql = require('mysql2')


const users = require('./routers/users')

const app = express()

const PORT = 5000


app.use(bodyParser.json())
app.use(bodyParser.urlencoded({extended:true}))

// create the connection to database
const connection = mysql.createConnection({
  host: 'localhost',
  user: 'root',
  database: 'emprestimo'
});

connection.connect((error) => {
  if(error){
    throw error
  }
  
  users(app, connection)

  app.listen(PORT, ()=>{
    console.log('http://localhost:' + PORT)
  })

})