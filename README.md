# Bump CLI Tool

A Dart command-line interface for semantic version management of Flutter/Dart projects.

## Features
- 🚀 Semantic versioning (major.minor.patch+buildNumber) support
- 🔄 Automatic version incrementing
- 📦 Direct modification of pubspec.yaml
- 🛠️ Supports both manual version setting and auto-increment

## Installation
```bash
# Add the tap repository
brew tap calsranna/inspire

# Install the CLI
brew install calsranna/inspire/bump
```

## Usage
```bash
bump <command> [arguments]
```

## Available Commands
| Command  | Description                     | Example                   |
|----------|---------------------------------|---------------------------|
| major    | Increment major version         | `bump major` (auto +1)    |
|          | Set specific major version      | `bump major 2`            |
| minor    | Increment minor version         | `bump minor`              |
| patch    | Increment patch version         | `bump patch`              |
| build    | Increment build number          | `bump build`              |
| version  | Show current tool version       | `bump version`            |

📌 **Note:** The `build` command will check `git rev-list --count HEAD`

💡 Pro tip: Use `-v` flag for version checks anywhere in the CLI
