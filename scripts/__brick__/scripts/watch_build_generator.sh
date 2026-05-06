
#!/bin/bash

# Exit on error
set -e

echo "🏗️ Watching build_runner..."

# Run build_runner in watch mode
echo "🚀 Starting code generation watch..."
dart run build_runner watch --delete-conflicting-outputs

echo "✅ Code generation watch started!"
