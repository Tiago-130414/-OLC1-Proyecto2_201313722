function abrir_archivo() {
  var abrirAr = document.createElement("input");
  abrirAr.setAttribute("type", "file");
  abrirAr.setAttribute("a", "file");
  abrirAr.setAttribute("accept", ".java");
  abrirAr.click();
  abrirAr.addEventListener("change", leerArchivo, false);
}

function leerArchivo(e) {
  var archivo = e.target.files[0];
  if (!archivo) {
    return;
  }
  var lector = new FileReader();
  lector.onload = function (e) {
    var contenido = e.target.result;
    mostrarContenido(contenido);
    var nombreAr = archivo.name;
    cambiarNombre(nombreAr);
  };
  lector.readAsText(archivo);
}

function cambiarNombre(nombre) {
  /*var pestanaAct = document.getElementsByClassName('tab-pane fade in active');
    var cajatxt = pestanaAct[0].getAttribute('id');*/
  var titulo = document.getElementById("pes" + numeroPestana);
  titulo.innerHTML = nombre;
}

function mostrarContenido(contenido) {
  GenerarPestana();
  /* var pestanaAct = document.getElementsByClassName('tab-pane fade in active');
    var cajatxt = pestanaAct[0].getAttribute('id');*/
  var txt = document.getElementById("text" + numeroPestana);
  txt.innerHTML = contenido;
}

function conexion() {
  var pestanaAct = document.getElementsByClassName("tab-pane fade in active");
  var cajatxt = pestanaAct[0].getAttribute("id");
  var txt = document.getElementById("text" + cajatxt);
  var obtenerTexto = txt.value;
  console.log(obtenerTexto);

  var url = 'http://localhost:3000/api/index';
  var data = {texto:"\'"+obtenerTexto+"\'"};
  
  fetch(url, {
    method: 'POST', 
    body: JSON.stringify(data),
    headers:{
      'Content-Type': 'application/json'
    }
  }).then(res => res.json())
  .catch(error => console.error('Error:', error))
  .then(response => console.log('Success:', response));

}

