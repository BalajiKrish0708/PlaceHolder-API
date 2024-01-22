# JSONPlaceholder API Example Flutter

This Flutter project demonstrates how to use the JSONPlaceholder API with the BLoC pattern. It includes examples of fetching posts, comments, and post details.

## Overview

The project uses the `flutter_bloc` package to manage the state of the application. It includes the following features:

- Fetching posts from the JSONPlaceholder API.
- Displaying a list of posts.
- Fetching comments for a selected post.
- Displaying details for a selected post.

## Project Structure

- `lib/`: Contains the Dart source code for the Flutter project.
  - `bloc/`: Contains the BLoC classes for managing state.
  - `models/`: Contains Dart classes representing the data models (Post, Comment, PostDetails).
  - `screens/`: Contains the Flutter screens (PostList, PostDetails).
  

## Dependencies

- `flutter_bloc`: For implementing the BLoC pattern.
- `http`: For making HTTP requests.
- `connectivity`: For checking network connectivity.

## Getting Started

1. Clone the repository:

   ```bash
   git clone https://github.com/BalajiKrish0708/PlaceHolder-API.git

2. Navigate to the project directory:

    ```bash
   cd jsonplaceholder-api-flutter

3. Install dependencies:

    ```bash
    flutter pub get

4. Run the application:

   ```bash
    flutter run

    

