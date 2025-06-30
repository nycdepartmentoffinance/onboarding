# GitHub Workflow

When working on data projects (both on your own and with others) it’s helpful to to have a way to break work into clear tasks and test changes without affecting the main version. Using tools that let you work on your own copy of a project—and connect that work to a specific task—helps teams stay organized, avoid conflicts, and make confident updates.

Git provides a few simple but powerful tools to support this kind of workflow: _branches_, _issues_, and _pull requests_.

This guide walks you through these core features of git, covering:

1. **What a branch is** — and why working in your own space matters

2. **How to create and use a branch** — without disrupting others

3. **What an issue is** — and how to use them to define and track tasks

4. **How to branch based on an issue** — for clear, focused progress

5. **What a pull request is** — and how it brings everything together for review

6. **How to open a pull request** — and how to use it to merge work into the main branch of the project

## Branches

Imagine you're working on a new draft of an existing word document. Instead of editing the original directly, you make a copy, work on your version, and only bring it back when it's complete. You might want to do this if you want to make sure that you can go back to the old version if you decide you don't like your changes or want to keep components of the old version as it is.

This instinct to start working on another version of a document and leave a stable version of the project behind is exactly what git branching allows you to do with code.

A **branch** is like a separate workspace or copy of your project. You can make changes there without affecting the main version. Once your changes are ready, you can merge your branch back into the main branch of the project so that your changes are reflected.

The diagram below illustrates Git's branching and merging workflow, which allows teams to work on the same project simultaneously without conflicts.

- The bottom timeline shows the **main/master branch** - the main, stable version of the project that progresses chronologically through various commits (gray circles). Each commit represents a saved snapshot of the project, and the green circle labeled "HEAD" shows the current state after all work has been integrated.

- The **feature branch** at the top demonstrates how developers create their own workspace to develop new functionality safely. This branch splits off from the master branch and contains one commit for the "awesome feature." Importantly, while this feature was being developed in isolation, the main/master branch continued evolving with additional commits (like the "third commit"), showing how parallel development prevents teams from blocking each other's progress.

- The **merge** process, shown by the arrow and special "Merge" commit, integrates the feature branch work back into the main timeline. This merge commit combines the isolated feature development with the ongoing master branch changes, creating a unified project history. The result preserves both the new feature and any parallel work that occurred, while maintaining a complete record of when features were created, developed, and successfully integrated into the main codebase.

![Git branching](resources/branch.png)

**Try it: Create a Branch**

Here's how to create a branch using the command line:

**_Step 1:_** Make sure you're on the main branch and up-to-date

```bash
git checkout main
git pull origin main
```

**_Step 2:_** Create and switch to your new branch

```bash
git checkout -b my-branch-name
```

**_Step 3:_** Push your branch to GitHub so anyone can see it

```bash
git push -u origin my-branch-name
```

**What Should You Branch For?**

You should create a branch whenever you need to work on something specific without affecting the stable version of the project that others (or future you) might depend on. This includes adding new features, fixing problems, or experimenting with different approaches.

The key is that each branch should focus on one clear task - don't try to fix multiple unrelated problems in the same branch. Think of it as having a dedicated workspace for each project, which keeps your work organized and makes it easy for others to understand and review your changes.

But how do you decide what deserves its own branch? This is where **issues** become essential.

## Issues

An **issue** is basically a structured to-do list item that clearly describes what needs to be done. Instead of just thinking "fix the dashboard," you create an issue that spells out the specific problem, why it needs to be fixed, and what the solution might look like.

Each issue then becomes the blueprint for a branch - you create a branch specifically to solve that issue, making the connection between the problem and the solution clear for everyone. This approach transforms vague tasks into focused, trackable work that your whole team can follow and contribute to.

**How "big" should an issue be?**

Issues can vary dramatically in size and scope. You might create an issue to "change this chart color from red to blue" or a much larger one to "figure out how to scale our model to cover three additional boroughs." An issue should be a discrete, well-defined unit of work that typically takes no more than a week.

If a task is too big (e.g. scaling a model to other boroughs), it's perfectly valid to create an issue just to scope out and break down a big project into smaller, manageable pieces. For example: figuring out what parts of the project can be functionalized, and then create issues to functionalize each part of the process.

Good issues follow a simple structure: start with a descriptive title that summarizes the problem concisely, then provide a description with context about what you hope the issue will address (with as much context as you can even if it feels incomplete). The goal is to make it so clear that anyone on your team could pick up the issue and understand exactly what needs to be accomplished.

TODO -- sample issue? or link to issues in this repo?

**Try it: Create an issue**

TODO -- instructions on how to add an issue, maybe something on the project project management tool

**Creating a branch based on an issue**

When you create a branch based on an issue, everyone on your team can instantly see what you're working on and why it matters - no more guessing what "sarah-updates" or "temp-fix" branches are for. Your work stays organized because each branch has a clear purpose tied to a specific problem that needs solving, making it much easier to track progress and avoid getting sidetracked. Best of all, when you're done, the connection between the problem (issue) and solution (branch) creates a complete story that helps your team learn from each other and avoid repeating the same problems.

Creating a branch based on an issue using the point-and-click interface is really simple:

**On GitHub (or similar platforms):**

1. **Go to your issue** - Click on Issue #12: "Crime data isn't updating automatically"

2. **Look for "Create a branch"** - On the right side of the issue page, you'll see a "Development" section with a "Create a branch" link

3. **Click and customize** - GitHub will suggest a branch name like `12-crime-data-isnt-updating-automatically`. You can shorten this to something like `fix-crime-data-issue-12`

4. **Choose where to work** - Select whether you want to work locally on your computer or in the web editor

5. **Create the branch** - Click "Create branch" and you're ready to start working

**What happens automatically:**

- The branch gets linked to the issue
- Your branch name follows good naming conventions
- When you later create a pull request from this branch, it will automatically reference the issue
- Progress gets tracked in one place

**The beauty of this approach**: You never have to remember issue numbers or type branch names manually. The platform handles the connection between your issue and your workspace, making collaboration seamless.

## Pull Requests

TODO -- putting it all together
