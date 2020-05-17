const { Router } = require(`express`);
const AnalizadorJava = require('./AnalizadorLSJava.js');
const fs = require(`fs`);
const router = Router();

var TextoAnalizar1 =" ";
var TextoAnalizar2 =" ";

router.get("/", (req, res) => {
  var Arbolito = AnalizadorJava.parse(TextoAnalizar1);
  res.json(Arbolito);
});

router.post("/",(req,res)=>{
  console.log(req.body.texto);
  if(TextoAnalizar1 == " "){
    TextoAnalizar1 = req.body.texto;
  }else if(TextoAnalizar2 ==" "){
    TextoAnalizar2 = req.body.texto;
  }else{
    TextoAnalizar1 = req.body.texto;
    TextoAnalizar2 = req.body.texto;
  }
  res.json({ "prueba": "recibido" });
});
module.exports = router;
