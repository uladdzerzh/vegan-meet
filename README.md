# Vegan Meet

Vegan Meet is a Flutter app that helps vegans, vegetarians, and other plant-based dieters connect with each other. Users can register, sign in, and view a list of other registered users.

## Features

- User registration and authentication using Firebase Auth
- User profiles stored in Cloud Firestore
- Display a list of all registered users

## Build and run via Docker

Execute the following commands in the terminal:

$ docker build -t vegan_meet .

$ docker run --rm -p 8080:80 vegan_meet

App will be available at http://localhost:8080
