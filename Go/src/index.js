const express = require("express");
const app = express();
const morgan = require(`morgan`);
//configuraciones
app.set(`port`,process.env.PORT||3000);
    // si en caso existe un puerto predeterminado utilizara ese de lo contrario el puerto 3000

//middlewares
app.use(morgan(`dev`));
    //recibir datos de formulario datos sencillos, texto desde inputs
app.use(express.urlencoded({ extended: false }));
    //permitir al servidor entender archivos json
app.use(express.json()); 

//rutas
app.get('/',(req,res)=>{
    res.send('Hello World');
});

//iniciando servidor
app.listen(app.get(`port`), () => {
  console.log(`Server on port ${app.get(`port`)}`);
});
