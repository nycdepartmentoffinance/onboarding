# Virtual Environments in Python

Have you ever tried to run someone else's code and hit errors that you have a different version of a python package or even python itself?

For example, imagine one project needs pandas version 1.3.5 while another needs version 2.0.0. If you install pandas globally, installing one version will overwrite the other. This can make it impossible for both projects to work correctly on the same machine.

Don't fear! There is a solution!

## Enter Virtual Environments.

A virtual environment is a self‑contained setup that includes everything a project needs to run: its own libraries or packages, tools, configuration files, and sometimes its own version of the programming language. This setup ensures that one project’s dependencies are kept separate from others, so upgrading or changing a library for one project won’t affect any others. Because the entire environment is defined within the project, it can be recreated exactly on another machine, making it easier to reproduce results, share work, and maintain projects over time.

In short, using virtual environments for each project allows programmers to more easily contain the work that they are doing and share their code with others to be more stably reproducible. Hooray!

## How do you create one?

Just like there are different ways to import libraries in python (pip, homebrew, etc), there are a few different tools -- both built-in tools and importable libraries -- that you can use to create virtual environments. Here are a few examples:

- `venv`: This is the simplest option to create a virtual environment because it is a built-in python tool, so it comes pre-installed with any version of python. That said, it does not manage dependencies so it can be much harder to maintain.
- `conda`: A popular environment and package manager that works not only with Python but also with other languages and tools. It creates isolated environments and manages dependencies, including non-Python libraries, which is especially useful for data science and scientific computing.
- `poetry`: A modern and popular dependency manager that handles virtual environments, packaging, and publishing.
- `uv`: This is a newer, fast, and lightweight package manager written in Rust. It combines environment creation, dependency resolution, and installation into a single step.

In short, there are pros and cons to all of the above approaches. Conda is more widely used but remarkably slow, venv is built-in but requires a lot of manual dependency maintenance, and poetry is great for package dependencies but does not have functionality to specify which python version to use for the project.

All that to say, we recommend using `uv` because it combines environment creation, python versioning and dependency management into a single, fast workflow. It’s written in Rust, which makes it significantly faster than traditional tools (especially conda), and it handles dependency resolution in a way that is both predictable and reproducible. uv also plays nicely with network restrictions and proxy settings, which is important for working in our city environment. This means we can set up, share, and rebuild environments quickly and reliably without extra manual steps.

## How does this actually work

***NOTE:** This part of the guide assumes you've already been through the [proxy guide in python](proxy_python.md) and have the correct proxy configuration, including all the settings.json set-up. If this doesn't sound familiar, head over to that guide first.*

Let's walk through an actual example of how this works in practice, using `uv` (but this general philosophy will work across the other options as well).

First, open up VSCode and open a new or existing project folder (Open Folder > ...). Once you are in a project folder that you want to create a virtual environment for, we can get started. For this example, I am using the folder 'uv_test'.

### Installation

Now, we need to open up a terminal to install uv and specify what packages we want to add to our environment. Open a terminal by clicking on Terminal > New Terminal. This will open up a CommandPrompt (cmd) terminal.

To install `uv`, type the following command:

```cmd
pip install uv
```

If this doesn't work or you are working with a different type of machine or terminal, you can explore different [installation options](https://docs.astral.sh/uv/getting-started/installation/) that uv provides. For example, if you don't have pip set up, there is a command listed to run a line of code from a PowerShell terminal to download uv as well.

**A note on existing python versions:** uv is only compatible with python versions 3.8+, so if your version of python pre-dates 3.8, we recommend installing a new version of [python](https://www.python.org/downloads/) if needed or submitting a ticket to the [City HelpDesk](https://a858-am-login.nyc.gov/nidp/saml2/sso?SAMLRequest=jVJLbxoxEP4rK9%2F3DQQsFmkLqoqUpKtAe%2BhtsAdiyWtvPN5N8u%2B7MVSkh6Jex99rvvGSoNVFx%2BveP5snfOmRfPTWakP8%2FFKx3hlugRRxAy0S94Lv6od7XiQZ75z1VljNopoInVfWrK2hvkW3QzcogT%2Be7iv27H1HPE3Fq%2FJ0nifmXSQnO6QGhg5OmEjLos3orgx8yFxJMJ%2FOY2hjbU%2FKXGlKdmmImBKN1K%2FWCQxbVOwImpBF203Fdo%2Fr2UHAcXInpCxLORWlXMBsVmawAJhkhyIfgdQAkRrwSiXqcWvIg%2FEVK7JiGmfzOC%2F3RcanOS8nyWJW%2FGJRc9n%2FizJSmdPtsg5nEPFv%2B30TN993%2ByAwKInucUT%2Ff08%2F0VHoaJRlq2WogYfM7vPxbseBPxdjqxu%2By%2FSz%2BsWr4x95t5vGaiXeo1pr%2B7p2CH7cwbsewzla8P8OkCd5mCgZHwOUYwtK11I6JGLp6uL7989c%2FQY%3D&RelayState=https%3A%2F%2Fcwitservice.nyc.gov%2Fnavpage.do&SigAlg=http%3A%2F%2Fwww.w3.org%2F2001%2F04%2Fxmldsig-more%23rsa-sha256&Signature=GqRvugLTS%2BwrVqjGmYz9O0SgX0YH5ZnNMxapylATVjVoIeMs04KlA8fJ1PicTv01X5doqA9EVBYQZgM5pw0EsIH5dzTkCQkxZ2yPrXPUzURyeVWBMT9mpEqFIqNUzlmBgmpHVe4RMP7Yc3uwdlsrxrvwpVZghyNXaVyTGvsCDxmEsco083%2BFTw9b%2FWMXeyYvvF1QYQIkqdFTeN3g77rUYcXlBwwtg47zg4e%2BQU41878LVX%2B5Zgz7Qg41SU0u3IR3XOZveymV1OaVRdq9loCcTV7SXTnAr4vGfvVeE4z9atx%2BBly0iyw6UJvLesHRB3v82ZW%2FRRwPas3FN%2Bsg%2FFZWvQ%3D%3D) to install it on your behalf. If you download uv using the powershell and not pip, you might not need to do this step at all and use uv for python installation.

To make sure that uv is installed properly you can type the following into your terminal:

```bash
uv
```

You should see the following response:

```bash
error: 'uv' requires a subcommand but one was not provided
  [subcommands: run, init, add, remove, version, sync, lock, export, tree, tool, python, pip, venv, virtualenv, v, build, publish, build-backend, cache, self, clean, generate-shell-completion, --generate-shell-completion, help]

Usage: uv [OPTIONS] <COMMAND>

For more information, try '--help'.
```

This means that uv is installed correctly and we're ready to start building our virtual environment.

### Initialization with python

One thing that is so awesome about `uv` is that you can install python versions directly using it.

For example, say I want this project to have python 3.11. Let's start by using uv to download that version of python:

```
uv python install 3.11
```

This may take 3-4 minutes, but it is much faster than downloading it in other ways -- and uv will automatically add the python executable to your PATH, so you don't need to worry about it.

To check what versions of python are visible to uv (both on your machine already and those available to download), you can use the following command:

```
uv python list
```

Now that we have a working version of python downloaded that uv can use, let's starting building our virtual environment, also called "initializing" our environment. Because our terminal in VSCode is already located within the project folder we want to create a virtual environment for, we can use the following command:

```
uv init --python 3.11
```

You can use `uv init` without the python argument, but it's helpful to start by intentionally deciding which python environment you want to use. If you do not have that version of python installed, uv will install it for you.

Using `uv init` will initialize the virtual environment, defaulting to using the name of the project folder. In my case using the example above, the project folder is `uv_test`, so the virtual environment will be called that. If you want to only use uv for creating a virtual environment in the typical python  built-in `venv` approach, you can use `uv venv project-name` to do that. If you decide to take that approach, read [the documentation](https://docs.astral.sh/uv/pip/environments/) on the tradeoffs between the two approaches.

Within your folder, `uv` will have created the following files:

```
uv_test
├── .gitignore
├── .python-version
├── README.md
├── main.py
└── pyproject.toml
```

The main.py file contains a simple "Hello world" program. Try it out with `uv run`:

```bash
uv run main.py
# Hello from uv-test!
```

This command runs the main.py script, using the version of python that you indicated. Great! The start to our virtual environment has begun!

#### Connection with git

It is cool to note that using the command `uv init` also initializes a git repository if one is not already initialized in that project directory. For more on git, check out the [GitHub Set-up Guide](github_setup.md) and [GitHub Workflow Guide](github_workflow.md).

## Project Structure

***NOTE:** This part of the guide is adapted directly from the [uv documentation](https://docs.astral.sh/uv/guides/projects/#project-structure). All credit goes to the developers of uv!*

Let's start to dig a bit more into what happens when you initialize a uv environment by exploring one of the files that gets created when you initialize an environment: `pyproject.toml`.

### `pyproject.toml`

The `pyproject.toml` contains metadata about your project, including the project name, version and dependencies:

```toml
# pyproject.toml

[project]
name = "uv-test"
version = "0.1.0"
description = "Add your description here"
readme = "README.md"
requires-python = ">=3.11"
dependencies = []
```

In short, this is the list of instructions of how we would like our environment built. We can see immediately that the python version we used to initialize our environment is stored here in the `requires-python` variable.

When we initialize a virtual environment, we start with no listed dependencies -- the `dependencies` variable is an empty list. As we add packages to our virtual environment, this toml file will automatically update.

Let's try it. Say we are working on a standard data analysis task and we want to us pandas and geopandas.

#### **Quick Proxy Interlude**

In order to download packages, we need to add a few things to the .toml file in order to work with our proxy server correctly. Append the following to the bottom of the pyproject.toml file:

```toml
[tool.uv]
allow-insecure-host = ["pypi.org", "files.pythonhosted.org", "github.com"]
```

This will allow us to download packages successfully.

Next, I can use the following commands to add those packages to my virtual environment by doing the following:

```bash
uv add pandas geopandas
```

What this is doing is basically downloading and installing these packages into our virtual environment, more or less the same as `pip install pandas` but specific to this project only.

Now, let's check out our `pyproject.toml` file:

```toml
# pyproject.toml

[project]
name = "uv-test"
version = "0.1.0"
description = "Add your description here"
readme = "README.md"
requires-python = ">=3.11"
dependencies = [
    "geopandas>=1.1.1",
    "pandas>=2.3.1",
]

[tool.uv]
allow-insecure-host = ["pypi.org", "files.pythonhosted.org", "github.com"]
```

It now contains pandas and geopandas as listed dependencies. A few more things changed in our project folder when we did this. Let's take a look at the new files that were created:

```bash
uv_test
├── .venv           // new folder
│   ├── Scripts     // or bin if on macOS/linux
│   ├── lib
│   └── pyvenv.cfg
├── .python-version
├── README.md
├── main.py
├── pyproject.toml
└── uv.lock         // new file
```

### `.venv`

The `.venv` folder contains your project's virtual environment, a Python environment that is isolated from the rest of your system. This is where uv will install your project's dependencies. There are two main folders here with important information:

- `.venv/Scripts`: this folder contains executables like python.exe that allow you to run the python version relevant to this particular project. Often this is a redirect to another filepath on your system that already contains this python executable, but if you don't have that version of python installed, it could be a downloaded version.
- `.venv/lib`: this folder is where all the packages you add to the virtual environment are saved. There will be relevant folders for the packages you explicitly name in your .toml file (e.g. pandas and geopandas) as well as all the packages needed for those packages to run (e.g. numpy, pyproj, shapely, etc.)

See the [project environment](https://docs.astral.sh/uv/concepts/projects/layout/#the-project-environment) documentation for more details.

### `uv.lock`

`uv.lock` is a cross-platform lockfile that contains exact information about your project's dependencies. Unlike the pyproject.toml which is used to specify the broad requirements of your project (think of it like a general list of instructions -- go from home to work), the lockfile contains the exact resolved versions that are installed in the project environment (think of it like a detailed list of how to execute your instructions -- leave your house, walk to the street, turn left, walk 5 blocks, take a right, enter the subway, etc.).

The lockfile is **automatically created and updated** when you add or update your virtual environment, and **should not be edited manually**. It uses the pyproject.toml file as a guide to build itself.

That said, you can delete/replace the lock file easily as long as you have the toml file. Try this out -- delete the `uv.lock` file from your directory:

```bash
rm uv.lock
```

The `uv.lock` file is gone now, but let's build it:

```bash
uv sync
```

In this case, `uv` builds the lock file back from the `pyproject.toml` file effortlessly and quickly.

### Using the virtual environment

There are three ways that you can use the uv virtual environment, two from the command line and one using jupyter notebooks.

#### **1. Using `uv run`**

If you want to run a script, command, or Python shell using the virtual environment, the easiest way is:

```
uv run python your_script.py
```

This will build the virtual environment, and then use that environment to run the script itself. The pros of this approach is that it's really quick but can be harder to debug depending on what you're building.

#### **2. Spanning a terminal from within the virtual environment**

Instead of letting uv span the virtual environment on its own, you can do that manually.

In a Command Prompt terminal, you can run the following (assuming you are on a Windows machine, it's `source .venv\bin\activate` on a linux/macOS):

```
.venv\Scripts\activate.bat
```

This span a terminal that uses all the defaults that are specified in your .toml file. You'll know it was successful if you see the name of the environment (in my case uv-test) in parentheses:

<img width="331" height="31" alt="Screenshot 2025-08-14 at 11 50 58 AM" src="https://github.com/user-attachments/assets/aa08d22c-581a-44d6-9488-671a08c0a99e" />

When you are within the environment like this, you could run the same python script this way:
```
python -m your_script.py
```
This is what is returned to me if I try to run main, like I did before using `uv run python main.py`:

<img width="388" height="32" alt="Screenshot 2025-08-14 at 11 53 37 AM" src="https://github.com/user-attachments/assets/103c5c16-b822-478e-adf4-1e14b3233df3" />

The virtual environment maintained by `uv` has all your dependencies already downloaded, so you can just assume that is taken care of.

When you are ready to exit the environment, you can use the following command:
```
deactivate
```
You'll know you are out of the environment when you lose the environment name within the parentheses, like the following:

<img width="388" height="32" alt="Screenshot 2025-08-14 at 11 53 37 AM" src="https://github.com/user-attachments/assets/debae458-233d-472f-ba22-b5ff25d62ae4" />

#### **3. Using jupyter notebooks in VSCode and selecting the virtual environment as your kernel**

`uv` is compatible with using Jupyter notebooks, as documented in their [Using uv with Jupyter](https://docs.astral.sh/uv/guides/integration/jupyter/) guide.

We like using Jupyter notebooks within VSCode as it is the easiest way in our opinion to get the best of system set-up with the settings.json file, github integration, and more. For more on VSCode and that set-up, explore our [proxy configuration in python](proxy_python.md) guide.

In order to use jupyter notebooks within VSCode most easily, you need to add one more package to your virtual environment:

```
uv add --dev ipykernel
```

Next, you can use the virtual environment in notebooks by using the following steps:

1. Create or open any `.ipynb` file within your project folder
2. In the top-right corner of the notebook, click on Select Kernel (usually shows a Python interpreter name).

  <img width="505" height="257" alt="image" src="https://github.com/user-attachments/assets/24b8e0d6-e260-4be5-a274-0891e2ab2ae8" />
  
3. Look for the `.venv` environment in the list. Make sure that the .venv you are selecting is in the right project folder. Sometimes, especially if you are using uv for multiple projects, there will be other filepaths to different venv's here, so be sure to select the right one by inspecting the filepath next to the env name.

Now you can proceed as normal and use your jupyter notebook to experiment for your project, and all the packages you have downloaded using `uv` will be available in the notebook.

**Note:** If you are working and need to add a new package, you can use uv directly within the notebook. Within your jupyter notebook, you can add a new cell and use the command: 
```
!uv add [NEW PACKAGE NAME]
```
This will immediately add the package to the `pyproject.toml` file, change the uv.lock file, and make the package immediately available in your kernel without needing to restart it. You can then import the package as needed, and proceed. It's so fast and easy to use!

## What to keep (or not keep) in version control

Given the process described above, the most important file to keep in version control is `pyproject.toml`. Both the `.venv/` folder and the `uv.lock` file can be rebuilt using this file so this is the most important file to commit to your github repository.

## Tips and tricks for using `uv`

Here are a few niche things we've noticed from using `uv`:
- There is nothing restricting a project directory from having more than one venv setup so users should be cautious to ensure that they actually want that behavior, and that they need to activate/deactivate each accordingly ( i've run into messes like (venv1)(venv2) project where I don't know which is actually running.
