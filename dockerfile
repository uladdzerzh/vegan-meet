# Use the official Flutter image as the base image
FROM cirrusci/flutter:latest

# Create a non-root user and set the home directory
RUN useradd -m -d /home/flutter flutter

# Change the ownership of the /sdks/flutter directory to the non-root user
RUN chown -R flutter:flutter /sdks/flutter

# Switch to the non-root user
USER flutter

# Set the working directory
WORKDIR /app

# Copy the pubspec.yaml file into the container
COPY --chown=flutter:flutter pubspec.yaml .

# Install the Flutter dependencies
RUN flutter pub get

# Copy the rest of the source code
COPY --chown=flutter:flutter . .

# Build the Flutter app for the web
RUN flutter build web

# Switch back to the root user
USER root

# Expose the port the app will run on
EXPOSE 8080

# Use a lightweight server to serve the app
FROM nginx:alpine

# Copy the built app from the previous stage
COPY --from=0 /app/build/web /usr/share/nginx/html

# Copy the default nginx configuration file
COPY nginx.conf /etc/nginx/conf.d/default.conf
