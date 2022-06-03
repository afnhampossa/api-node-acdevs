module.exports = (req, res, next) => {
  res.header("Access-Control-Allow-Origin", "*");
  res.setHeader('Access-Control-Allow-Methods', 'GET, POST, OPTIONS, PUT, PATCH, DELETE')
  res.setHeader("Access-Control-Allow-Headers","X-API-KEY, Origin, X-Requested-With, Content-Type, Accept, Access-Control-Request-Method, Authorization");


  next();
}