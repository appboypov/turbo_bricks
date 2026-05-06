# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Turbo Bricks is a collection of Mason bricks for rapid Flutter development, focusing on Firebase/Firestore integration and clean architecture patterns. The repository contains reusable templates (bricks) that generate boilerplate code for different parts of a Flutter application.

## Brick Structure

Each brick follows a standard structure:
- `__brick__/` directory contains the templates with Mustache-style variables
- `brick.yaml` contains the brick configuration and input variables

## Common Commands

### Mason CLI Commands

```bash
# Add a brick locally
mason add <brick_name> --path path/to/brick

# Add a brick globally
mason add <brick_name> --path path/to/brick -g

# Generate code using a brick
mason make <brick_name> --<variable1> value1 --<variable2> value2
```

### Brick Management Scripts

```bash
# Add a brick globally from the current directory
./scripts/add_brick.sh

# Update a brick's template files
dart run scripts/update_brick.dart
```

## Code Generation Examples

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

## Architecture Patterns

The bricks generate code that follows a clean architecture pattern with feature-based organization:

1. **API Layer**: Handles direct interactions with Firestore
   - Located in the `/apis` directory of each feature
   - Uses Firebase SDK for CRUD operations

2. **Service Layer**: Business logic abstraction over APIs
   - Collection services manage lists of documents
   - Document services manage single documents
   - Located in the `/services` directory of each feature
   - Uses dependency injection (GetIt) for registration

3. **View Layer**: UI components
   - Follows MVVM pattern with separate views and view models
   - View models registered via GetIt
   - Includes arguments and origin classes for navigation

4. **Router**: Navigation system
   - Feature-specific routers
   - Path-based navigation

## Common Variables

When using any brick, these variables are commonly needed:
- `featureName`: Name of the feature module (e.g., "auth", "profile")
- `collectionName`: Firestore collection name (plural, e.g., "users")
- `collectionObjectName`: DTO class name (singular, e.g., "user")
- `packageName`: Your Flutter app's package name
- `projectKey`: Project identifier for custom components

## Code Conventions

1. All files use consistent section comments for organization:
   ```
   // 📍 LOCATOR
   // 🧩 DEPENDENCIES
   // 🎬 INIT & DISPOSE
   // 👂 LISTENERS
   // ⚡️ OVERRIDES
   // 🎩 STATE
   // 🛠 UTIL
   // 🧲 FETCHERS
   // 🏗️ HELPERS
   // 🪄 MUTATORS
   ```

2. Service classes follow singleton pattern with GetIt registration
3. View models follow factory pattern with GetIt registration
4. DTOs handle JSON serialization/deserialization for Firestore