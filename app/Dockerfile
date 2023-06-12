# use official Golang image
FROM golang:1.20.5-alpine

# set working directory
WORKDIR /app

# Copy the source code
COPY . .

# Download and install the dependencies
RUN go get -d -v ./...

# Build the Go app
RUN go build -o main .

#EXPOSE the port
EXPOSE 9090

# Run the executable
CMD ["./main"]
