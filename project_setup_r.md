# Project set-up (in R/RStudio)

## Create and clone github respository

1.  Create new repository in github organization
    -   add `README.md`
    -   Use Apache 2.0 License (consistent with Citywide Github Policy)
    -   add relevant `.gitignore` file for the relevant language (e.g.
        `R`)
2.  Clone this repository locally
    -   use command prompt or a terminal in any IDE (e.g. RStudio,
        VSCode) to navigate to where you want the repository saved. In
        command prompt you could do the following:

        ```         
        cd C:/Users/BoydClaire/workspace_local
        ```

        **Note:** if you want to work in one of the DOF shared drives (e.g. G or H) then you can use the /d command in the terminal to switch accordingly. For example, if you wanted to clone the repo into a folder called workspace in your H drive, you could do the following to navigate to that directory:
 
        ```         
        cd /d H:/workspace
        ```


    -   go to your repository on github and copy the .git url (press
        green button Code and then under HTTPS press the copy button for
        the "Clone using the web URL")

    -   use the following command to clone the repo with relevant proxy
        information (also in a terminal or command prompt). You don't need
        to include the http.proxy agruments if you have already set up your
        .Renviron file, but including them in case that is not set up yet.

        ```         
        git clone https://github.com/nycdepartmentoffinance/model_tc4.git -c "http.proxy=http://bcpxy.nycnet:8080" -c "https.proxy=https://bcpxy.nycnet:8080"
        ```

    -   a pop-up will likely come up which will ask you to log in to
        github (using your user/password or a personal access token).

    -   once you do that, the local clone should be complete!

Now that the folder is set up with git, you can proceed to use it and
all changes in the folder will be tracked.

## Add project files

If you are programming in R, you can create a new R project with the new
folder you just created. In RStudio you can: 1. Select `New Project...`
2. Indicate From Existing Directory 3. Select the new directory you just
made from the github repository from the `Browse` feature 4. Press
Create Project

Now you are in an Rproj that is being tracked by git.

Because RStudio just made a file for the project (e.g. `.Rproj`), we can
now add it to the github repository. To see if these were tracked, we
can first look at the status of git in the folder. Type the following in
the RStudio Terminal:

```         
git status
```

This will show us that the `.Rproj` file is present (new) and not yet
being tracked.

<img src="https://github.com/user-attachments/assets/8649ec6a-8f0f-4cff-bd3c-323c54f164b4" style="width:600px;"/>

To add the `.RProj` file to the repository to be tracked we can use the
following git command:

```         
git add model_tc4.Rproj
```

After we do that and run `git status` again, we can see that the file is
now being tracked:
<img src="https://github.com/user-attachments/assets/7584a52d-aca2-4f26-88d9-da24382fe74d" style="width:600px;"/>

## Git commit and push

As of now, the `.Rproj` file is only saved locally, within the folder on
our computer. If you look at the version of the folder (repository) on
Github, you'll see that the `.Rproj` file isn't there yet. This is
because the version of the folder on your computer is a clone (or copy)
of the GitHub folder. In order to sync the changes from the local
version to the Github version, we need to commit (or log) the changes
and then push (or syncronyze) the changes back to the main version of
the folder.

To commit the files in the "changes to be commited" list above, use the
following command:

```         
git commit -m "added .rproj file"
```

The -m and following message are displayed by git and are helpful to
keep track of what changes were done between versions of the folder.

After doing that, this is what you'll see:

<img src="https://github.com/user-attachments/assets/34cd024b-2d34-470a-83ce-e6040b866077" style="width:600px;"/>

You'll notice that our branch (aka the local version of the folder that
we're working on) has more changes (1 commit) more than the branch on
github (origin/main). Let's push these changes to github now with the
following command:

```         
git push
```

When you do this you will likely get a pop-up by git to sign-in with
your github credentials (fine to use either your user/password or a
personal access token).

After successfully signing in, you should get the following update in
your terminal:

<img src="https://github.com/user-attachments/assets/7ee5b5a9-2885-4a54-8724-8c4cbc444658" style="width:600px;"/>

Success! Now the new `.Rproj` file is saved to the online version of
your repository on github.

Now you're ready to get started with the rest of your project. It's good
practice that every few hours or so you repeat these steps (`git add .`,
`git commit -m ""`, and `git push`) to make sure your updates are being
saved to your repository.

## Using renv

One additional set-up step that is really helpful when working a project
with a lot of packages and possible package dependencies is `renv`. It
tracks what packages need to be downloaded in order to run certain
scripts and makes getting up to date with a project really fast.

To get a more comprehensive answer for why it's helpful to use renv,
read more here: <https://rstudio.github.io/renv/index.html>

To use renv for your project, first install the package:

``` r
install.packages("renv", dependencies=TRUE)
```

After it is installed, run the following to activate renv for your
project:

```         
renv::activate()
```

For more information on how `renv` works, visit the documentation here:
<https://rstudio.github.io/renv/articles/renv.html>

## Proxy set-up

Before you do too much (install packages, download data from database,
etc), you'll want to follow the [proxy set up](proxy_R.md) instructions
to make sure you are connecting to the internet correctly to mitigate
any potential issues.
