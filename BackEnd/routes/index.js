const { Router } = require(`express`);
const fs = require(`fs`);
const router = Router();


var TextoAnalizar1 =" "; //texto 1
var TextoAnalizar2 =" "; //texto 2
var JsonTemp1 = []; //guarda un json temporal para obtener el verdadero arbol a analizar
var JsonTemp2 = [];
var Arbolito1 = []; // guarda el arbol de texto 1
var Arbolito2 = []; // guarda el arbol de texto 2
var ReporteAst; // guarda json de reporte ast
var ErroresLexicos; //errores lexicos
var ErroresSintacticos;//errores Sintacticos
var ErroresLS;// errores lexico Sintacticos


//GET RETORNAR ARBOL1
router.get("/RetornarReporteClasesCopia", (req, res) => {
  const reporteCC = require('./VerificadorCopias'); 
  var txto = reporteCC.reporteClaseCopia(Arbolito1,Arbolito2);
  res.json({txt: txto});
});

//GET RETORNAR ARBOL2
router.get("/RetornarReporteFuncionesCopia", (req, res) => {
  const reporteFC = require('./VerificadorCopias'); 
  var txto = reporteFC.reporteFuncionesCopia(Arbolito1,Arbolito2);
  res.json({txt:txto});
});

//GET LEXICOS
router.get("/ErroresL", (req, res) => {
  //console.log(JSON.stringify(ErroresLexicos,null,2));
  const reporteErroresL = require('./ErroresLS'); 
  var erroresL = reporteErroresL.leerJsonErroresL(ErroresLexicos);
  res.json({ErroresL : erroresL});
});

//GET SINTACTICOS
router.get("/ErroresS", (req, res) => {
  const reporteErroresL = require('./ErroresLS'); 
  var erroresS = reporteErroresL.leerJsonErroresS(ErroresSintacticos);
  res.json({ErroresSintac : erroresS});
});

//GET LEXICOS SINTACTICOS
router.get("/ErroresLS", (req, res) => {
  const erroresLs = require('./ErroresLS');
  var leerELS = erroresLs.leerJsonErroresLS(ErroresLS);
  res.json({ELS : leerELS});
});

//GET QUE ENVIA EL REPORTE AST
router.get("/ReportArbol", (req, res) => {
  res.json(ReporteAst);
});

//POST QUE RECIBE EL ARCHIVO 1
router.post("/Archivo1",(req,res)=>{
//OBTENGO TEXTO QUE ENVIAN DESDE PAGINA Y ASIGNO COMO TEXTO1
TextoAnalizar1 = req.body.texto;
//CONSTANTE DE REPORTE AST
const ReporteArbol = require('./ReporteAst.js');
//CONSTANTE QUE ME GENERA EL ARBOL Y OTROS REPORTES
const AnalizarArchivoJava = require('./AnalizadorJavaAst');
/*-----------------------------------------GENERAR ARBOL------------------------------------------- */
JsonTemp1 = AnalizarArchivoJava.parse(TextoAnalizar1);
Arbolito1 = AnalizarArchivoJava.ArchivoJava();
/*-----------------------------------------REPORTE AST---------------------------------------------*/
//LIMPIO LOS VECTORES
ReporteArbol.LimpiarV();
ReporteArbol.LimpiarV();
//REPORTE ARBOL AST
ReporteAst = ReporteArbol.parse(TextoAnalizar1);
/*-----------------------------------------REPORTE ERRORES---------------------------------------------*/
ErroresLexicos = ReporteArbol.errL();
ErroresSintacticos = ReporteArbol.errS();
ErroresLS = ReporteArbol.errLS();
//LIMPIO VECTORES
ReporteArbol.LimpiarV();
ReporteArbol.LimpiarV();
//RESPONDO A PAGINA
res.json({ "prueba": "Archivo1-Recibido" });
});

//POST QUE RECIBE EL ARCHIVO 2
router.post("/Archivo2",(req,res)=>{
//CONSTANTE QUE GENERA EL ARBOL 2 PARA COMPARAR
const AnalizadorJavaArchivo2 = require('./AnalizadorJavaAst');
//GUARDO EL TEXTO 2
AnalizadorJavaArchivo2.LimpiarV();
AnalizadorJavaArchivo2.LimpiarV();
TextoAnalizar2 = req.body.texto;
JsonTemp2 = AnalizadorJavaArchivo2.parse(TextoAnalizar2);
//OBTENGO EL ARBOL 2 
Arbolito2 = AnalizadorJavaArchivo2.ArchivoJava();
AnalizadorJavaArchivo2.LimpiarV();
AnalizadorJavaArchivo2.LimpiarV();
res.json({ "prueba": "Archivo2-Recibido" });
});


module.exports = router;