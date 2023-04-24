# Use the official Flutter image as the base image
FROM cirrusci/flutter:latest

# Set the working directory
WORKDIR /app

# Copy your pubspec.yaml file into the container
COPY pubspec.yaml .

# Install app dependencies
RUN flutter pub get

# Copy the rest of your app's source code
COPY . .

# Build the app for the web platform
RUN flutter build web --release

# Use the official Nginx image as the base image for the runtime container
FROM nginx:stable

# Remove the default Nginx configuration
RUN rm /etc/nginx/conf.d/default.conf

# Add our custom Nginx configuration
COPY nginx.conf /etc/nginx/conf.d

# Copy the built app from the build container
COPY --from=0 /app/build/web /usr/share/nginx/html

# Expose the default Nginx port
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
