# Contributing to AWS EC2 Docker Orchestrator

First off, thank you for taking the time to contribute! Contributions, issues, and pull requests are always welcome.

## Code of Conduct
By participating in this project, you agree to abide by its terms. Please keep all interactions respectful and constructive.

## How Can I Contribute?

### Reporting Bugs
If you encounter a bug with the Terraform scripts or Docker configuration:
* Open an **Issue** on GitHub.
* Provide a clear description of the problem, including error messages, your Terraform version, and your AWS region.

### Suggesting Enhancements
Have an idea to improve the setup (like adding ECS support or automated CI/CD deployment)?
* Open an **Issue** tagged as an `enhancement`.
* Describe the feature and why it would be valuable.

### Pull Requests
1. **Fork** the repo and create your branch from `main`: `git checkout -b feature/amazing-feature`
2. Make your changes and test them thoroughly (e.g., running `terraform validate`).
3. Ensure your commit messages are clear and descriptive.
4. Open a **Pull Request** against the `main` branch with a summary of what you changed.

## Style Guidelines
* **Terraform:** Keep code formatted using `terraform fmt`.
* **Bash/Scripts:** Ensure any shell scripts use clear comments explaining installation steps.
* **Documentation:** Update the `README.md` if you add new variables or alter the architecture.
