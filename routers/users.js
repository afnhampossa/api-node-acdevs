
const header = require('./midlewere/header')

module.exports = (app, connection) => {
  // inserir cliente
  app.post('/users',(req, res) => {
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
        
        res.send(
          {
            error: "",
            data: results[0]
          }
        )
  
      });

    });

  })

  // atualizar cliente
  app.put('/users/:id', header, (req, res) => {
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
        
         res.send(
          {
            error: "",
            data: results[0]
          }
        )
  
      });

    });

  })

  // ver todos os clientes
  app.get('/users',header,  (req, res) => {

    connection.query('SELECT cl.id, cl.nome, cl.endereco, s.discricao AS sexo, e.descricao AS estado, cl.email FROM clientes AS cl INNER JOIN sexo s ON cl.sexo_id = s.id'+
    ' INNER JOIN estado e ON cl.estado_id = e.id ORDER BY cl.id DESC', (error, results) => {
      if(error){
        throw error
      }
      
      res.send({
        code: 200,
        list: results,
        total: results.length
      })

    });

  })

  // ver um cliente 
  app.get('/users/:id', header, (req, res) => {
    const {id} = req.params

    connection.query(`SELECT cl.id, cl.nome, cl.email, cl.endereco, s.discricao, e.descricao FROM clientes AS cl INNER JOIN sexo s ON cl.sexo_id = s.id
    INNER JOIN estado e ON cl.estado_id = e.id WHERE cl.id = ${id}`, (error, results) => {
      if(error){
        throw error
      }
      
      res.send({
        code: 200,
        data: results[0],
      })

    });

  })

  // search
  app.get('/users-search/:search', header, (req, res) => {
    const {search} = req.params

    connection.query(`SELECT cl.id, cl.nome, cl.email, cl.endereco, s.discricao, e.descricao FROM clientes AS cl INNER JOIN sexo s ON cl.sexo_id = s.id
    INNER JOIN estado e ON cl.estado_id = e.id WHERE cl.nome LIKE '%${search}%' OR cl.email LIKE '%${search}%'`, (error, results) => {
      if(error){
        throw error
      }
      
      res.send({
        code: 200,
        data: results,
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
