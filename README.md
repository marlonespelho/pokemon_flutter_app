# pokemon_app

A Flutter project for show and favorite pokemons from PokeAPI

## Getting Started
## Run the project
- To run the project, you need to have Flutter installed, you can follow the steps at https://docs.flutter.dev/get-started/install.
- After installing Flutter, first run the command `flutter pub get` in the project folder.
- Then run the command `flutter run` to run the project.

## Before Commit Guide
1. Run the command `dart run build_runner build --delete-conflicting-outputs` to generate MobX files;
2. Run the command `dart analyze` to analyze errors and warnings;
3. Run the command `dart format -l 120 .` to format the code;
4. Run the command `flutter test` to check if all tests are passing;
5. Run the command `flutter test integration_test` to check if all integration tests are passing.

# Tests

### Integration Tests
- To run the integration tests, use the following guide:
    - Run the command `flutter test integration_test` in your IDE;

### Unit Tests
- To run the unit tests, run the command `flutter test test/main.dart` in the project folder.