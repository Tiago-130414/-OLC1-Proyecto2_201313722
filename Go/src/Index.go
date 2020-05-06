package main

import (
	"fmt"
	"html/template"
	"net/http"
)

func index(w http.ResponseWriter, r *http.Request) {
	template, err := template.ParseFiles("template-files/404.html")
	if err != nil {
		fmt.Fprintf(w, "Pagina no encontrada")
	} else {
		template.Execute(w, nil)
	}
}

func main() {
	http.Handle("/bootstrap/", http.StripPrefix("/bootstrap/", http.FileServer(http.Dir("template-files/bootstrap/"))))
	http.Handle("/css/", http.StripPrefix("/css/", http.FileServer(http.Dir("template-files/css/"))))
	http.Handle("/extensions/", http.StripPrefix("/extensions/", http.FileServer(http.Dir("template-files/extensions/"))))
	http.Handle("/fonts/", http.StripPrefix("/fonts/", http.FileServer(http.Dir("template-files/fonts/"))))
	http.Handle("/img/", http.StripPrefix("/img/", http.FileServer(http.Dir("template-files/img/"))))
	http.Handle("/js/", http.StripPrefix("/js/", http.FileServer(http.Dir("template-files/js/"))))
	http.HandleFunc("/", index)
	fmt.Println("Servidor en puerto 8000")
	http.ListenAndServe(":8000", nil)
}
