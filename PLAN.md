# Turbo Bricks Update Plan

Audit of each brick against current conventions in `turbo_modules` and `deappspecialist`. Each section lists what's broken/outdated and what the updated version should look like.

---

## 1. `view` brick

### Current state
- ViewModel extends `BaseViewModel<OriginArguments<...>>` from `package:veto`
- View uses `ViewModelBuilder` from `package:veto`
- Uses `OriginArguments`, `Origin` enum, and separate `Arguments` class
- Arguments extend a local `ViewArguments` abstract with `toMap()`
- View references project-specific widgets (`EmojiHeader`, `Emoji.unicorn`) hardcoded in template
- Import paths reference `features/{{featureName}}/views/` structure
- Uses `loglytics` mixin on ViewModel
- ViewModel has no constructor injection — uses private constructor + static `locate`
- `brick.yaml` lists `projectKey`, `viewName`, `packageName` but not `featureName` (yet template uses it)

### Required changes
- **ViewModel base class**: Change from `BaseViewModel` (veto) to `TBaseViewModel` (turbo_mvvm). Drop generic `OriginArguments` wrapper.
- **ViewModel naming**: Rename from `{{viewName}}ViewModel` to `{{viewName}}Model`.
- **View builder**: Change from `ViewModelBuilder` (veto) to `TViewModelBuilder` (turbo_mvvm).
- **View body**: Use `TPage` widget (with `isInitialised`, `model`, `children` params) instead of hardcoded `{{projectKey}}Scaffold`/`{{projectKey}}AppBar`/`{{projectKey}}ScrollView`.
- **Constructor injection**: ViewModels now receive dependencies via constructor, not via static locates inside the class. `registerFactory` wires the dependencies.
- **Arguments pattern (updated, not dropped)**: Arguments still exist but now extend `IViewArguments` from `turbo_modules/routing/abstracts/i_view_arguments.dart` with `toJson()` (not `toMap()`). Use `@JsonSerializable` with `fromJson`/`toJson`. Origin is a field inside the arguments class, not a separate enum file.
- **View accepts arguments**: View constructor takes `required this.arguments` and passes via `argumentBuilder: () => arguments` to `TViewModelBuilder`.
- **Drop Loglytics mixin**: Replace with `Turbolytics` mixin from `package:turbolytics`.
- **Remove hardcoded project widgets**: No `EmojiHeader`, `Emoji.unicorn`, etc.
- **Imports**: Use `turbo_modules` package imports (not `package:{{packageName}}`).
- **Fix brick.yaml**: Add `featureName` variable. Remove `projectKey`. Remove `packageName`.
- **Section comments**: Keep emoji section comments (already correct convention).
- **initialise/dispose signatures**: `initialise({bool doSetInitialised = true})` and `dispose()` both call `super` with `await`.

### Target template (view)
```dart
import 'package:flutter/material.dart';
import 'package:turbo_mvvm/data/abstracts/t_base_view_model.dart';

import '{{viewName.snakeCase()}}_model.dart';

class {{viewName.pascalCase()}} extends StatelessWidget {
  const {{viewName.pascalCase()}}({
    required this.arguments,
    super.key,
  });

  final {{viewName.pascalCase()}}Arguments arguments;

  @override
  Widget build(BuildContext context) => TViewModelBuilder<{{viewName.pascalCase()}}Model>(
    argumentBuilder: () => arguments,
    builder: (context, model, isInitialised, child) => TPage(
      isInitialised: isInitialised,
      model: model,
      children: const [
        Center(
          child: Text('{{viewName.pascalCase()}}'),
        ),
      ],
    ),
    viewModelBuilder: () => {{viewName.pascalCase()}}Model.locate,
  );
}
```

### Target template (view arguments)
```dart
import 'package:json_annotation/json_annotation.dart';
import 'package:turbo_modules/routing/abstracts/i_view_arguments.dart';

part '{{viewName.snakeCase()}}_arguments.g.dart';

@JsonSerializable(
  includeIfNull: true,
  explicitToJson: true,
)
class {{viewName.pascalCase()}}Arguments extends IViewArguments {
  {{viewName.pascalCase()}}Arguments({
    required this.origin,
  });

  final {{viewName.pascalCase()}}Origin origin;

  factory {{viewName.pascalCase()}}Arguments.fromJson(Map<String, dynamic> json) => _${{viewName.pascalCase()}}ArgumentsFromJson(json);
  @override
  Map<String, dynamic> toJson() => _${{viewName.pascalCase()}}ArgumentsToJson(this);
}
```

### Files generated
- `{{viewName.snakeCase()}}.dart` (view)
- `{{viewName.snakeCase()}}_model.dart` (view model)
- `{{viewName.snakeCase()}}_arguments.dart` (arguments with origin field)

### Files removed
- `{{viewName.snakeCase()}}_origin.dart` (origin is now a field in arguments)

---

## 2. `view-model-widget` brick (NEW)

New brick for generating child widgets that need model access.

### Target template
```dart
class {{widgetName.pascalCase()}} extends ViewModelWidget<{{parentModel.pascalCase()}}Model> {
  const {{widgetName.pascalCase()}}({super.key}) : super(isReactive: false);

  @override
  Widget build(BuildContext context, {{parentModel.pascalCase()}}Model model) {
  }
}
```

---

## 3. `router` brick

### Current state
- Extends `BaseNavigation` (local abstract)
- References `NavigationTab` enum (local)
- No constructor parameters — stateless with static locate
- Has a hardcoded `go{{featureName}}View` method with web bug workaround
- Imports from `core/abstracts/base_navigation.dart` and `core/enums/navigation_tab.dart`

### Required changes
- **Base class**: Change from `BaseNavigation` to `TRouter` from `turbo_modules/routing/abstracts/t_router.dart`.
- **Constructor**: `TRouter` requires `initialRoute`, `appRoutingService`, `navigationTabService` via `super`. Follow `HomeRouter` pattern with constructor injection.
- **Locator pattern**: Add `lazyLocate` getter (`() => GetIt.I.get()`), `locate` getter, and `registerFactory` that wires `initialRoute`, `AppRoutingService.locate`, `NavigationTabService.locate`.
- **Drop hardcoded navigation method**: Remove the `go{{featureName}}View` method with web bug workaround. `TRouter` already provides `go`, `push`, `goRoot`, etc.
- **Drop old imports**: Remove references to `BaseNavigation`, local `NavigationTab`. Use turbo_modules imports.
- **Section comments**: Already matches convention. Keep as-is.

---

## 4. `service` brick

### Current state
- Standalone service class with manual `Completer`-based `isReady` pattern
- Multiple registration statics offered as menu (`registerLazySingleton`, `registerFactory`, `registerSingleton`, `registerFactoryParam`) with TODO to choose
- Auto-calls `initialise()` from constructor
- Uses `completer_extension` from local package
- Mixes `Loglytics`

### Required changes
- **Remove Completer/isReady boilerplate**: Current services don't use this pattern.
- **Pick one registration style**: Generate `registerLazySingleton` only. Remove `registerFactory`, `registerSingleton`, `registerFactoryParam`.
- **Drop auto-init from constructor**: Initialization happens externally.
- **Replace Loglytics**: Use `Turbolytics` mixin from `package:turbolytics`.
- **Constructor injection**: Services receive dependencies through constructor params wired in `registerLazySingleton`.
- **Remove completer_extension import**: Not used in current codebase.
- **Simplify**: Clean service shell with locator section, dependencies section, and section comments.

---

## 5. `collection-service` brick

### Current state
- Extends `TurboCollectionService<T, Api>`
- Takes `Api.locate` in super constructor
- Has unimplemented `stream` getter throwing `UnimplementedError`
- Missing imports (no import statements at all)
- References `User` from firebase_auth without import

### Required changes
- **Base class**: Change to `TCollectionService<Dto, Model>` from `turbo_firestore_api`.
- **Constructor**: Accept `collection`, `modelBuilder`, and optional params (`apiBuilder`, `defaultValue`, `initialValue`, `streamBuilder`, `initialiseStream`, `firestoreCacheService`, `initialSortFilteredListsMap`, `modelDocsBuilder`) via super forwarding.
- **Registration**: `registerLazySingleton` wires `collection`, `modelBuilder`, `initialiseStream`. Include `dispose` callback.
- **Remove unimplemented stream**: Drop the throwing getter.
- **Add proper imports**.

### Target template
```dart
class {{collectionName.pascalCase()}}Service extends TCollectionService<{{collectionObjectName.pascalCase()}}Dto, {{collectionObjectName.pascalCase()}}> {
  {{collectionName.pascalCase()}}Service({
    required super.collection,
    required super.modelBuilder,
    super.apiBuilder,
    super.defaultValue,
    super.initialValue,
    super.streamBuilder,
    super.initialiseStream,
    super.firestoreCacheService,
    super.initialSortFilteredListsMap,
    super.modelDocsBuilder,
  });

  // 📍 LOCATOR ------------------------------------------------------------------------------- \\

  static {{collectionName.pascalCase()}}Service get locate => GetIt.I.get();
  static void registerLazySingleton() => GetIt.I.registerLazySingleton(
    () => {{collectionName.pascalCase()}}Service(
      collection: ,
      modelBuilder: ,
      initialiseStream: ,
    ),
    dispose: (param) async => await param.dispose(),
  );

  // 🧩 DEPENDENCIES -------------------------------------------------------------------------- \\
  // 🎬 INIT & DISPOSE ------------------------------------------------------------------------ \\
  // 👂 LISTENERS ----------------------------------------------------------------------------- \\
  // ⚡️ OVERRIDES ----------------------------------------------------------------------------- \\
  // 🎩 STATE --------------------------------------------------------------------------------- \\
  // 🛠 UTIL ---------------------------------------------------------------------------------- \\
  // 🧲 FETCHERS ------------------------------------------------------------------------------ \\
  // 🏗️ HELPERS ------------------------------------------------------------------------------- \\
  // 🪄 MUTATORS ------------------------------------------------------------------------------ \\
}
```

---

## 6. `document-service` brick

### Current state
- Multi-file brick generating: api, dto, service, firestore_collection enum, locator
- Service extends `TurboDocumentService<Dto, Api>`
- Api extends `{{projectKey}}Api<Dto>` (local abstract)
- Dto extends `TurboWriteableId<String>` with `@JsonSerializable`
- FirestoreCollection is a plain enum with manual `toJson`/`fromJson`/`path` switch statements
- Locator uses `part of 'app_setup.dart'` pattern

### Required changes
- **Simplify to single-file brick**: Generate only the service class. Dto and api are separate bricks now.
- **Base class**: Change to `TDocService<Dto, Model>` from `turbo_firestore_api`.
- **Constructor**: Accept `defaultValue`, `modelBuilder`, `collection`, and optional params (`onMissingRemoteValue`, `initialValue`, `afterLocalNotifyUpdate`, `apiBuilder`, `beforeLocalNotifyUpdate`, `firestoreCacheService`, `initialiseStream`, `streamBuilder`) via super forwarding.
- **Registration**: `registerLazySingleton` wires `defaultValue`, `onMissingRemoteValue`, `modelBuilder`, `collection`.
- **Remove**: api file, firestore_collection enum file, locator file from this brick's output.

### Target template
```dart
class {{collectionObjectName.pascalCase()}}Service extends TDocService<{{collectionObjectName.pascalCase()}}Dto, {{collectionObjectName.pascalCase()}}> {
  {{collectionObjectName.pascalCase()}}Service({
    required super.defaultValue,
    required super.modelBuilder,
    required super.collection,
    super.onMissingRemoteValue,
    super.initialValue,
    super.afterLocalNotifyUpdate,
    super.apiBuilder,
    super.beforeLocalNotifyUpdate,
    super.firestoreCacheService,
    super.initialiseStream,
    super.streamBuilder,
  });

  // 📍 LOCATOR ------------------------------------------------------------------------------- \\

  static {{collectionObjectName.pascalCase()}}Service get locate => GetIt.I.get();
  static void registerLazySingleton() => GetIt.I.registerLazySingleton(
    () => {{collectionObjectName.pascalCase()}}Service(
      defaultValue: ,
      onMissingRemoteValue: ,
      modelBuilder: ,
      collection: ,
    ),
  );

  // 🧩 DEPENDENCIES -------------------------------------------------------------------------- \\
  // 🎬 INIT & DISPOSE ------------------------------------------------------------------------ \\
  // 👂 LISTENERS ----------------------------------------------------------------------------- \\
  // ⚡️ OVERRIDES ----------------------------------------------------------------------------- \\
  // 🎩 STATE --------------------------------------------------------------------------------- \\
  // 🛠 UTIL ---------------------------------------------------------------------------------- \\
  // 🧲 FETCHERS ------------------------------------------------------------------------------ \\
  // 🏗️ HELPERS ------------------------------------------------------------------------------- \\
  // 🪄 MUTATORS ------------------------------------------------------------------------------ \\
}
```

---

## 7. `dto` brick (NEW — extracted from document-service)

New standalone brick for generating DTOs.

### Target template
```dart
import 'package:json_annotation/json_annotation.dart';
import 'package:turbo_firestore_api/models/t_vars.dart';
import 'package:turbo_modules/firebase/converters/timestamp_converter.dart';
import 'package:turbo_serializable/abstracts/t_writeable_id.dart';

part '{{dtoName.snakeCase()}}_dto.g.dart';

@JsonSerializable(
  includeIfNull: true,
  explicitToJson: true,
)
class {{dtoName.pascalCase()}}Dto extends TWriteableId {
  {{dtoName.pascalCase()}}Dto({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
  });

  factory {{dtoName.pascalCase()}}Dto.defaultLocalValue(TVars vars) => {{dtoName.pascalCase()}}Dto(
    id: vars.defaultIdValue,
    createdAt: vars.now,
    updatedAt: vars.now,
  );

  factory {{dtoName.pascalCase()}}Dto.defaultRemoteValue(TVars vars) => {{dtoName.pascalCase()}}Dto(
    id: vars.userId!,
    createdAt: vars.now,
    updatedAt: vars.now,
  );

  @override
  final String id;
  @TimestampConverter()
  final DateTime createdAt;
  @TimestampConverter()
  final DateTime updatedAt;

  static const fromJsonFactory = _${{dtoName.pascalCase()}}DtoFromJson;
  factory {{dtoName.pascalCase()}}Dto.fromJson(Map<String, dynamic> json) => _${{dtoName.pascalCase()}}DtoFromJson(json);
  static const toJsonFactory = _${{dtoName.pascalCase()}}DtoToJson;
  @override
  Map<String, dynamic> toJson() => _${{dtoName.pascalCase()}}DtoToJson(this);

  // TODO(appboy): Add copyWith
  // TODO(appboy): Add toString
}
```

### brick.yaml vars
- `dtoName`: Name of the DTO without "Dto" suffix (e.g. "user" -> `UserDto`)

---

## 8. `api` brick

### Current state
- Abstract class extending `TurboFirestoreApi<T>`
- Takes `FirestoreCollection` enum, path function, and various config from the enum
- References local `FirestoreCollection` enum

### Required changes
- **Keep but update**: Brick stays as a Firestore API generator.
- **Update base class and pattern**: Needs to match current `TFirestoreCollection<T>` config-based architecture from `turbo_firestore_api`.
- **Details TBD**: Need to examine `turbo_firestore_api` package to determine exact current API class pattern. The `TFirestoreCollection` config object may have replaced the need for a custom abstract API base class entirely — in which case this brick generates a concrete API class that wraps `TFirestoreCollection`.

---

## 9. `brick` brick (meta-brick for creating new bricks)

### Current state
- Creates a new brick scaffold with `brick.yaml`, `add_brick.sh`, empty `__brick__/` template
- brick.yaml descriptions say "ultra wide turbo"
- add_brick.sh has global install commented out

### Required changes
- **Rename references**: Change all "ultra wide turbo" to "turbo" in descriptions.
- **add_brick.sh**: Decide whether global install should be enabled or stay commented.
- **Minimal changes needed**: Branding update only.

---

## 10. `bricks` brick (init-all meta-brick)

### Current state
- Generates a `mason.yaml` + inner `brick` template
- Description says "One brick init to init them all"

### Required changes
- **Rename references**: Change "ultra wide turbo" references in inner templates.
- **Minimal changes needed**: Structural meta-brick.

---

## 11. `scripts` brick

### Current state
- Collection of shell scripts for common Flutter/Firebase dev tasks
- `build_feature_dir.sh` creates 20+ subdirectories per feature
- Uses `flutter pub run build_runner` (deprecated command)
- `dart_fix.sh` uses `flutter pub run build_runner` and custom line length (100) with indent 0

### Required changes
- **build_feature_dir.sh**: Update subdirectory list to match turbo_modules: `abstracts`, `apis`, `constants`, `dtos`, `enums`, `extensions`, `forms`, `globals`, `mixins`, `models`, `services`, `views`, `widgets`. Remove unused ones.
- **Deprecated commands**: Replace `flutter pub run build_runner` with `dart run build_runner` throughout.
- **dart_fix.sh**: Review line length/indent settings.

---

## 12. `constants` brick

### Current state
- Only has `brick.yaml`, no visible `__brick__/` templates
- Description says "ultra wide turbo"

### Required changes
- **Rename references**: Update description.
- **Audit**: Check if stub. If so, remove.

---

## Cleanup

- **Delete `temp/` directory entirely.**

---

## Cross-cutting concerns

### Branding
- All `brick.yaml` descriptions: "ultra wide turbo" -> "turbo".
- `README.md`: "Ultra Wide Turbo Bricks" -> "Turbo Bricks".
- `CLAUDE.md`: "Ultra Wide Turbo Bricks" -> "Turbo Bricks".
- `CHANGELOG.md`: "Ultra Wide Turbo Bricks" -> "Turbo Bricks".
- `LICENSE`: "Ultra Wide Turbo Bricks Contributors" -> "Turbo Bricks Contributors".
- `mason-lock.json` / `.mason/bricks.json`: auto-update on next `mason get`.

### Package dependencies changed
| Old | New |
|-----|-----|
| `package:veto` | `package:turbo_mvvm` |
| `package:loglytics` | `package:turbolytics` |
| `BaseViewModel` / `ViewModelBuilder` | `TBaseViewModel` / `TViewModelBuilder` |
| `TurboWriteableId<String>` | `TWriteableId` (from `turbo_serializable`) |
| `TurboFirestoreApi` (direct) | `TFirestoreCollection<T>` (config object) |
| `TurboDocumentService` | `TDocService` |
| `TurboCollectionService` | `TCollectionService` |
| `BaseNavigation` (local) | `TRouter` (from `turbo_modules`) |
| `ViewArguments` with `toMap()` | `IViewArguments` with `toJson()` + `@JsonSerializable` |
| `OriginArguments` wrapper | Origin as field inside Arguments class |
| `{{viewName}}ViewModel` | `{{viewName}}Model` |

### Section comments convention (unchanged)
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

### Locator pattern (updated)
Old: Static methods directly on each class, registered piecemeal.
New: Central `TLocatorService` subclass with categorized `register*()` overrides. Individual classes still have static `locate`/`lazyLocate`/`registerLazySingleton` but wiring happens centrally.

### File structure convention (updated)
Old: `lib/features/{feature}/views/`, `lib/features/{feature}/services/`
New: `lib/{feature}/views/{viewName}/`, `lib/{feature}/services/` (no `features/` parent)

### Imports convention
All brick templates import from `turbo_modules` package (not `package:{{packageName}}`).

---

## Priority order

1. **Cross-cutting branding + delete temp/** — quick win
2. **view** — most impactful, completely different patterns
3. **dto** (new brick) — extracted from document-service
4. **document-service** — simplified to single service file
5. **collection-service** — updated to `TCollectionService`
6. **router** — completely different base class
7. **service** — significantly simplified
8. **api** — update to current patterns
9. **view-model-widget** (new brick) — small addition
10. **scripts** — update deprecated commands and directory structure
11. **brick / bricks** — branding only
12. **constants** — audit and update or remove
