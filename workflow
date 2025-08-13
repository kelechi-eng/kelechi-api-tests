name: Run Postman API Tests (Fixed)

on:
  push:
    branches: ["dev"]
  pull_request:
    branches: ["main"]

jobs:
  postman-tests:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout Repository
        uses: actions/checkout@v3

      - name: Install Node.js
        uses: actions/setup-node@v3
        with:
          node-version: '18'

      - name: Install Newman
        run: npm install -g newman newman-reporter-htmlextra

      - name: Run Postman Collection
        run: |
          newman run reqres_collection_fixed.json \
            --environment reqres_environment.json \
            --reporters cli,htmlextra \
            --reporter-htmlextra-export newman-report.html

      - name: Upload HTML Report
        uses: actions/upload-artifact@v3
        with:
          name: postman-html-report
          path: newman-report.html
