# Turbo Bricks 🧱

[![Powered by Mason](https://img.shields.io/endpoint?url=https%3A%2F%2Ftinyurl.com%2Fmason-badge)](https://github.com/felangel/mason)

A collection of Mason bricks for rapid Flutter development, focusing on Firebase/Firestore integration and clean architecture patterns.

## Available Bricks

- **api**: Generates API layer classes for Firestore interactions
- **brick**: Template for creating new Mason bricks within this collection
- **collection-service**: Generates a service class for handling Firestore collections with built-in GetIt registration
- **core**: Core project setup including base classes and utilities
- **document-service**: Generates a service class for handling Firestore documents with built-in GetIt registration
- **router**: Router configuration and setup
- **routing**: Route generation and navigation utilities
- **scripts**: Development scripts and utilities
- **service**: Base service layer generation
- **view**: View/UI component generation

## Installation

```bash
# Activate Mason
dart pub global activate mason_cli

# Add bricks locally
mason add <brick_name> --path path/to/brick

# Or add from git repository
mason add <brick_name> --git-url https://github.com/your-username/turbo_bricks --git-path <brick_name>
```

## Usage Examples

### Collection Service Generation
```bash
mason make collection-service \
  --featureName auth \
  --collectionName users \
  --collectionObjectName user
```

### Document Service Generation
```bash
mason make document-service \
  --featureName profile \
  --collectionName profiles \
  --collectionObjectName profile
```

### View Generation
```bash
mason make view \
  --name login \
  --featureName auth
```

## Brick Variables

Each brick requires specific variables:

- `featureName`: Feature module name (e.g., "auth", "profile")
- `collectionName`: Firestore collection name (plural, e.g., "users")
- `collectionObjectName`: DTO class name without suffix (singular, e.g., "user")
- `name`: Component name for views and other generators

## Project Structure

Generated code follows a clean architecture pattern with feature-based organization:

```
lib/
  ├── core/
  │   └── enums/
  │       └── firestore_collection.dart
  └── features/
      └── {feature_name}/
          ├── services/
          │   └── {collection_name}_service.dart
          └── views/
              └── {view_name}_view.dart
```

## Contributing

This repository is under active development. Feel free to open issues or submit pull requests.

## Changelog

See [CHANGELOG.md](CHANGELOG.md) for a list of all notable changes.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
