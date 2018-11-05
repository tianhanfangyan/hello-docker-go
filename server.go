package main

import (
	"fmt"
	"log"
	"net/http"
	"strings"
)

func index(w http.ResponseWriter, r *http.Request) {
	r.ParseForm()
	fmt.Println(r.Form)
	fmt.Println("path", r.URL.Path)
	fmt.Println("scheme", r.URL.Scheme)
	fmt.Println(r.Form["url_log"])

	for k, v := range r.Form {
		fmt.Println("key:", k)
		fmt.Println("val:", strings.Join(v, ""))
	}
	fmt.Fprintf(w, "hello docker")

}

func main() {
	http.HandleFunc("/", index)
	err := http.ListenAndServe(":9090", nil)
	if err != nil {
		log.Fatal("listenandserve: ", err)
	} else {
		fmt.Println("starting........")
	}
}
