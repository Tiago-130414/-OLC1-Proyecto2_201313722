const express = require(`express`);
const app = express();
const morgan = require(`morgan`);
//configuraciones
app.set(`port`, process.env.PORT || 3000);
// si en caso existe un puerto predeterminado utilizara ese de lo contrario el puerto 3000

// middleware intermedio
// Configurar cabeceras y cors
app.use((req, res, next) => {
    res.header('Access-Control-Allow-Origin', '*');
    res.header('Access-Control-Allow-Headers', 'Authorization, X-API-KEY, Origin, X-Requested-With, Content-Type, Accept, Access-Control-Allow-Request-Method');
    res.header('Access-Control-Allow-Methods', 'GET, POST, OPTIONS, PUT, DELETE');
    res.header('Allow', 'GET, POST, OPTIONS, PUT, DELETE');
    next();
});
//espaciado de json
app.set(`json spaces`, 2);

app.use(morgan(`dev`));
//recibir datos de formulario datos sencillos, texto desde inputs
app.use(express.urlencoded({ extended: false }));
//permitir al servidor entender archivos json
app.use(express.json());

//rutas
// /api/index solo es por convencion para saber que se esta accediendo a una api
app.use("/api/index", require("./routes/index"));

//iniciando servidor
app.listen(app.get(`port`), () => {
  console.log(`Server on port ${app.get(`port`)}`);
});
