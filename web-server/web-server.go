package main

import (
	"fmt"
	"math"
	"math/rand"
	"net/http"
	"time"
	log "github.com/Sirupsen/logrus"
)

func main() {
	address := ":8080"

	log.SetFormatter(&log.JSONFormatter{})
	log.Info("Listening on " + address)

	http.HandleFunc("/", wrapRequestWithLogging(requestHandler))

	log.Fatal(http.ListenAndServe(address, nil))
}

func requestHandler(writer http.ResponseWriter, request *http.Request) {
	possibleResponses := []int {
		http.StatusInternalServerError,
		http.StatusOK,
		http.StatusOK,
		http.StatusOK,
		http.StatusOK,
		http.StatusTeapot,
		http.StatusBadRequest,
		http.StatusForbidden,
		http.StatusInternalServerError,
		http.StatusInternalServerError,
	}

	randomResponseIndex := rand.Intn(len(possibleResponses))

	responseTimeSD := float64(5 * randomResponseIndex)
	responseTimeMean := float64((10 * randomResponseIndex) + 30)
	simulatedProcessingTime := math.Max(0, rand.NormFloat64() * responseTimeSD + responseTimeMean)

	time.Sleep(time.Duration(simulatedProcessingTime) * time.Millisecond)

	if (request.URL.Path != "/") {
		writer.WriteHeader(http.StatusNotFound)
		return
	}

	responseCode := possibleResponses[randomResponseIndex]

	writer.WriteHeader(responseCode)
	fmt.Fprintf(writer, "Hello world, your response code today is HTTP %v!", responseCode)
}

func wrapRequestWithLogging(handler http.HandlerFunc) http.HandlerFunc {
	return func(writer http.ResponseWriter, request *http.Request) {
		start := time.Now()

		wrapper := NewResponseWriterWrapper(writer)

		handler(wrapper, request)

		elapsed := time.Since(start)

		log.WithFields(log.Fields{
			"httpResponseTimeMilliseconds": elapsed / time.Millisecond,
			"httpResponseCode": wrapper.Status,
			"httpRequestUrl": request.URL.String(),
			"httpRequestMethod": request.Method,
			"httpRequestRemoteAdresss": request.RemoteAddr,
			"httpRequestHost": request.Host,
			"httpRequestReferer": request.Referer(),
			"httpRequestUserAgent": request.UserAgent(),
		}).Info("Received request")
	}
}


type ResponseWriterWrapper struct {
	Status int
	http.ResponseWriter
}

func NewResponseWriterWrapper(writer http.ResponseWriter) *ResponseWriterWrapper {
	return &ResponseWriterWrapper{200, writer}
}

func (w *ResponseWriterWrapper) WriteHeader(statusCode int) {
	w.Status = statusCode
	w.ResponseWriter.WriteHeader(statusCode)
}
