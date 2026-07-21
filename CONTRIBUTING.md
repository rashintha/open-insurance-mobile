# Contributing to Open Insurance Mobile

Thank you for your interest in contributing to Open Insurance Mobile! This guide explains how to get started, submit changes, and follow project conventions.

## Table of Contents

- [Code of Conduct](#code-of-conduct)
- [Getting Started](#getting-started)
- [Development Workflow](#development-workflow)
- [Pull Request Guidelines](#pull-request-guidelines)
- [Coding Standards](#coding-standards)
- [Reporting Issues](#reporting-issues)
- [Getting Help](#getting-help)

## Code of Conduct

Be respectful, constructive, and inclusive in all project interactions. Harassment, discrimination, and disruptive behavior are not tolerated.

## Getting Started

### Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) (compatible with Dart `^3.12`)
- A supported IDE (VS Code, Android Studio, or IntelliJ with Flutter plugins)
- Platform tooling for your target device (Android SDK, Xcode for iOS/macOS, etc.)

### Setup

1. Fork the repository on GitHub.
2. Clone your fork locally:

   ```bash
   git clone https://github.com/<your-username>/open-insurance-mobile.git
   cd open-insurance-mobile
   ```

3. Install dependencies:

   ```bash
   flutter pub get
   ```

4. Verify the project runs:

   ```bash
   flutter run
   ```

5. Run tests and analysis before submitting changes:

   ```bash
   flutter analyze
   flutter test
   ```

## Development Workflow

1. Create a feature branch from `main`:

   ```bash
   git checkout -b feature/your-feature-name
   ```

2. Make focused changes with clear, descriptive commits.
3. Keep pull requests small and scoped to a single concern when possible.
4. Update documentation when your change affects setup, usage, or behavior.
5. Push your branch and open a pull request against `main`.

## Pull Request Guidelines

Before opening a PR, ensure:

- [ ] Code builds and runs on at least one target platform
- [ ] `flutter analyze` passes with no new warnings
- [ ] `flutter test` passes
- [ ] Commit messages clearly describe the change
- [ ] The PR description explains **what** changed and **why**

### Commit Messages

Use clear, imperative subject lines:

- `Add policy summary screen`
- `Fix login form validation on Android`
- `Update README setup instructions`

## Coding Standards

- Follow [Effective Dart](https://dart.dev/effective-dart) and project lint rules in `analysis_options.yaml`.
- Prefer readable, maintainable code over clever shortcuts.
- Keep widgets and business logic appropriately separated.
- Add tests for new behavior when practical.
- Avoid unrelated formatting or refactors in the same PR as a feature fix.

## Reporting Issues

When filing an issue, include:

- A clear title and description
- Steps to reproduce (for bugs)
- Expected vs. actual behavior
- Flutter/Dart version (`flutter --version`)
- Target platform (Android, iOS, web, etc.)
- Screenshots or logs when helpful

## Getting Help

- Browse [existing issues](https://github.com/rashintha/open-insurance-mobile/issues)
- Read the [Contributor Guide](CONTRIBUTOR_GUIDE.md) for recognition and maintainer expectations
- Open a discussion or issue if you are unsure whether a change fits the project

We appreciate every contribution — from bug reports and documentation improvements to new features.
