## GitHub Set-up and Proxy Configuration Guide

#### What is git and why is it helpful?

Git is a tool (specifically a distributed version control system) that helps developers keep track of changes made to their code over time, manage different versions of files, and collaborate efficiently on software projects. It enables developers to keep a history of all changes made to the codebase, facilitating collaboration among multiple developers, even when working offline. Git makes it easier to organize, store, and share code, making it easier to collaborate and avoid losing important changes.

It's awesome.

**What is the difference between git and GitHub?**

In short, git is a very simple command line language while GitHub is a website that hosts repositories (folders) under version control by Git, enabling collaboration among developers by providing tools for sharing code, managing projects, and tracking issues. While Git is used for version control on your local machine, GitHub offers remote repository hosting and additional collaboration features.

Think about it like this: git is your personal assistant for a folder who is keeping track of when you 
make changes and what versions of files are compatible with other versions. GitHub is the lunch room where everyone's assistants talk to each other and decide the best path forward; it's a website where you can save 
the folder (repository) and look back at earlier versions of the folder or other people's version of the folder.

#### Downsides of git

While Git is a powerful tool, there are some downsides to consider:

* Hard to learn: Git can be difficult to learn for new users, especially when dealing with advanced features like branching, merging, and rebasing.

* Merge Conflicts: When multiple people make changes to the same part of a file, Git may not be able to automatically merge the changes, leading to merge conflicts that require manual resolution which can be tricky to de-bug.

That said, there are a ton of advantages to using git that outweigh these cons! With a little bit of practice, it is super easy to get into a flow to where you can use it seamlessly.

#### City policy on using Git/GitHub

Before proceeding with the GitHub setup, please take a look at the official [Citywide GitHub Policy](https://github.com/nycdepartmentoffinance/onboarding/blob/b9ab8ef51d05067ec7894c0086f4ae7fef8ae9cb/resources/Citywide-GitHub-Policy.pdf) to ensure you understand the guidelines for using GitHub within the NYC Department of Finance (DOF). It contains a helpful overview of what:

* what github is useful for
* definitions of key terms (repository, accounts, permissions)
* account management guidelines
* policies for projects with different kinds of data (open source or private to city)


#### Make a GitHub Account with Your Work Email

To get started, you must have a GitHub account linked to your work email. If you don't already have one:

1. Create a GitHub account using your work email address. You can do so by going to [https://github.com/](https://github.com/) and clicking on Sign Up.
2. If you already have a GitHub account, you can add your work email as your primary email in the account settings. See: [Changing your primary email](https://help.github.com/articles/changing-your-primary-email-address/) for guidance.


#### 2. Join the DOF GitHub Organization: NYC Department of Finance

After creating your GitHub account or adding your work email, join the official GitHub organization for the NYC Department of Finance (DOF):

- Search for "NYC Department of Finance" on GitHub.
- Request to join the organization through GitHub's interface.
- Send a message to Claire or other DOF staff to be approved.

Once you get access, you can explore the open projects and repositories under the organization to get a sense of 
what team members are working on.

#### 3. Download Git Locally
To interact with Git repositories locally, you'll need to install Git on your machine:

1. Visit [Git Downloads](https://git-scm.com/downloads).
2. Download and install the appropriate version for your operating system.

***Note:*** You might encounter a few administrative errors during installation. Though you might see a few errors (namely that you do not have administrative privileges to write to certain folders), Git should install correctly without needing IT assistance. If you have any doubts or need help with the install, submit a ticket to [HelpDesk](https://cwitservice.nyc.gov/sp) to ask for them to install git locally.

To make sure that git is downloaded, you can check by opening a terminal in command prompt and typing `git`. You should see something like the below if things are working correctly:

![image](https://github.com/user-attachments/assets/ba1bc394-efe8-41d4-9143-1bec13d38704)


#### 4. Setting Up Git to Work Through the Proxy

Our machines at DOF connect to the internet through a SOCKS proxy which allows OTI to ensure our data and systems are secure. Because of this, we must configure Git to connect to the internet through a proxy server in order to access GitHub. This is necessary because the terminal or command prompt on your machine is not directly connected to the internet. Without connecting to the proxy, Git operations will fail due to a timeout error when trying to access GitHub (e.g., `connection timeout with port 22`). This is because the terminal is trying to access GitHub directly, bypassing the proxy, which is used for all other network communication on your machine.

Good news - it's simple to configure the tools we need (git, R, python, etc.) to recognize the proxy and connect to the internet securely.

##### Steps to Set Up Git with Proxy:

1. Open your terminal or command prompt.
2. First, look to see what your git configuration settings are with the following command:

```{bash}
git config --list
```

3. Set the following Git configuration settings, replacing the user.name and the user.email with the appropriate values:

```{bash}
# replace with your name and email
git config --global user.name "FirstName LastName"
git config --global user.email "lastfirst@finance.nyc.gov"
git config --global http.sslbackend schannel
git config --global http.proxy http://bcpxy.nycnet:8080
git config --global https.proxy https://bcpxy.nycnet:8080
```
4. Check to make sure the configuration settings were set correctly by calling the following command again:

```{bash}
git config --list --show-origin
```
You should see the settings you just changed at the bottom of the list, saved to a new .gitconfig file at the root of your user directory.

#### 5. Cloning a Git Repository

Now that we added the configuration, we can try to clone a repository locally. To clone a Git repository while connected to the proxy, follow these steps:

1. Navigate to the directory where you want the repository to be copied. For example, in the terminal within RStudio or 
with the Command Prompt:

```{bash}
cd /workspace_local
```

2. Clone this public repository (as a test) using the following command:

```{bash}
git clone https://github.com/nycdepartmentoffinance/nycdepartmentoffinance.github.io.git
```

Note: if the repository is "public" then it will clone (copy) without needing to offer any other information. 

For our purposes, most of the folders on GitHub will be set to private so only DOF employees have access. In these cases, we will need to do a couple additional steps to authenticate our machine using our github information. The easiest way to do this is to try to clone a private repository and then have git redirect you to a browser to sign in with your username and password.

For an example of a private repository, try the following:

```{bash}
git clone https://github.com/nycdepartmentoffinance/onboarding.git
```

3. Connect to github through your browser:

    - This command will prompt your web browser to open.
    - You will be asked to sign in to GitHub with your credentials.
    - Follow the on-screen instructions, including any additional confirmations or "OK" prompts.
    - Once signed in, the repository will be downloaded to your local directory.

Done! 

Note: you'll need to do this sign in process every time you download (pull) or upload (push) content to github that is in a private repository.

#### Learning how to use git

Now you can get started by putting git to the test! As you explore how to use git, 
feel free to refer back to these core resources that should have all you need to 
implement the basic usages of git/GitHub.

***Note:*** 99% of what we will do will be one of the following commands: `git pull`, `git status`, 
`git add .`, `git commit` and `git push`.

- **What is Git? Why Should We Use It?**  
  For a detailed overview of Git, check out this super helpful tutorial: [Happy Git with R](https://happygitwithr.com/big-picture).

- **Overview of Git Distributed Workflows**  
  Learn more about Git's distributed workflows: [Git - Distributed Workflows](https://www.atlassian.com/git/tutorials/using-branches).

- **Git Cheat Sheet**  
  For a quick reference on common Git commands, download the Git cheat sheet: [Git Cheat Sheet](https://education.github.com/git-cheat-sheet-education.pdf).

- **Git Branching Game**  
  Practice and understand Git branching with this interactive game: [Learn Git Branching](https://learngitbranching.js.org/?locale=en_US).  
  - This game helps demonstrate the design of branching and how it can be both useful and complicated at times.  
  - While it may be confusing to new Git users, it will make more sense with experience.

- **Government Best Practices**  
  Learn how Git is used in government projects and the best practices for collaboration:  
  [Government Best Practices](https://www.18f.gov/guides/using-git-and-github/).  

- **Advanced Git: Issues & Tracking**  
  For more advanced Git usage, including issue tracking, check out: [About Issues - GitHub Docs](https://docs.github.com/en/github/managing-your-work-on-github/about-issues).

- **Git Documentation for All Other Needs**  
  For further details and troubleshooting, refer to the official GitHub Docs: [GitHub Docs](https://docs.github.com/en/github).





