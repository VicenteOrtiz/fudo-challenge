# Fudo Challenge App

A Flutter application demonstrating clean architecture, BLoC pattern, and integration with a RESTful API. This app allows users to view posts, add new posts, and includes authentication functionality.

## Features

- **User Authentication**: Login screen with email and password.
- **Posts Listing**: View a list of posts fetched from JSONPlaceholder API.
- **Add New Post**: Create and submit new posts to the API.
- **Offline Support**: Caching of posts for offline viewing.
- **Search Functionality**: Search through posts by title or user.
- **Minimalist UI**: Clean and simple user interface.

## Architecture

This app follows clean architecture principles and uses the BLoC (Business Logic Component) pattern for state management. Key components include:

- **Data Layer**: 
  - `PostsDataSource`: Interface for data operations.
  - `PostsDataSourceImpl`: Implementation of data source using Dio for API calls.
  - `PostsRepository`: Mediates between the data source and the domain layer.

- **Domain Layer**:
  - `Post`: Model representing a post.

- **Presentation Layer**:
  - `PostsBloc`: Manages the state of posts.
  - `AuthBloc`: Handles authentication state.
  - Screens: `LoginPage`, `PostsPage`, `AddPostPage`.

## Setup and Running

### Prerequisites

- Flutter SDK (version 3.3.0 or later)
- Dart SDK (version 2.18 or later)
- An IDE (e.g., Android Studio, VS Code)

### Installation

1. Clone the repository:
   ```
   git clone https://github.com/VicenteOrtiz/fudo-challenge.git
   ```

2. Navigate to the project directory:
   ```
   cd fudo_challenge
   ```

3. Install dependencies:
   ```
   flutter pub get
   ```

### Running the App

1. Ensure you have a device connected (physical device or emulator).

2. Run the app:
   ```
   flutter run
   ```

## Dependencies

- `flutter_bloc`: State management
- `dio`: HTTP client for API requests
- `shared_preferences`: Local storage for caching
- `equatable`: Value equality

## API

This app uses the [JSONPlaceholder](https://jsonplaceholder.typicode.com/) API for fetching and posting data.


## License

This project is open source and available under the [MIT License](LICENSE).