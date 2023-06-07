# Use an official Python runtime as a parent image
FROM python:3.6

# Set the working directory to /app
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app

# Install any needed packages specified in requirements.txt
# RUN pip install --trusted-host pypi.python.org -r requirements.txt
# RUN pip install --no-cache-dir -r requirements.txt
RUN pip install  -r requirements.txt

# Make port 5002 available to the world outside this container
EXPOSE 5002


# Run app.py when the container launches
CMD  ["python", "-m", "flask", "run", "--host=0.0.0.0", "--port=5002"]
