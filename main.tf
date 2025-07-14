name: tfsec

on:
  pull_request:
    branches:
      - staging

jobs:
  build:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout code
        uses: actions/checkout@v3

      - name: Set up Terraform
        uses: hashicorp/setup-terraform@v2
        with:
          terraform_version: 1.5.7

      - name: Check for Terraform files
        run: |
          if ls *.tf 1> /dev/null 2>&1; then
            echo "Terraform files found"
          else
            echo "No Terraform files found"
            exit 1
          fi

      - name: Install tfsec
        run: |
          curl -s https://raw.githubusercontent.com/aquasecurity/tfsec/master/scripts/install_linux.sh | bash

      - name: Run tfsec
        run: tfsec --soft-fail .

      - name: Install tflint
        run: |
          curl -s https://raw.githubusercontent.com/terraform-linters/tflint/master/install_linux.sh | bash

      - name: Run tflint
        run: tflint --chdir .
