# Continuous Integration with Jenkins

## Jenkins CI Pipeline for Go Application

The Jenkins CI pipeline in this project is responsible for building, testing, and deploying the Go application. It adheres to the best practices of continuous integration to ensure that changes to the codebase are integrated and tested consistently.

### Pipeline Stages

1. **Checkout:** This stage retrieves the source code from the repository.
2. **Build:** The Go application is compiled using the specified Go version.
3. **Unit Test:** Execution of unit tests to verify the accuracy of the code.
4. **Static Code Analysis:** Static code analysis is conducted using tools like SonarQube to identify code quality issues, bugs, and vulnerabilities.
5. **Docker Build:** Containerization of the Go application by creating a Docker image based on the provided Dockerfile.
6. **Docker Push:** The Docker image is uploaded to a Docker registry, making it ready for deployment.
7. **Scan Image by Trivy:** Scanning the Docker image to identify potential vulnerabilities or issues.
8. **Artifact Archiving:** Storing build artifacts, including Docker images and test reports, for future reference.
9. **Slack Notification:** Notifications about the build status and any identified issues are sent to a designated Slack channel.

### Jenkins CI Pipeline Configuration

To set up the Jenkins CI pipeline for this project, follow these steps:


1. **Install Jenkins using Ansible:** The Jenkins installation playbook is located in the `main` branch. Run the playbook to install Jenkins on your server.

2. **Install Jenkins Plugins using Ansible:** Similarly, the playbook for installing Jenkins plugins is also in the `main` branch. Execute this playbook to install the required plugins.

3. **Create Jenkins Pipeline Job:** Create a new Jenkins pipeline job.

4. **Configure Jenkins Job:** In the job configuration, specify the pipeline script from the Jenkinsfile located in the `jenkins_CI` branch of the repository.

5. **Set Build Triggers:** Configure build triggers, such as repository polling for changes or triggering builds based on specific events.

6. **Set Environment Variables:** Set up essential environment variables, including credentials for Docker registry access or Slack API tokens for notifications.

7. **Save and Run:** Save the job configuration and initiate the pipeline. Jenkins will execute the defined stages in the Jenkinsfile and generate comprehensive logs and reports.

8. **Customize Pipeline:** Tailor the pipeline to suit your specific requirements, such as incorporating additional stages, integrating with external tools, or customizing the build and testing processes.



### Docker Compose for Local Testing

You can use Docker Compose to create a local testing environment for your application:

1. **Install Docker and Docker Compose:**

   Install Docker and Docker Compose on your local machine by following their respective installation guides.

2. **Create Docker Compose Configuration:**

   In your project directory, create a `docker-compose.yml` file to configure your local testing environment.

```yaml
version: '3.9'
services:
  db:
    image: mysql:latest
    command: --default-authentication-plugin=mysql_native_password
    restart: always
    environment:
      MYSQL_ROOT_PASSWORD: root_password
      MYSQL_USER: user
      MYSQL_PASSWORD: password
      MYSQL_DATABASE: internship
    ports:
      - "3306:3306"
    volumes:
      - db_data:/var/lib/mysql
  app:
    build: ./app
    restart: always
    depends_on:
      - db
    environment:
      MYSQL_HOST: db
      MYSQL_PORT: "3306"
      MYSQL_USER: user
      MYSQL_PASS: password
    ports:
      - "9090:9090"
volumes:
  db_data:
```

3. **Run the Application:**

   Open a terminal in the same directory as your docker-compose.yml file and run the following command:
   ```bash
   docker-compose up
   ```
   This command starts the application in a Docker container, and you can access it at 
`http://localhost:9090`

Please note that these instructions provide a high-level overview. Adjust the steps and details based on your specific environment and requirements.

Feel free to use this updated content in your project's `README.md` file.
