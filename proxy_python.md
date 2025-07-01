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

### 3. Download VSCode

If you are programming in python, I find it easier to program in an Integrated Development Environment (IDE) -- basically a software that helps you keep track of your work in a much more user friendly way.

The Microsoft IDE is called [VSCode](https://code.visualstudio.com/download) and is very similar to RStudio, Jupyter, or SAS Enterprise in that it has a place for you to write your code and a terminal or console where your code is being run and output is generated. The special benefit of VSCode is that it has a github extension that helps you keep track of the versioning of your code as it changes.















### 4. Configure VSCode

Next, open VSCode and go to File > Preferences > Settings or hold down `Ctrl` and `,` to get to the same screen.

Type in "proxy" in the `Search settings...` bar. You should see a few options. Under the "Http: Proxy Authorization" there should be a hyperlink that says, "Edit in settings.json". Click on that, which will open the settings.json file.

Now, we can update a few settings directly. Copy and paste the following into your settings.json file (changing the all CAPS inputs accordingly).

```
{
    "python.pythonPath": "[path\\to\\python]", #  my version: "C:\\ProgramData\\Anaconda3"
    "http.proxy": "http://[hostname]:[port]",
    "http.proxyStrictSSL": false,
    "terminal.integrated.env.windows": {
      "HTTP_PROXY": "http://[hostname]:[port]",
      "HTTPS_PROXY": "http://[hostname]:[port]",
    },
    "http.proxyAuthorization": null,
    "terminal.integrated.defaultProfile.windows": "Command Prompt",
    "http.proxySupport": "on",

    # any other customizations you want (optional)
    "workbench.colorTheme": "Visual Studio Light"
  }
```

After we have added this to settings.json, save the file and restart VSCode (either quit and re-open it or Ctrl++Shift+P to get to Command Pallette and type `Reload Window`).

This does a few things:
- tells VSCode where to look for your python executable
- tells VSCode how to connect to the proxy server, in order to download relevant extensions (e.g. Jupyter, GitHub, etc.)


### 5. Configure pip and git with the proxy server

Now that we have python and VSCode downloaded and installed, we can configure our tools to work with the proxy.

At this point you should take stock of which of these tools you have installed. You can check by typing each of the three programs (`git`, `pip`) into the command prompt terminal:
 ```
 git
 pip
 ```

If you do not have `pip` or `git` (or similarly get error messages when typing them into the terminal), then you need to install them. Explore installation instructions for github [here](https://github.com/nycdepartmentoffinance/onboarding/blob/main/github.md) or documentation for pip [here](https://pip.pypa.io/en/stable/user_guide/). Pip should be installed once you have Python, especially if you are getting it from an Anaconda distribution.  

Let's configure both git and pip at once (note: this will overwrite any configs you have for either program):
1. Download the raw file (download icon) for [this powershell script](proxy-config.ps1) and save it to your home directory. It basically sets the proxy settings for conda, pip and git all at once or can set them individually by passing in an optional argument specifying which ones to set up. 
2. In a command prompt terminal, type the following. If you do not include the last argument, it will configure conda, git and pip all at once. This is super valuable if you already have all three installed and ready to go. For me, I want to only configure pip and git so I used the collowing command:
```
powershell -ExecutionPolicy Bypass -File "proxy-config.ps1" http://[hostname]:[port] git-pip
```

### 6. Test proxy with pip

Now we can test the proxy configuration by trying to download a package using pip. The following should work in a command prompt terminal without any additional arguments (e.g. trusted host)
```
pip install ipykernel jupyterlab notebook
```

### 7. Test setup in jupyter notebook

Now that we have that set up, you can set up Jupyter in order to work in notebook files. Open a new .ipynb file by going to File > New File > Jupyter Notebook.

Once the new file opens, there should be a toggle on the top right corner that says "Select Kernel". Click on that. It should have the version of python that you pointed to in the python path in settings.json listed. If it doesn't, then go to "Select Another Kernel", "Python Environments..." and then your python version (with a path to your executable) should be listed. 

Next, select a version of Python to use in your kernel.

To make sure it's working correctly, add a code chunk in your new .ipynb file by pressing "+Code". Add the following to the code chunk and press the play button next to the top left hand corner.
```python
2 + 2
```
It should run, give a green check, and spit out 4 as the output below the code chunk.
