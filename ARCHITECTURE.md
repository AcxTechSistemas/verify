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

- pix_bb: A Package for consulting pix related transactions
- pix_sicoob: A Package for consulting pix related transactions
- flutter_modular: A module-based architecture framework for Flutter
- mobx_codegen: A code generator for MobX state-management library.
- build_runner: A command-line tool for generating code and running tasks in a Dart package
- firebase_auth: A Flutter package for Firebase Authentication integration
- google_sign_in: A Flutter plugin for Google Sign-In integration
- firebase_core: A Flutter plugin providing Firebase Core functionality
- equatable: A Dart package for simple and efficient value equality checks
- result_dart: A Dart package for returning results in a standardized Failure or Success format
- mocktail: A Dart package for creating mock objects during unit tests
- mobx: A state-management library for Dart and Flutter
- flutter_mobx: A Flutter integration of the mobx state-management library
- flutter_svg: A Flutter plugin for rendering SVG files
- google_fonts: A Flutter package for easy integration of Google Fonts
- cloud_firestore: A Flutter plugin for Cloud Firestore integration
- shared_preferences: A Flutter plugin for persisting key-value data on disk
- intl: A Flutter package providing internationalization and localization utilities
- url_launcher: A Flutter plugin for launching URLs
- file_picker: A Flutter plugin for picking files from the filesystem
- dio: A powerful HTTP client for Dart and Flutter
- lottie: A Flutter plugin for displaying and playing Lottie animations
- brasil_fields: A package providing Brazilian-specific formatters and validators
- community_material_icon: A Flutter package providing access to the Community Material Icons font
- flutter_secure_storage: A Flutter plugin for storing sensitive data securely
- encrypt: A library for encrypting and decrypting data in Dart
- crypto: A package containing cryptographic algorithms in Dart
