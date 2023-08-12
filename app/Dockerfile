# Stage 1: Build the Go binary
FROM golang:1.20.5-alpine AS builder

# Set working directory
WORKDIR /app

# Copy the source code
COPY . .

# Download and install the dependencies
RUN go get -d -v ./...

# Build the Go app
RUN go build -o main .

# Stage 2: Create a minimal runtime image
FROM alpine:latest

# Set working directory
WORKDIR /app

# Copy the built binary from the previous stage
COPY --from=builder /app/main .

# EXPOSE the port
EXPOSE 9090

# Run Containers as Non-Root Users
RUN addgroup dev && adduser -D -G dev go_U

USER go_U

# Run the executable
CMD ["./main"]