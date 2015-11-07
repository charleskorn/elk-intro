package main

import (
	"log"
	"math/rand"
	"os"
	"os/signal"
	"sync"
	"time"
)

func main() {
	log.SetFlags(log.LstdFlags | log.Lshortfile | log.LUTC | log.Lmicroseconds)
	log.SetOutput(os.Stdout)
	log.Println("Starting up...")

	go printMessages()

	log.Println("Press Ctrl+C to quit.")
	waitForCtrlC()

	log.Println("Shut down.")
}

func printMessages() {
	c := time.Tick(1 * time.Second)
	for range c {
		log.Printf("Did some cool stuff, the magic number is now %v.\n", rand.Int())
	}
}

func waitForCtrlC() {
	var waitSignal sync.WaitGroup
	waitSignal.Add(1)
	var waitChannel chan os.Signal
	waitChannel = make(chan os.Signal, 1)
	signal.Notify(waitChannel, os.Interrupt)
	go func() {
		<-waitChannel
		waitSignal.Done()
	}()
	waitSignal.Wait()
}
