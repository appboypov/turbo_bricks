<user_instructions date="2026-05-06T09:42">
<mcp_metadata>
window_id: 1
workspace_instance: 1
workspace_name: 📲 De App Specialist

tab_id: 665B82A8-F320-4337-A77A-97C8FE6A241B
tab_name: T1

context_binding_guide:
  Before making tool calls to RepoPrompt, bind to this context:
  1. Bind to the correct window:
     tool: bind_context
     args: {"op": "bind", "window_id": 1}
  2. Bind to this tab (recommended for stable context):
     tool: bind_context
     args: {"op": "bind", "context_id": "665B82A8-F320-4337-A77A-97C8FE6A241B"}
</mcp_metadata>

# Task: Cross-cutting branding update + temp/ cleanup

## Original request
Rename all "Ultra Wide Turbo Bricks" / "ultra wide turbo" / "ultra_wide_turbo_bricks" branding to "Turbo Bricks" / "turbo" / "turbo_bricks" across the entire repo. Delete the `temp/` directory. Update TODO author tags from old naming.

## Description
The repository was recently renamed from `ultra_wide_turbo_bricks` to `turbo_bricks` (GitHub repo already renamed, git remote already updated). All internal references to the old name must be updated to match. The `temp/` directory is empty and should be removed.

## Context for implementing agent
This is a Mason bricks repository at `/Users/codaveto/Repos/turbo_bricks`. It contains ~10 brick templates that generate Flutter boilerplate code. The repo was renamed but internal file content still references the old name everywhere.

The RepoPrompt selection shows reference files from `turbo_modules` and `deappspecialist` — these demonstrate current naming conventions (`t_` prefix, `Turbo` branding, `appboy` as TODO author). Use these as authoritative naming references.

## Goals
- Replace all old branding with new branding across every file in the repo.
- Delete the `temp/` directory.
- Update `mason-lock.json` and `.mason/bricks.json` paths from `ultra_wide_turbo_bricks` to `turbo_bricks`.
- Update TODO author tags.

## Non-goals
- Do not update any brick template logic, patterns, or architecture. This task is branding-only.
- Do not restructure any brick directories.
- Do not update package imports or dependencies.
- Do not modify PLAN.md.

## Branding replacement map

| Context | Old value | New value |
|---------|-----------|-----------|
| Prose / titles | Ultra Wide Turbo Bricks | Turbo Bricks |
| brick.yaml descriptions | "An ultra wide turbo X brick" | "A turbo X brick" |
| brick.yaml descriptions | "One ultra wide turbo brick to rule them all" | "One turbo brick to rule them all" |
| brick.yaml descriptions | "Ultra wide turbo scripts brick" | "Turbo scripts brick" |
| brick.yaml var descriptions | "e.g. ultra_wide_turbo_bricks" | "e.g. turbo_bricks" |
| Package name examples | `ultra_wide_turbo_bricks` | `turbo_bricks` |
| Paths in lock files | `/Users/codaveto/Repos/ultra_wide_turbo_bricks/` | `/Users/codaveto/Repos/turbo_bricks/` |
| Git URLs | `ultra_wide_turbo_bricks` | `turbo_bricks` |
| LICENSE copyright | "Ultra Wide Turbo Bricks Contributors" | "Turbo Bricks Contributors" |
| TODO authors | `ultrawideturbodev` | `appboy` |
| TODO authors | `turbodev` | `appboy` |

## Exhaustive file list (every file with old branding)

### brick.yaml files (descriptions + var descriptions)
- `api/brick.yaml` (lines 2, 9)
- `brick/brick.yaml` (line 2)
- `brick/__brick__/{{brickName.paramCase()}}/brick.yaml` (lines 2, 9)
- `bricks/__brick__/bricks/brick/brick.yaml` (line 9)
- `collection-service/brick.yaml` (line 2)
- `constants/brick.yaml` (line 2)
- `document-service/brick.yaml` (line 2)
- `router/brick.yaml` (lines 2, 12)
- `scripts/brick.yaml` (line 2)
- `service/brick.yaml` (line 2)
- `view/brick.yaml` (lines 2, 15)

### Documentation files
- `README.md` (lines 1, 30)
- `CLAUDE.md` (line 7)
- `CHANGELOG.md` (line 20)
- `LICENSE` (line 2)

### Lock/config files
- `mason-lock.json` (line 1 — all paths)
- `.mason/bricks.json` (line 1 — all paths)

### Template files with TODO author tags
- `service/__brick__/{{serviceName.pascalCase()}}.dart` (line 12 — `ultrawideturbodev`)
- `document-service/__brick__/lib/features/.../dtos/{{collectionObjectName.snakeCase()}}_dto.dart` (lines 28-29 — `turbodev`)

## Constraints
- Touch only files listed above. No other files should change.
- Preserve exact formatting, indentation, and structure of each file.
- Do not modify PLAN.md.
- Case-sensitive replacements: match the exact casing pattern of each occurrence.

## Acceptance criteria
- `grep -rni "ultra.wide.turbo\|ultra_wide_turbo\|ultrawideturbodev" . --include="*.dart" --include="*.yaml" --include="*.json" --include="*.md" --include="*.sh" --include="*.txt" | grep -v ".git/" | grep -v "PLAN.md"` returns zero results.
- `grep -rn "turbodev" . --include="*.dart" | grep -v ".git/" | grep -v "PLAN.md"` returns zero results (all changed to `appboy`).
- `temp/` directory no longer exists.
- All brick.yaml files parse correctly (valid YAML).
- mason-lock.json and .mason/bricks.json contain valid JSON with updated paths.

## Verification
Run the grep commands above after all changes to confirm zero hits. Verify YAML/JSON validity with `python3 -c "import json; json.load(open('.mason/bricks.json'))"` and similar for mason-lock.json.

## Quality lenses
- No partial replacements (e.g. "ultra turbo" or "wide turbo").
- No accidental replacements inside Mustache template variables.
- No content changes beyond the branding map above.

</user_instructions>
<file_map>
deappspecialist
└── lib
    ├── config
    │   └── models
    │       └── das_locator_service.dart * +
    └── home
        └── routers
            └── home_router.dart * +


shadcn_ui


turbo_modules
└── lib
    ├── core
    │   └── abstracts
    │       └── t_view_model.dart * +
    └── locator
        └── services
            └── t_locator_service.dart * +


flutter-widgets


dev-conventions


(* denotes selected files)
(+ denotes code-map available)

File: turbo_modules/lib/locator/services/t_locator_service.dart
Imports:
---
Classes:
  - TLocatorService
    Methods:
      - L19: void registerAll({
 bool doRegisterSingletons = false,
      - L47: Future<void> reset() async
      - L73: void _registerServices()
---


File: turbo_modules/lib/core/abstracts/t_view_model.dart
Imports:
---
Classes:
  - TViewModel
    Methods:
      - L20: Future<void> initialise({bool doSetInitialised = true}) async
      - L26: Future<void> dispose() async
      - L36: ValueListenable<bool> get hasAuth => authService().hasAuth;
---


File: deappspecialist/lib/config/models/das_locator_service.dart
Imports:
---
Classes:
  - DasLocator
    Methods:
      - L46: DasLocator._();
      - L48: static DasLocator get locate
      - L53: void registerSingletons()
      - L56: void registerRouters()
      - L67: void registerApis()
      - L70: void registerLazySingletonServices()
      - L107: void registerFactoryServices()
      - L117: void registerForms()
      - L125: void registerViewModels()
---


File: deappspecialist/lib/home/routers/home_router.dart
Imports:
---
Classes:
  - HomeRouter
    Methods:
      - L5: HomeRouter({
 required super.initialRoute, required super.appRoutingService, required super.navigationTabService,
      - L13: static HomeRouter Function() get lazyLocate =>
      - L15: static HomeRouter get locate => GetIt.I.get();
      - L16: static void registerFactory({required TRoute initialRoute}) => GetIt.I.registerFactory(
 () => HomeRouter( initialRoute: initialRoute, appRoutingService: AppRoutingService.locate, navigationTabService: NavigationTabService.locate, ),
---

</file_map>
<meta prompt 1 = "System: MCP Agent">
You are an **autonomous agent** operating RepoPrompt MCP tools. Make confident decisions, work in small, certain steps, and choose the most efficient path for each task.

**Provenance & State**
This prompt comes directly from RepoPrompt. The MCP server’s workspace state already matches what you see here — a partial, selected-mode file tree (trimmed for size), codemaps for some selected files, and the current `user_instructions` prompt are embedded. No pre-flight verification is required for the first turn. If you need to drill deeper into specific directories, use `get_file_tree`.

**Your Operating Philosophy**
- **Autonomy:** Decide and act without asking permission—you know the tools, use them.
- **Precision:** Prefer small, certain steps over large, uncertain ones.
* **RepoPrompt tools (recommended):** These workspace-aware tools are available and highly capable (they handle multi-root edits, moves, and more). Use them when convenient.
  * Use `apply_edits` for direct code changes (multi-root safe; add `"verbose": true` for a unified diff of what changed).
  * Use `file_actions` to create, delete, move, or rename files (multi-root aware; safe deletes require absolute paths).
	* (Optional) `ask_oracle` for architecture planning or second-opinion review. When implementation is complex or unclear, use `mode:"plan"` to clarify the approach; if further clarification is needed, follow up with `mode:"chat"`.

**Explore & Understand (as needed)**

- **Map structure fast:** use `get_file_tree` with `mode:"auto"` (adapts depth to size, shows all roots when no `path` is given).

  ```json
  {"tool":"get_file_tree","args":{"type":"files","mode":"auto"}}
  ```

  Drill down into a directory by adding `path` (optionally bound the depth):

  ```json
  {"tool":"get_file_tree","args":{"type":"files","mode":"auto","path":"RootName/src","max_depth":2}}
  ```
* **Surface symbols/usages/paths:** `file_search`
* **Summarize APIs:** `get_code_structure` on key paths

*(Note: No need to call `type:"roots"`—`mode:"auto"` without `path` surfaces all roots plus a partial tree.)*

**Slices doctrine (when selection must stay lean)**
- MUST read the relevant sections with `read_file` before slicing
- Use `ranges` objects with concise descriptions (`description`/`desc`/`label`); the `lines` shorthand cannot carry descriptions
- Prefer 80–150+ line self-contained slices over micro-fragments
- Iterate with `op:"preview"` to inspect content, then apply with `op:"set"` `mode:"slices"` or `op:"add"`
- If you omit critical context, the task will fail

**Implement Changes**
Go straight to `apply_edits` and/or `file_actions` when the change is clear.
Examples:
```json
// Single search-replace
{"tool":"apply_edits","args":{"path":"Root/File.swift","search":"oldMethod()","replace":"newMethod()","all":true,"verbose":true}}

// Multiple targeted replacements
{"tool":"apply_edits","args":{"path":"Root/File.swift","edits":[
  {"search":"import OldLib","replace":"import NewLib"},
  {"search":"OldClass","replace":"NewClass","all":true}
],"verbose":true}}

// Full rewrite or creation
{"tool":"apply_edits","args":{"path":"Root/NewFile.swift","rewrite":"// full content...","on_missing":"create","verbose":true}}
````

**Architecture Planning (optional)**
If you need a high-level plan, use `ask_oracle` with `mode:"plan"`. Selection is still essential before doing so:

```json
{"tool":"manage_selection","args":{"op":"set","paths":["Root/src/feature","Root/src/shared/Types.swift"],"view":"files","strict":true}}
{"tool":"oracle_utils","args":{"op":"models"}}
{"tool":"ask_oracle","args":{
  "message":"Plan: Outline the approach to migrate X → Y given the selected files.",
  "new_chat":true,
  "mode":"plan",
  "model":"model-id"
}}
```

**Multi-Root Hygiene (efficient)**

* The starter prompt may already list roots—scan the provenance banner and partial tree first; no extra call needed.
* To (re)surface all roots, call `get_file_tree` **without** a `path`, e.g.
  `{"tool":"get_file_tree","args":{"type":"files","mode":"folders"}}`
  (No need to use `type:"roots"` separately.)
* Drill down by adding `path:"<RootName>/subdir"` to focus on a specific area.
* Always prefix edit targets with the correct root when using `apply_edits` or `file_actions`.

**Agent Delegation**

* `agent_run` / `agent_manage` are the agent control plane for spawning and managing separate Agent Mode sessions.
* `agent_run op=start message="..." model_id="explore"` creates a new session/tab with a role agent. Role labels: `explore`, `engineer`, `pair`, `design`.
* **Explore agents** (`model_id="explore"`) are lightweight and read-only. You can use them proactively when deeper codebase investigation would ground your work — e.g., to map unfamiliar areas before a complex task, or to answer architectural questions that need broad exploration. Not every task needs one; simple `file_search` or `read_file` calls often suffice.
* **Other roles** (engineer, pair, design) perform heavier work. Launch these when the user explicitly asks to delegate or spawn them.
* `context_builder` is for your own research/analysis in the current session — it does NOT spawn agents. Do not use it as a substitute when the user asks for a role agent.
* To share a plan with a delegated agent, pass `export_response:true` on `context_builder`, `ask_oracle`, or `oracle_send`. Include the returned `oracle_export_path` string inside the `message` you send on your next `agent_run` `start` or `steer` call. The `oracle_export_instruction` field is a ready-made sentence ("Read the Oracle export at `<path>` with `read_file` …") you can emit verbatim at the head of that `message`; the child agent already has `read_file` and will open the export itself.

**Operational Notes**

* Use `"verbose": true` with `apply_edits` to include a unified diff of the changes and quickly assess what was applied.
* Selection matters for `ask_oracle`; it is **not** required for `apply_edits`.
* Use `workspace_context` with `op:"export"` when users want context they can copy/paste into ChatGPT for a second opinion.
* Verify results with targeted `read_file` slices and follow-up `file_search` checks when helpful.
</meta prompt 1>
<user_instructions date="2026-05-06T09:42">
<mcp_metadata>
window_id: 1
workspace_instance: 1
workspace_name: 📲 De App Specialist

tab_id: 665B82A8-F320-4337-A77A-97C8FE6A241B
tab_name: T1

context_binding_guide:
  Before making tool calls to RepoPrompt, bind to this context:
  1. Bind to the correct window:
     tool: bind_context
     args: {"op": "bind", "window_id": 1}
  2. Bind to this tab (recommended for stable context):
     tool: bind_context
     args: {"op": "bind", "context_id": "665B82A8-F320-4337-A77A-97C8FE6A241B"}
</mcp_metadata>

# Task: Cross-cutting branding update + temp/ cleanup

## Original request
Rename all "Ultra Wide Turbo Bricks" / "ultra wide turbo" / "ultra_wide_turbo_bricks" branding to "Turbo Bricks" / "turbo" / "turbo_bricks" across the entire repo. Delete the `temp/` directory. Update TODO author tags from old naming.

## Description
The repository was recently renamed from `ultra_wide_turbo_bricks` to `turbo_bricks` (GitHub repo already renamed, git remote already updated). All internal references to the old name must be updated to match. The `temp/` directory is empty and should be removed.

## Context for implementing agent
This is a Mason bricks repository at `/Users/codaveto/Repos/turbo_bricks`. It contains ~10 brick templates that generate Flutter boilerplate code. The repo was renamed but internal file content still references the old name everywhere.

The RepoPrompt selection shows reference files from `turbo_modules` and `deappspecialist` — these demonstrate current naming conventions (`t_` prefix, `Turbo` branding, `appboy` as TODO author). Use these as authoritative naming references.

## Goals
- Replace all old branding with new branding across every file in the repo.
- Delete the `temp/` directory.
- Update `mason-lock.json` and `.mason/bricks.json` paths from `ultra_wide_turbo_bricks` to `turbo_bricks`.
- Update TODO author tags.

## Non-goals
- Do not update any brick template logic, patterns, or architecture. This task is branding-only.
- Do not restructure any brick directories.
- Do not update package imports or dependencies.
- Do not modify PLAN.md.

## Branding replacement map

| Context | Old value | New value |
|---------|-----------|-----------|
| Prose / titles | Ultra Wide Turbo Bricks | Turbo Bricks |
| brick.yaml descriptions | "An ultra wide turbo X brick" | "A turbo X brick" |
| brick.yaml descriptions | "One ultra wide turbo brick to rule them all" | "One turbo brick to rule them all" |
| brick.yaml descriptions | "Ultra wide turbo scripts brick" | "Turbo scripts brick" |
| brick.yaml var descriptions | "e.g. ultra_wide_turbo_bricks" | "e.g. turbo_bricks" |
| Package name examples | `ultra_wide_turbo_bricks` | `turbo_bricks` |
| Paths in lock files | `/Users/codaveto/Repos/ultra_wide_turbo_bricks/` | `/Users/codaveto/Repos/turbo_bricks/` |
| Git URLs | `ultra_wide_turbo_bricks` | `turbo_bricks` |
| LICENSE copyright | "Ultra Wide Turbo Bricks Contributors" | "Turbo Bricks Contributors" |
| TODO authors | `ultrawideturbodev` | `appboy` |
| TODO authors | `turbodev` | `appboy` |

## Exhaustive file list (every file with old branding)

### brick.yaml files (descriptions + var descriptions)
- `api/brick.yaml` (lines 2, 9)
- `brick/brick.yaml` (line 2)
- `brick/__brick__/{{brickName.paramCase()}}/brick.yaml` (lines 2, 9)
- `bricks/__brick__/bricks/brick/brick.yaml` (line 9)
- `collection-service/brick.yaml` (line 2)
- `constants/brick.yaml` (line 2)
- `document-service/brick.yaml` (line 2)
- `router/brick.yaml` (lines 2, 12)
- `scripts/brick.yaml` (line 2)
- `service/brick.yaml` (line 2)
- `view/brick.yaml` (lines 2, 15)

### Documentation files
- `README.md` (lines 1, 30)
- `CLAUDE.md` (line 7)
- `CHANGELOG.md` (line 20)
- `LICENSE` (line 2)

### Lock/config files
- `mason-lock.json` (line 1 — all paths)
- `.mason/bricks.json` (line 1 — all paths)

### Template files with TODO author tags
- `service/__brick__/{{serviceName.pascalCase()}}.dart` (line 12 — `ultrawideturbodev`)
- `document-service/__brick__/lib/features/.../dtos/{{collectionObjectName.snakeCase()}}_dto.dart` (lines 28-29 — `turbodev`)

## Constraints
- Touch only files listed above. No other files should change.
- Preserve exact formatting, indentation, and structure of each file.
- Do not modify PLAN.md.
- Case-sensitive replacements: match the exact casing pattern of each occurrence.

## Acceptance criteria
- `grep -rni "ultra.wide.turbo\|ultra_wide_turbo\|ultrawideturbodev" . --include="*.dart" --include="*.yaml" --include="*.json" --include="*.md" --include="*.sh" --include="*.txt" | grep -v ".git/" | grep -v "PLAN.md"` returns zero results.
- `grep -rn "turbodev" . --include="*.dart" | grep -v ".git/" | grep -v "PLAN.md"` returns zero results (all changed to `appboy`).
- `temp/` directory no longer exists.
- All brick.yaml files parse correctly (valid YAML).
- mason-lock.json and .mason/bricks.json contain valid JSON with updated paths.

## Verification
Run the grep commands above after all changes to confirm zero hits. Verify YAML/JSON validity with `python3 -c "import json; json.load(open('.mason/bricks.json'))"` and similar for mason-lock.json.

## Quality lenses
- No partial replacements (e.g. "ultra turbo" or "wide turbo").
- No accidental replacements inside Mustache template variables.
- No content changes beyond the branding map above.

</user_instructions>
