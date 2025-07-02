# Proxy set-up for python

Before proceeding with proxy set-up, ensure that **Python** is installed on your system and available in your system's **PATH**. This will allow you to use these tools from the command line.

### 1. Make sure Python is installed and added to your PATH

To verify if **Python** are properly installed and accessible from the command line, follow these steps:
1. Open the **Command Prompt**.
2. Type the following command and press **Enter**:
  ```
  python --version
  ```
3. If there is a version, then python is installed and the filepath to the executable (python.exe) is on your PATH. If nothing is returned from the above, then you need to complete a few more steps.
4. Type the following command and press **Enter**:
  ```
  where python
  ```
5. If nothing is returned, then you need to find out where the `python.exe` file is saved on your machine (assuming it is already installed). To do that, search `python.exe` and open the file location.
<img src="https://github.com/user-attachments/assets/2912c594-0c4b-41e6-b09c-db9cbcb36381" style="width:600px;"/>

6. Once it opens the file location, go to the top and copy the folder that the executable is in. In my case it's: `C:\ProgramData\Anaconda3` 

<img src="https://github.com/user-attachments/assets/079f2557-c749-47c7-a49b-998e020ef29e" style="width:600px;"/>

7. If at this point there is no python.exe on your machine, check in PowerShell. Open **PowerShell** by typing PowerShell in the Control Panel.

8. Once in PowerShell, type `py` to start a python session, and then type the following to look for the python.exe path:

  ```
  import sys
  sys.executable
  ```

It should return something like the following: 

<img src="https://github.com/user-attachments/assets/80a5099e-3fe8-4891-aa40-f93bb3bb0e9f" style="width:600px;"/>

After you are confident python is installed, proceed with the following steps to add the location of the python executable to your PATH.

9. In the Control Panel, search for where to edit your Environment Variables

<img src="https://github.com/user-attachments/assets/11466dba-0076-4e45-9164-b410da324c0c" style="width:600px;"/>

10. Click on "Environmental Variables..."

<img src="https://github.com/user-attachments/assets/1a298ab3-fe96-44eb-a850-8a6c01cb7498" style="width:600px;"/>

11. Select "Path" in the top table, and click on "Edit..."

<img src="https://github.com/user-attachments/assets/2ca566f4-65a9-49c1-9e6c-18951a2c83ae" style="width:600px;"/>

12. Add three new variables to the PATH based on the file path that you got from the command above, which for me were the following (aka the original path the command returned as well as two sub-folders: `\Scripts` and `\Library\bin`):

```
C:\ProgramData\Anaconda3
C:\ProgramData\Anaconda3\Scripts
C:\ProgramData\Anaconda3\Library\bin
```

<img src="https://github.com/user-attachments/assets/bafacf6e-9bb6-4991-82a1-a61facb915de" style="width:600px;"/>

  **Note:** The above was based on these stack overflow instructions: 
[How to add Conda to PATH](https://stackoverflow.com/questions/44515769/conda-is-not-recognized-as-internal-or-external-command).


### 2. Test to make sure that python is working correctly from Command Prompt
In a new session of command prompt, type the following:
```
python
```
It should look a little something like this:

<img src="https://github.com/user-attachments/assets/9ad34208-0f95-4d49-b59a-456cdfe5d903" style="width:600px;"/>

It should open a new session of python, but it might instead open the Microsoft Office Store. If it does, follow the instructions here for how to reset the default for the App execution aliases: [CMD opens Windows Store when I type 'python'](https://stackoverflow.com/questions/58754860/cmd-opens-windows-store-when-i-type-python).

To quit out of the python session, type the following command:

```
quit()
```

### 3. Download & Configure git 

If you haven't already, follow the [git set-up instructions](github_setup.md) to download and configure git correctly using the proxy server.

This guide will help you do a few different things:

- identify the correct proxy hostname and port to use for the rest of the set-up, found in the Proxy Settings screen on Windows under "Address".
- walk you through the steps/commands to tell git to use this proxy to connect to the internet.

Please complete this step before proceeding with the python set-up.

### 5. Downloading and saving your SSL certificate

This step is a bit tricky, but we'll walk you through every step of the way so don't fear!

If you are working with a city machine that connects to the internet through a proxy server, your browser (and other applications) are 

@TODO!!!







### 4. Download VSCode

If you are programming in python, I find it easier to program in an Integrated Development Environment (IDE) -- basically a coding environment that helps you keep track of your work in a much more user friendly way.

The Microsoft IDE is called [VSCode](https://code.visualstudio.com/download) and is very similar to RStudio, Jupyter, or SAS Enterprise in that it has a place for you to write your code and a terminal or console where your code is being run and output is generated. VSCode also has a lot of really helpful extensions -- GitHub, Jupyter, R, linters, etc. -- that make coding across langauges, in different styles, and under version control really easy. 

The rest of the set-up instructions assume you use VSCode code for a few reasons - we tried setting up the proxy connection in a couple of different coding environments (Jupyter, Spyder) and VSCode was the easiest to configure in one major step, most stably. Please feel free to use whatever IDE you prefer and if you want to add to this guide with more detailed instructions on that set-up, let us know!


### 5. Configure VSCode

Next, open VSCode and go to File > Preferences > Settings or hold down `Ctrl` and `,` to get to the same screen.

Type in "proxy" in the `Search settings...` bar. You should see a few options. Under the "Http: Proxy Authorization" there should be a hyperlink that says, "Edit in settings.json". Click on that, which will open the settings.json file. Now, we can update a few settings directly. 

Editing this file does a few things, telling VSCode:
- where to look for your python executable
- how to connect to the proxy server
- what commands to run when opening a jupyter notebook so that the configurations translate to that setting as well

Copy and paste the following template into your settings.json file. You will need to replace all the terms in brackets with the relevant information for you, including:

- **PATH_TO_PYTHON**: This is the path to the main python distribution that you want to use in VSCode (you might have multiple). You should use the python version that we found above. For example, I would include `"python.pythonPath": C:\\ProgramData\\Anaconda3", `. Note: this json file needs double slashes for filepaths, so you need to add those in (not just a copy paste of the above).
- **YOUR_HOSTNAME** and **YOUR_PORT**: this information from the Proxy settings, under "Address". A step-by-step guide of how to get this information is in the [github set-up guide](github_setup.md).
- **YOUR_PATH_TO_PEM_FILE**: This is the path to the certificate file you just created. For example I would include, `C:\\Users\\BoydClaire\\checkpoint-inspection.finance.nycnet.pem`
 
```
{
    "python.pythonPath": "YOUR_PATH_TO_PYTHON", 
    "http.proxy": "http://YOUR_HOSTNAME:YOUR_PORT", \\ 
    "http.proxyStrictSSL": false,
    "http.proxyAuthorization": null,
    "http.proxySupport": "on",
    "terminal.integrated.env.windows": {
        // proxy environmental variables
        "HTTP_PROXY": "http://YOUR_HOSTNAME:YOUR_PORT",
        "HTTPS_PROXY": "http://YOUR_HOSTNAME:YOUR_PORT",
        "REQUESTS_CA_BUNDLE": "YOUR_PATH_TO_PEM_FILE"
    },
    "jupyter.runStartupCommands": [
        // same exact information as before - you need to replave 
        "import os",
        "os.environ['HTTP_PROXY'] = 'http://YOUR_HOSTNAME:YOUR_PORT'",
        "os.environ['HTTPS_PROXY'] = 'http://YOUR_HOSTNAME:YOUR_PORT'",
        "os.environ['REQUESTS_CA_BUNDLE'] = 'YOUR_PATH_TO_PEM_FILE'"
    ],

    \\ other optional settings
    "workbench.colorTheme": "Visual Studio Light",
    "terminal.integrated.defaultProfile.windows": "Command Prompt" \\ I prefer it over powershell
}
```
*Note:* there are multiple places where these places of information should be replaced in the json file below. Before proceeding, make sure you have changed all the CAPS text to the right side of the equals signs or colons.

After we have edited the settings.json file reflecting all of your configurations, save the file and restart VSCode (either quit and re-open it or Ctrl++Shift+P to get to Command Pallette and type `Reload Window`).

**Working with the shell within VSCode**

*Quick important technical note:* This proxy configuration means that the terminal/shell (for powershell, command prompt, bash, etc.) within VSCode is set up with these configurations but **if you open one of these shells outside of VSCode, these settings will not apply**. For example, if I open a command prompt shell by just typing Command Prompt in my Windows search bar and open up a terminal that way, my proxy settings are not configured there because I am only setting then from within VSCode in the settings.json file above. 

Let's see if the environmental variables I saved above are accessable in my main computer configuration by testing it out in a command prompt terminal outside of VSCode:

{insert pic here}

Because these variables are not saved outside of VSCode, the REQUESTS_CA_BUNDLE is returning itself back to us, without anything saved.

That said, you can use any shell from VSCode by opening a terminal. When you Open VSCode, you can go to the top menu and select Terminal > New Teriminal. The default terminal that opens is what you can configure above with the "terminal.integrated.defaultProfile.windows" setting. In my case, I selected Command Prompt (cmd) so a cmd terminal will open. If I want a bash shell or a Powershell shell, I can go to the right side of my terminal in VSCode and click on the dropdown menu next to the `+` option. From there, I can click on any shell scripting language (bash, powershell, R, etc.).

Using command prompt within VSCode and after restarting the app with the settings.json file we just configured, let's try the same command again:

{insert pic here}

It worked! I'm getting a real value back. This is proof that from within VSCode you can save any environmental variables to this setting file and it will be recognized by any shell from within VSCode. 

The reason we have done it this way is to simplify the set-up process, without needing to add a bunch of global environmental variables using the [point and click interface with Windows](https://superuser.com/questions/949560/how-do-i-set-system-environment-variables-in-windows-10), which is a bit less replicable and harder to debug when environments are slightly different.

### 5. Configure pip with the proxy server

Now that Python and VSCode are installed, the last major step is to configure a package installer for Python with the proxy server so that you can install any packages you need for your work through the stable, secure internet connection via the proxy. There are a few different package installers  (pip, homebrew, conda) that can all be configured with proxy settings. 

**What is pip?**

**pip** is the package installer for Python. It connects to the Python Package Index (PyPI) or other specified repositories to download and install libraries that extend Python’s functionality—such as for data analysis, web development, or machine learning. When you run a command like `pip install pandas`, pip fetches the package and its dependencies over HTTPS, then installs them into your Python environment so they can be imported in your code.  Learn more in the [pip user guide](https://pip.pypa.io/en/stable/user_guide/). Pip relies on internet access and trusted SSL certificates, which means it requires some special configuration because we are working behind a proxy server.

Pip should be installed once you have Python, especially if you are getting it from an Anaconda distribution.  We prefer pip because it is native to the Anaconda python distribution and is much faster/lightweight than conda. 

To make sure pip is installed, first check the version of pip in a command prompt terminal:

```
pip --version
```

If you get an error and do not have pip installed, you can use the following command to ensure pip is installed with the `ensurepip` module that is built-in to python.

```
python -m ensurepip --upgrade
```

After this is completed, ensure pip is installed and see where by running this command again (from a command prompt terminal):
```
pip --version
```

Now that we have pip, we can use the config command to point it to access packages through the proxy server. In the same command prompt terminal, type the following:
```
pip config set global.proxy YOUR_HOSTNAME:YOUR_PORT
pip config set global.trusted-host "pypi.python.org global.trusted-host pypi.org global.trusted-host files.pythonhosted.org"
```

Now we can test the proxy configuration by trying to download a package using pip. The following should work in a command prompt terminal without any additional arguments (e.g. trusted host)
```
pip install pandas
```

### 6. Test setup in jupyter notebook



Okay! We are almost done! 

Now that we have everything set up, we can test to make sure different coding environments all are accessing the internet correctly.

First, Open up VSCode

```
pip install ipykernel jupyterlab notebook
```






you can set up Jupyter in order to work in notebook files. Open a new .ipynb file by going to File > New File > Jupyter Notebook.

Once the new file opens, there should be a toggle on the top right corner that says "Select Kernel". Click on that. It should have the version of python that you pointed to in the python path in settings.json listed. If it doesn't, then go to "Select Another Kernel", "Python Environments..." and then your python version (with a path to your executable) should be listed. 

Next, select a version of Python to use in your kernel.

To make sure it's working correctly, add a code chunk in your new .ipynb file by pressing "+Code". Add the following to the code chunk and press the play button next to the top left hand corner.
```python
2 + 2
```
It should run, give a green check, and spit out 4 as the output below the code chunk.
