# Project set-up (in python/VSCode)

## Create and clone github respository
1. Create new repository in github organization
    - add `README.md`
    - Use Apache 2.0 License (consistent with Citywide Github Policy)
    - add relevant `.gitignore` file for the relevant language (e.g. `Python`)
2. Clone this repository locally
    - use command prompt or a terminal in any IDE (e.g. RStudio, VSCode) to navigate to where you want the repository saved. In command prompt you could do the following:
      ```
      cd C:/Users/BoydClaire/workspace_local
      ```
    - go to your repository on github and copy the .git url (press green button Code and then under HTTPS press the copy button for the `Clone using the web URL`)
    - use the following command to clone the repo with relevant proxy information (also in a terminal or command prompt)
      ```
      git clone https://github.com/nycdepartmentoffinance/onboarding.git -c "http.proxy=http://bcpxy.nycnet:8080" -c "https.proxy=https://bcpxy.nycnet:8080"
      ```
    - a pop-up will likely come up which will ask you to log in to github (using your user/password or a personal access token).
    - once you do that, the local clone should be complete!

Now that the folder is set up with git, you can proceed to use it and all changes in the folder will be tracked. 


## Open folder in VSCode

If you are programming in python, I find it easier to program in an Integrated Development Environment (IDE) -- basically a software that helps you keep track of your work in a much more user friendly way.

The Microsoft IDE is called [VSCode](https://code.visualstudio.com/download) and is very similar to RStudio, Jupyter, or SAS Enterprise in that it has a place for you to write your code and a terminal or console where your code is being run and output is generated. The special benefit of VSCode is that it has a github extension that helps you keep track of the versioning of your code as it changes.

After downloading VSCode, the easiest way to start a project using the tool is to open an existing folder (or cloned local github repository) in VSCode by \:
1. Under File, Select `Open Folder...`
2. Select the new directory you just made from the github repository from the `Browse` feature
3. Press select folder

Now VSCode is open within the local repository that you created, and is being tracked by git. If you click on the Explorer Icon on the top left cornder (looks like two pieces of paper), you can see and navigate to other files within that main folder.

To add a new file, you can use the user interface by clicking "File", and then "New File" and VS Code will give you additional options depending on what file type you want to create. Or, you  can just type the following into the terminal below which will create a blank file called `test.py`:
```
echo ""  > test.py
```

To see if these were tracked, we can first look at the status of git in the folder. Type the following in the VSCode Terminal:
```
git status
```
This will show us that the `test.py` file is present (new) and not yet being tracked.

<img src="https://github.com/user-attachments/assets/8649ec6a-8f0f-4cff-bd3c-323c54f164b4" style="width:600px;"/>

To add the `test.py` file to the repository to be tracked we can use the following git command:
```
git add test.py
```
After we do that and run `git status` again, we can see that the file is now being tracked:
<img src="https://github.com/user-attachments/assets/7584a52d-aca2-4f26-88d9-da24382fe74d" style="width:600px;"/>

## Git commit and push

As of now, the `test.py` file is only saved locally, within the folder on our computer. If you look at the version of the folder (repository) on Github, you'll see that the `test.py` file isn't there yet. This is because the version of the folder on your computer is a clone (or copy) of the GitHub folder. In order to sync the changes from the local version to the Github version, we need to commit (or log) the changes and then push (or syncronyze) the changes back to the main version of the folder.

To commit the files in the "changes to be commited" list above, use the following command:
```
git commit -m "added test.py file"
```
The -m and following message are displayed by git and are helpful to keep track of what changes were done between versions of the folder.

After doing that, this is what you'll see:

<img src="https://github.com/user-attachments/assets/34cd024b-2d34-470a-83ce-e6040b866077" style="width:600px;"/>

You'll notice that our branch (aka the local version of the folder that we're working on) has more changes (1 commit) more than the branch on github (origin/main). Let's push these changes to github now with the following command:

```
git push
```
When you do this you will likely get a pop-up by git to sign-in with your github credentials (fine to use either your user/password or a personal access token).

After successfully signing in, you should get the following update in your terminal:

<img src="https://github.com/user-attachments/assets/7ee5b5a9-2885-4a54-8724-8c4cbc444658" style="width:600px;"/>

Success! Now the new `test.py` file is saved to the online version of your repository on github. 

Now you're ready to get started with the rest of your project. It's good practice that every few hours or so you repeat these steps (`git add .`, `git commit -m ""`, and `git push`) to make sure your updates are being saved to your repository.

## Proxy set-up

Before you do too much (install packages, download data from database, etc), you'll want to follow the [proxy set up](proxy_python.md) instructions to make sure you are connecting to the internet correctly to mitigate any potential issues.

## Using poetry or conda environments

One additional set-up step that is really helpful when working a project with a lot of packages and possible package dependencies is using virtual environments like [poetry](https://python-poetry.org/) or [conda](https://docs.conda.io/projects/conda/en/latest/user-guide/tasks/manage-environments.html). These tools help track what packages are used in the project and need to be downloaded in order to run certain scripts and makes getting up to date with a project really fast.

`conda` works really similarly to `renv`, so below is a demo of how to use `conda`, but use whatever virtual environment tool makes the most sense. [Note: as of 12/31/2024, poetry does not have a solution of how to work with proxies consistently as documented in [this github issue](https://github.com/python-poetry/poetry/issues/3748)].

To use conda for your project, first make sure that conda is installed by typing the following into your VSCode Terminal:
```ps
conda --version
```

You should see a version like 4.7.12. If you don't, then use the instructions in the first step of proxy python set up (using `conda` instead of `python`) to successfully set up conda locally.

# set up conda with proxy

navigate to your user root directory of your local machine.

```
cd C:\Users\BoydClaire
```

open the .condarc file there by just typing the file name or creating it
```
.condarc
```

edit the file so that it contains the following
```
ssl_verify: true
channels:
  - conda-forge
  - defaults
proxy_servers:
  http: bcpxy.nycnet:8080
  https: bcpxy.nycnet:8080
```

After this is complete, run the following to activate poetry for your project in the terminal:
```
conda create --name YOUR_ENV_NAME
```

This will guide you through an interactive process where it will ask you a sequence of questions about the environment you want to create. If you want to just use the defaults, just press enter through it.

To start working within this virtual environment, use the following command to initiate conda for your shell script:
```
conda init powershell
```

Exit the shell and open a new terminal session. Then, you can activate your environment you just created:
```
conda activate YOUR_ENV_NAME
```

Now, you can work on your project as normal! When you want to add a new package (e.g. `scipy`), use the following command:
```
conda install scipy
```

For more information on how `conda` works, visit the documentation here: [https://docs.conda.io/projects/conda/en/latest/user-guide/tasks/manage-pkgs.html](https://docs.conda.io/projects/conda/en/latest/user-guide/tasks/manage-pkgs.html)
