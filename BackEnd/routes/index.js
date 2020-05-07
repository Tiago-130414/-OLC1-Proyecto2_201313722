const { Router } = require(`express`);
const fs = require(`fs`);
const router = Router();

router.get("/", (req, res) => {
  res.json({ "Title": "Hello World" });
});

router.post("/",(req,res)=>{
  console.log(req.body.texto);
  res.json({ "prueba": "recibido" });
});
module.exports = router;
