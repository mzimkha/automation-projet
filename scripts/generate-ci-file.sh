#!/bin/bash
# Generated directory and ci.yaml file for the CI/CD

set -euo pipefail

WORKFLOW_DIR=".github/workflows"

CI_FILE="$WORKFLOW_DIR/ci.yaml"


echo "🔍 Checking if directory '$WORKFLOW_DIR' exists..."

# Create directory if needed
if [[ -d "$WORKFLOW_DIR" ]]; then
    echo "✅ Directory already exists. Nothing to create."
else
    echo "📁 Directory not found. Creating '$WORKFLOW_DIR'..."
    mkdir -p "$WORKFLOW_DIR"
    echo "✅ Directory created successfully."
fi


echo "🔍 Checking CI workflow file..."

# Create ci.yaml if it doesn't exist

if [[ -f "$CI_FILE" ]]; then
    echo "✅ CI workflow already exists: $CI_FILE"
else
    echo "📝 Creating default CI workflow: $CI_FILE"

cat << 'EOF' > "$CI_FILE"

name: CI Pipeline

on:
  push:
    branches: [ "main" ]
  pull_request:
    branches: [ "main" ]

jobs:

  build:
    name: Build Project
    runs-on: ubuntu-latest

    steps:
      - name: Checkout repository
        uses: actions/checkout@v4

      - name: Set up JDK 17
        uses: actions/setup-java@v4
        with:
          java-version: '17'
          distribution: 'temurin'
          cache: 'maven'

      - name: Build Maven project
        run: mvn -B -ntp clean compile

  tests:
    name: Run Tests
    runs-on: ubuntu-latest
    needs: build

    steps:
      - name: Checkout repository
        uses: actions/checkout@v4

      - name: Set up JDK 17
        uses: actions/setup-java@v4
        with:
          java-version: '17'
          distribution: 'temurin'
          cache: 'maven'

      - name: Run unit tests
        run: mvn -B -ntp test

  sonar:
    name: SonarQube Analysis
    runs-on: ubuntu-latest
    needs: tests

    steps:
      - name: Checkout repository
        uses: actions/checkout@v4

      - name: Set up JDK 17
        uses: actions/setup-java@v4
        with:
          java-version: '17'
          distribution: 'temurin'
          cache: 'maven'

      - name: SonarQube Scan
        env:
          SONAR_TOKEN: ${{ secrets.SONAR_TOKEN }}
        run: |
          mvn -B -ntp verify sonar:sonar \
            -Dsonar.projectKey=YOUR_PROJECT_KEY \
            -Dsonar.organization=YOUR_ORG \
            -Dsonar.host.url=https://sonarcloud.io
EOF

    echo "✅ CI workflow created successfully."
fi
echo "🎉 Setup complete."
exit 0


