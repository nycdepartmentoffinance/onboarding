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

### 3. Set HTTP_PROXY and HTTPS_PROXY as environmental variables in your local machine

Now that python is successfully set up, we can configure our proxy settings in order to connect to the internet properly. To do this, we need to set `HTTP_PROXY` and `HTTPS_PROXY` as environmental variables in your local machine. Ask Claire or another DOF team member for the hostname and port for our proxy.

Like the instructions linked above, you need to:  
1. In Control Panel, type in **View advanced system settings**
2. Click on **Environment Variables...**
3. In the first "User variables" section, click on **New...**
4. Add HTTP_PROXY as:
```
http://[hostname]:[port]
```

5. Add HTTPS_PROXY as:
```
https://[hostname]:[port]
```

To test if these were set correctly, you can check by opening the command prompt and entering the following:

```
echo %HTTP_PROXY%
```

It should return the value you just set it as.


### 4. Configure conda, pip and git with proxy
Now that we have python ready, we can configure our tools to work with the proxy.

At this point you should take stock of which of these tools you have installed. For conda, you can check by typing each of the three programes (`git`, `conda`, `pip`) into the command prompt terminal:
 ```
 conda
 ```
If nothing appears for conda, repeat the instructions listed for python above but with conda. If you do not have `pip` or `git` (or similarly get error messages when typing them into the terminal), then you need to install them. Explore installation instructions for github [here](https://github.com/nycdepartmentoffinance/onboarding/blob/main/github.md) or documentation for pip [here](https://pip.pypa.io/en/stable/user_guide/). Pip should be installed once you have Python, especially if you are getting it from an Anaconda distribution.  

Let's say we have pip installed, and want to proceed with setting up the proxy with just pip. 
1. Download the raw file (download icon) for [this powershell script](https://github.com/nycdepartmentoffinance/conda-git-pip-proxy/blob/master/cpg-config.ps1) and save it to your home directory. It basically sets the proxy settings for conda, pip and git all at once or can set them individually by passing in an optional argument specifying which ones to set up. 
2. In a powershell terminal, type the filepath of the file, the name of the proxy, and then the program you want to configure. If you do not include the last argument, it will configure conda, git and pip all at once. This is super valuable if you already have all three installed and ready to go. For me, it was:
```
cpg-config.ps1 http://[hostname]:[port] pip 
```
You may get the following error message when trying to run this powershell script.

<img src="https://github.com/user-attachments/assets/330b32d7-54ca-477d-8db6-85e9aaab9166" style="width:1000px;"/>

If you do, use the following command to bypass the execution policy:
```
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
```
After doing this, re-run the line of code above and it should work.

### 5. Test proxy with pip

Now we can test the proxy configuration by trying to download a package using pip. The following should work in a command prompt terminal without any additional arguments (e.g. trusted host)
```
python -m pip install PACKAGE_NAME
```

Now you're done! Congrats on making it through all these tedious steps!
