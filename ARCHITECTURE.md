# Architecture

# Goal

The main purpose of this document is to organize the software development process.

# Initial Rules, Threshold and Analysis

Points to consider before introducing a new feature:

- This project must have a minimum test coverage of at least 70%.
- All design patterns used in the project must be listed in the “Design Patterns” section of this document, otherwise it will be considered an erroneous implementation.
- New packages and plugins can only be used in projects after evaluation and approval by the entire team responsible for the project.
- Updates to the Domain Model can only be accepted if first added to this document and approved by everyone involved in the project.
- It is not allowed to have a concrete class as a dependency of a layer. Cohesion will only be accepted with abstract classes or interfaces. With the exception of the Store.
- Each layer should have only one responsibility.

# Design Patterns

- Repository Pattern: For external API access.
- Service Pattern: To isolate code snippets with other responsibilities.
- Dependency Injection: Resolve class dependencies.
- Adapter: Convert one object into another.
- Result: Work with multiple returns.

# External packages

- flutter_modular: A module-based architecture framework for Flutter
- firebase_auth: A Flutter package that provides Firebase Authentication integration
- google_sign_in: A Flutter plugin for Google Sign-In integration
- firebase_core: A Flutter plugin that provides Firebase Core functionality
- equatable: A Dart package for simple and efficient value equality checks
- result_dart: A Dart package for returning results in a standardized Failure or Success format
- mocktail: A Dart package for creating mock objects during unit tests
- mobx: A state-management library for Dart and Flutter
- flutter_mobx: A Flutter integration of the mobx state-management library
- flutter_svg: A Flutter plugin for rendering SVG files
- google_fonts: A Flutter package for easy integration of Google Fonts
- build_runner: A command-line tool for generating code and running tasks in a Dart package
