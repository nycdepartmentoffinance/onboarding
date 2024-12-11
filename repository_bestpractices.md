# Best Practices for Adding Repositories to the NYC Department of Finance GitHub Organization

To ensure a smooth and consistent process for adding repositories to our GitHub organization, consider these best practices:

## 1. **Repository Visibility**
   - **Internal Use To Start:** All new repositories must initially be set to private. Before being public, the repository must be reviewed by another DOF employee to ensure that no secure data is being shared and 
      the repository complies with all NYC DOF data privacy and security policies. Sensitive or personally identifiable information (PII) should never be included in repositories.

## 2. **Repository Naming**
   - Use clear, descriptive names that reflect the purpose of the project (e.g. "sales_history_by_neighborhood" instead of "data_analysis").
   - Avoid using special characters or spaces; use hyphens (`-`) or underscores (`_`) instead of spaces.

## 3. **Repository Structure**
   - Each repository should contain:
     - A clear **README.md** file explaining the project, its purpose, and how to use it.
     - A **LICENSE** file if the project is meant to be open-source or publicly shared.
     - A **.gitignore** file tailored for the project's needs. This will likely contain .env or .renviron files.
   - Follow the standard **directory structure** for your programming language (e.g., `src/`, `docs/`, `tests/`).

## 4. **Documentation**
   - Maintain **up-to-date documentation** in the repository, especially for complex projects. This includes installation instructions, usage examples, and API documentation.
   - Include comments and docstrings in the code to explain functionality.

## 5. **Archiving & Deletion**
   - If a project is no longer actively maintained, consider archiving the repository to indicate that it is no longer in active development.
   - Repositories should only be deleted after ensuring that no relevant data or code is lost. Always consult the project owner before deletion.

The following are software engineering best practices that may not apply to every repository at DOF. When relevant, also consider the following:

## 6. **Branching Strategy**
   - Use a **clear branching model** (e.g., `main`, `dev`, `feature/` branches).
   - Always protect the `main` or `master` branch by enforcing pull request (PR) reviews and passing automated tests before merging.

## 7. **Issue & Pull Request Management**
   - Use GitHub **issues** to track bugs, feature requests, and discussions. Clearly label and categorize issues to facilitate workflow management.
   - For every new feature or fix, use **pull requests (PRs)**. Each PR should reference the associated issue and include a description of changes.
   - Ensure PRs are reviewed by relevant team members before merging.

## 8. **CI/CD Integration**
   - Integrate **continuous integration (CI)** tools to automatically run tests and check code quality on each push.
   - Consider adding **continuous deployment (CD)** pipelines for automated deployment of production-ready code.

---

By following these best practices, we ensure that our repositories remain organized, secure, and aligned with the goals of NYC DOF.
