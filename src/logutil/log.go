package logutil

import (
	"fmt"
	"os"
)

var buf *string

var file *os.File

var last_len *int

func Info(event string) {
	var e = "INFO: " + event
	fmt.Println(e)

	*buf += e + "\r\n"

	go WriteAway()
}

func Call(event string) {
	var e = "CALL: " + event
	fmt.Println(e)

	*buf += e + "\r\n"
	go WriteAway()
}

func GenerateNewLogData() {
	buf = new(string)
	last_len = new(int)
}

func InitializeLogger() {
	GenerateNewLogData()

	f, err := os.Create("log.txt")
	if err != nil {
		panic(err)
	}

	file = f
}

func WriteAway() {
	_, err := file.WriteString(*buf)
	if err != nil {
		panic(err)
	}
	*last_len = len(*buf)
}
