# UAEUniversities

UAEUniversities is an iOS app that allows users to search for universities by country. The app is built using the VIPER architecture, Swift Package Manager for dependency management, and Realm database for data persistence.

## Features

- **Universities List**: Browse a list of universities by country.
- **University Details**: View detailed information about a selected university.

## Requirements

- iOS 15.0+
- Xcode 14.0+
- Swift 5.0+

## Installation

1. Clone or download the project.
2. Open `UAEUniversities.xcodeproj` in Xcode.
3. Build and run the project.

## Swift Packages

This project is organized as a multi-module Swift package. It consists of the following modules:

- **UniversitiesList**: Contains the user interface and logic for browsing a list of universities.
- **UniversityDetails**: Contains the user interface and logic for viewing detailed information about a university.
- **Domain**: Contains the business entities.
- **NetworkKit**: A Swift package for handling network requests.
- **StorageKit**: A Swift package for data persistence using Realm database.
- **UtilitiesKit**: A Swift package containing utility functions and extensions.

These modules are managed using Swift Package Manager and are included in the project.

## Architecture

The app follows the VIPER architecture:

- **View**: User interface components.
- **Interactor**: Business logic and networking.
- **Presenter**: Mediator between View and Interactor.
- **Entity**: Model objects.
- **Router**: Handles navigation between modules.

## Usage

- **Universities List**: 
  - Browse a list of universities by country.
  - Pull to refresh to update the list.
- **University Details**: 
  - Tap on a university to view its details.
  - Swipe left or right to view the next or previous university.
