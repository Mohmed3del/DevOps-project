# Specify the base image for the go app.
FROM golang:1.20
# Specify that we now need to execute any commands in this directory.
WORKDIR /app
# Copy everything from this project into the filesystem of the container.
COPY . .
# Obtain the package needed to run redis commands. Alternatively use GO Modules.
RUN go get -u app/
# Compile the binary exe for our app.
RUN go build -o main .
# Start the application.
CMD ["./main"]