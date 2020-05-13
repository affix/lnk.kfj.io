package main

import "time"

func main() {
	for {
		println("Hello World!")
		time.Sleep(10 * time.Second)
	}
}
