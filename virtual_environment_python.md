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



First, open up VSCode and open a new or existing project folder.




In a modern workflow, the environment’s dependencies are declared in a file—often a `pyproject.toml` for Python—that lists what packages the project requires. Let's say you want to create a virtual environment that uses has pandas, geopandas and 

Let's look at a quick example







A lock file can be generated to record the exact versions currently in use, which ensures that the same versions can be installed again in the future. The actual tools and libraries are stored in the environment’s directory (for Python, typically a .venv folder), which can be deleted and rebuilt from the dependency list at any time.

In effect, the virtual environment acts as a filter between your project and the rest of your system: any tool or library request first checks the environment’s folder, so the project always uses its own defined setup regardless of what is installed elsewhere.



why its helpful to use/what problem its solving



explanation of the list of packages (.toml, .lock, to env situation)

## Types of virtual environments  

why we are using uv

## `uv` installation process and set-up

how to install uv / what settings you need in place to work with the proxy server

## Using `uv`

how to create a new env with uv (init, add packages)

how to use an existing repo/env

## What to keep (or not keep) in version control

everything can be built from the toml file

.toml - yes
.lock - no
.venv/ folder - no

