# Code Review System

This directory contains scripts and configuration files for the code review system.

## Overview

The code review system provides comprehensive automated code reviews for each commit, including:

1. **Flutter Format Check** - Ensures code follows Flutter's formatting guidelines
2. **Flutter Analyze** - Static analysis for potential issues
3. **Flutter Test** - Runs unit tests to ensure functionality
4. **AI Code Review** - Uses AI to provide in-depth code review

## Setup

### 1. Install Dependencies

- **Flutter**: Follow the official installation guide for your platform
- **Python**: Version 3.8 or higher
- **pre-commit** (optional): For local pre-commit hooks

### 2. Configure pre-commit (optional)

```bash
# Install pre-commit
pip install pre-commit

# Install the pre-commit hook
pre-commit install
```

### 3. Configure AI API (optional)

To use the AI code review feature with a real AI API, you'll need to:

1. Update `ai_code_review.py` to use your preferred AI API
2. Add any necessary API keys or credentials

## Usage

### Local Review

Run the code review manually:

```bash
# Run Flutter format check
flutter format --dry-run --set-exit-if-changed .

# Run Flutter analyze
flutter analyze

# Run Flutter tests
flutter test

# Run AI code review on specific files
python .trae/scripts/ai_code_review.py path/to/file.dart
```

### CI/CD Review

The code review system is automatically triggered on:
- Push to main, develop, feature/*, or bugfix/* branches
- Pull requests to main or develop branches

## Review Results

- **Flutter Format/Analyze/Test**: Results are displayed in the CI/CD logs
- **AI Code Review**: Results are saved to `.trae/reviews/` directory as JSON files

## Customization

### Add New Review Checks

1. Add a new hook to `.pre-commit-config.yaml`
2. Add a new step to `.github/workflows/code-review.yml`
3. Create any necessary scripts in this directory

### Modify AI Review Prompt

Update the prompt in `ai_code_review.py` to customize the AI review criteria.
