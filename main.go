package main

import (
	log "logutil"
	"net/http"

	"github.com/hprose/hprose-golang/rpc"
)

func main() {
	log.InitializeLogger()
	server := rpc.NewHTTPService()

	log.Info("Server has been started!")
	http.ListenAndServe(":7689", server)
}
