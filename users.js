
var users = []

module.exports = (app) => {
  // endpint post
  app.post('/users', (req,res) => {
  const user = req.body 
  
  users.push(user)
  res.send(user)
  })

  // ver todos usuarios no vetor
  app.get('/users', (req, res) => {
  res.send({
    code: 200,
    data: users,
    total: users.length
  })
  })

  // ver um usuario no vetor
  app.get('/users/:id', (req, res) => {
  const id = req.params.id


  res.send({
    code: 200,
    data: users[id],
    total: users.length
  })
  }) 
}
