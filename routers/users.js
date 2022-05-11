
var users = []

module.exports = (app, connection) => {
  // inserir cliente
  app.post('/users', (req, res) => {
    const user = req.body

    connection.query('INSERT INTO clientes SET ?', [user], (error, results) => {
      if(error){
        throw error
      }

      const {insertId} = results
      
      connection.query('SELECT * FROM clientes WHERE id = ? LIMIT 1', [insertId], (error, results) => {
        if(error){
          throw error
        }
        
        res.send(results[0])
  
      });

    });

  })

  // atualizar cliente
  app.put('/users/:id', (req, res) => {
    const user = req.body
    const {id} = req.params

    connection.query('UPDATE clientes SET ? WHERE id = ?', [user, id], (error, results) => {
      if(error){
        throw error
      }

      
      connection.query('SELECT * FROM clientes WHERE id = ? LIMIT 1', [id], (error, results) => {
        if(error){
          throw error
        }
        
        res.send(results[0])
  
      });

    });

  })

  // ver todos os clientes
  app.get('/users', (req, res) => {

    connection.query('SELECT * FROM clientes', (error, results) => {
      if(error){
        throw error
      }
      
      res.send({
        code: 200,
        data: results,
        total: results.length
      })

    });

  })

  // ver um cliente 
  app.get('/users/:id', (req, res) => {
    const {id} = req.params

    connection.query(`SELECT * FROM clientes WHERE id = ${id}`, (error, results) => {
      if(error){
        throw error
      }
      
      res.send({
        code: 200,
        data: results[0],
      })

    });

  })

  // eliminar um cliente 
  app.delete('/users/:id', (req, res) => {
    const {id} = req.params

    connection.query('SELECT * FROM clientes WHERE id = ?', [id], (error, results) => {
      if(error){
        throw error
      }

      const [user] = results
      
      connection.query('DELETE FROM clientes WHERE id = ?', [id], (error, results) => {
        if(error){
          throw error
        }
  
        res.send(user)
  
      });

    });

  })

  
}
