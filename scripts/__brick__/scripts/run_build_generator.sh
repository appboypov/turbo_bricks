#!/bin/bash

# Exit on error
set -e

echo "🏗️ Running build_runner..."

# Run build_runner in release mode
echo "🚀 Generating code..."
dart run build_runner build --delete-conflicting-outputs

echo "✅ Code generation complete!"
