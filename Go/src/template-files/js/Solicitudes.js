function conexion() {
  var pestanaAct = document.getElementsByClassName("tab-pane fade in active");
  var cajatxt = pestanaAct[0].getAttribute("id");
  var txt = document.getElementById("text" + cajatxt);
  var obtenerTexto = txt.value;
  console.log(obtenerTexto);

  var url = "http://localhost:3000/api/index";
  var data = { texto: obtenerTexto };

  fetch(url, {
    method: "POST",
    body: JSON.stringify(data),
    headers: {
      "Content-Type": "application/json",
    },
  })
    .then((res) => res.json())
    .catch((error) => console.error("Error:", error))
    .then((response) => console.log("Success:", response));
}

function recuperarArbol() {
  var txt = document.getElementById("salidaTxt");
    
  var url = "http://localhost:3000/api/index"; 

  fetch(url)
    .then(function (response) {
      return response.json();
    })
    .then(function (myJson) {
       var json = JSON.stringify(myJson, null, 1);

       createJSTree(obj);
      txt.innerHTML = json;
    });
}
