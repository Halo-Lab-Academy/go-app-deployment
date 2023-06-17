# Alpine GoLang Docker Image
FROM golang:1.20.2-alpine3.17

# Set the working directory inside the container
WORKDIR /app

# Copy the Go modules and the source code to the container
COPY app/* .

# Build the Go application inside the container
RUN go build -o main .

# Define the command to run when the container starts
CMD ["./main"]