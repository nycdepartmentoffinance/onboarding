# Proxy set-up for python

Welcome to our guide on how to set up a working coding environment for python configured to use the city's proxy server.

**Why do we need to do this?**

Our city machines connect to the internet through a proxy server which allows OTI to ensure our data and systems are secure. Because of this, we must configure our software/applications to connect to the internet through a proxy server in order to access the internet.

This is necessary because by default our systems are not yet configured to connect to the internet through the proxy. Without connecting to the proxy, using common tools like git, pip, and other software that requires a stable internet connection will fail due to a HTTPConnection error or timeout error when trying to access an internet connection (e.g., `connection timeout with port 22`). This is because our tools are attempting to access the internet directly, bypassing the proxy, which is used for all other network communication on our city machines.

<img src="https://github.com/user-attachments/assets/da801ff4-4940-454b-9d3b-e50a1f46351c" width="400">

In this guide, we'll walk you through the following steps:

- check for python installation and (if needed) add it to your PATH
- how to find your proxy information
- how to download and save your SSL certificate
- how to download and configure VSCode
- how to install and configure `pip`
- how to test to make sure everything has been set up properly

This might seem like a lot of steps, but it is worth it! If you have any questions or need additional support as your work through this guide, feel free to reach out to City HelpDesk directly or email me at boydclaire@finance.nyc.gov.

## Make sure Python is installed and added to your PATH

Before proceeding with proxy set-up, ensure that **Python** is installed on your system and available in your system's **PATH**. To verify if **Python** is properly installed and accessible from the command line, follow these steps:

1. Open the **Command Prompt** (you can open it by typing it into Window's search bar).
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

## Test to make sure that python is working correctly from Command Prompt

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

## Find your proxy information

1. Search `Proxy` in the Control Panel on your Windows machine to open your proxy settings.
   <img src="https://github.com/user-attachments/assets/1306debc-1169-48d8-ab7e-fc2ff42aa80e" width="400">

2. Under "Manual proxy setup", there should be some information about your configuration.

  <img src="https://github.com/user-attachments/assets/74b2f930-98a5-4253-a938-a95c4d6fe289" width="400">

3. Take a look at the contents of the "Address" configuration. It should include the following information, with likely repeats of the hostname and ports.

```
http=[hostname]:[port];https=[hostname]:[port];ftp=[hostname]:[port];Socks=[hostname]:[port]
```

4. The most important part here to note is the hostname and port for the HTTP and the HTTPS proxy. Copy this information because we'll need it in a few steps.

## Download and saving your SSL certificate

An SSL certificate is a file (in our case a `.pem` file) that helps keep your connection to a website secure. It proves the website is real and allows information to be encrypted, so others can’t see what you send or receive. If a site doesn’t have a trusted certificate, you might see a security warning or get blocked from connecting.

You need **both the proxy information and the `.pem` file** because they serve different purposes in secure internet access:

- The **proxy information** tells your tools (like `pip` or Python) **how to reach the internet**—it acts like a middleman for all your web traffic.
- The **`.pem` file** contains the **security certificate** that your system needs to **trust the proxy**. Without it, secure connections (like HTTPS requests) may fail because the proxy’s certificate isn’t recognized by default.

In short, the proxy lets you connect, and the `.pem` file ensures that connection is trusted and secure.

**Accessing and saving your SSL certificate (or `.pem` file)**

Start by opening up Microsoft Edge and typing in the following to the browser:

```
edge://certificate-manager/localcerts/platformcerts
```

A screen with all of the certificates configured for your machine should pop up. There should be a blue botton called "Export". Click on that. The default name of the file is `"trusted_certs"`. Edit that to `"trusted_certs.pem"` and save it somewhere local. I navigated to my user drive and saved it there: `C:\Users\BoydClaire`.

Next, open up File Explorer, navigate to that folder, and open up the .pem file. It should look something like this:

```
-----BEGIN CERTIFICATE-----
sdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdf
-----END CERTIFICATE-----
-----BEGIN CERTIFICATE-----
sdf;oaiehrtq;welinfoSIDjfosirtho'eirf'isdc
-----END CERTIFICATE-----
-----BEGIN CERTIFICATE-----

{continued}.....
```

This means that you saved the `.pem` file correctly and you're on the right track. If when you click on the file and it opens up a security certificate, the file was saved as a different format (`.crt`). Export the file again as a `.pem` file and make sure the format is similar to the above.

## Download VSCode

If you are programming in python, I find it easier to program in an Integrated Development Environment (IDE) -- basically a coding environment that helps you keep track of your work in a much more user friendly way.

The Microsoft IDE is called [Visual Studio Code (VSCode)](https://code.visualstudio.com/) and is very similar to RStudio, Jupyter, or SAS Enterprise in that it has a place for you to write your code and a terminal or console where your code is being run and output is generated. VSCode also has a lot of really helpful extensions -- GitHub, Jupyter, R, linters, etc. -- that make coding across langauges, in different styles, and under version control really easy.

The rest of the set-up instructions assume you use VSCode code for a few reasons. We tried setting up the proxy connection in a couple of different coding environments (Jupyter, Spyder) and VSCode was the easiest to configure in one major step, most stably. Please feel free to use whatever IDE you prefer and if you want to add to this guide with more detailed instructions on that set-up, let us know!

To download VSCode, you need to:

- [download the installer](https://code.visualstudio.com/download) for VSCode
- click on the downloaded `.exe` file in your Downloads folder
- click through the Installation Guide

This should only take a few minutes and VSCode should be ready to use!

## Configure VSCode

Now, we need to configure VSCode to work with our proxy and use our SSL certificate to access the internet.

Start by openning VSCode and go to File > Preferences > Settings or hold down `Ctrl` and `,` to get to the same screen.

Type in "proxy" in the `Search settings...` bar. You should see a few options. Under the "Http: Proxy Authorization" there should be a hyperlink that says, "Edit in settings.json". Click on that, which will open the `settings.json` file. Now, we can update a few settings directly.

Editing this file does a few things, including telling VSCode:

- where to look for your python executable
- how to connect to the proxy server
- what commands to run when opening a jupyter notebook so that the configurations translate to that setting as well

If there is anything in the `settings.json` file already, delete it. Then, copy and paste the following template into your newly opened `settings.json` file:

```
{
    "python.pythonPath": "YOUR_PATH_TO_PYTHON",
    "http.proxy": "http://YOUR_HOSTNAME:YOUR_PORT",
    "http.proxyStrictSSL": false,
    "http.proxyAuthorization": null,
    "http.proxySupport": "on",
    "terminal.integrated.env.windows": {
        // proxy environmental variables
        "HTTP_PROXY": "http://YOUR_HOSTNAME:YOUR_PORT",
        "HTTPS_PROXY": "http://YOUR_HOSTNAME:YOUR_PORT",
        "REQUESTS_CA_BUNDLE": "YOUR_PATH_TO_PEM_FILE",
        "SSL_CERT_FILE": "YOUR_PATH_TO_PEM_FILE"
    },
    "jupyter.runStartupCommands": [
        // same exact information as before - you need to replace
        "import os",
        "os.environ['HTTP_PROXY'] = 'http://YOUR_HOSTNAME:YOUR_PORT'",
        "os.environ['HTTPS_PROXY'] = 'http://YOUR_HOSTNAME:YOUR_PORT'",
        "os.environ['REQUESTS_CA_BUNDLE'] = 'YOUR_PATH_TO_PEM_FILE'",
        "os.environ['SSL_CERT_FILE'] = 'YOUR_PATH_TO_PEM_FILE'",
        "! pip install truststore",
        "import truststore",
        "truststore.inject_into_ssl()"
    ],

    // other optional settings
    "workbench.colorTheme": "Visual Studio Light",
    "terminal.integrated.defaultProfile.windows": "Command Prompt"
}
```

Next, you will need to replace all the terms in ALL_CAPS with the relevant information for you, including:

- **PATH_TO_PYTHON**: This is the path to the main python distribution that you want to use in VSCode (you might have multiple). You should use the python version that we found above. For example, I would include `"C:/ProgramData/Anaconda3"`. Note: this json file needs double slashes for filepaths, so you need to add those in (not just a copy paste of the above).
- **YOUR_HOSTNAME** and **YOUR_PORT**: this information from the Proxy settings, under "Address".
- **YOUR_PATH_TO_PEM_FILE**: This is the path to the certificate file you just created. For example I would include, `"C:/Users/BoydClaire/trusted_certs.pem"`

Common errors you might come across:
- There are multiple places where these places of information should be replaced in the json file below. Before proceeding, make sure you have changed all the CAPS text to the right side of the equals signs or colons to your relevant information.
- If you copy and paste the filepath from your File Explorer your file path will use `\\` instead of `/`. This will not work correctly. Make sure that the filepath uses forward slashes (`/`) instead.

After we have edited the `settings.json` file reflecting all of your configurations, save the file and **restart VSCode** (either quit and re-open it or Ctrl++Shift+P to get to Command Pallette and type `Reload Window`).

Great job! Now your VSCode is configured!

**IMPORTANT NOTE: These settings are isolated to VSCode**

This proxy configuration means that the terminal/shell (for powershell, command prompt, bash, etc.) within VSCode is set up with these configurations but **if you open one of these shells outside of VSCode, these settings will not apply**. For example, if I open a command prompt shell by just typing Command Prompt in my Windows search bar and open up a terminal that way, my proxy settings are not configured there because I am only setting them from within VSCode in the settings.json file above.

Let's see if the environmental variables I saved above are accessable in my main computer configuration by testing it out in a command prompt terminal outside of VSCode:

<img src="https://github.com/user-attachments/assets/6a7f07d2-8509-4556-a542-e7853bb0d8c4" width="400">

Because these variables are not saved outside of VSCode, the HTTP_PROXY is returning itself back to us, without any value saved.

That said, you can open any kind of terminal from within VSCode with these correct configurations. When you open VSCode, you can go to the top menu and select Terminal > New Teriminal. The default terminal that opens is what you can configure above with the `"terminal.integrated.defaultProfile.windows"` setting. In my case, I selected Command Prompt (cmd) so a cmd terminal will open. If I want a bash shell or a Powershell shell, I can go to the right side of my terminal in VSCode and click on the dropdown menu next to the `+` option. From there, I can click on any shell scripting language (bash, powershell, R, etc.).

Using command prompt within VSCode and after restarting the app with the settings.json file we just configured, let's try the same command again:

<img src="https://github.com/user-attachments/assets/c0fcc38f-83c5-45fe-bf95-2af6e2a4b6ad" width="400">

It worked! I'm getting a real environmental variable value I want back. This is proof that from within VSCode you can save any environmental variables to this settings.json file and it will be recognized by any shell from within VSCode.

The reason we have done it this way is to simplify the set-up process, without needing to add a bunch of global environmental variables using the [point and click interface with Windows](https://superuser.com/questions/949560/how-do-i-set-system-environment-variables-in-windows-10), which is a bit less replicable and harder to debug when environments are slightly different. There are pros and cons to this approach, so feel free to customize as needed.

## Configure pip with the proxy server

Now that Python and VSCode are installed, the last major step is to configure a package installer for Python with the proxy server so that you can install any packages you need for your work through the stable, secure internet connection. There are a few different package installers (pip, homebrew, conda) that can all be configured with proxy settings.

**What is pip?**

**pip** is the package installer for Python. It connects to the Python Package Index (PyPI) or other specified repositories to download and install libraries that extend Python’s functionality—such as for data analysis, web development, or machine learning. When you run a command like `pip install pandas`, pip fetches the package and its dependencies over HTTPS, then installs them into your Python environment so they can be imported in your code. Learn more in the [pip user guide](https://pip.pypa.io/en/stable/user_guide/). Pip relies on internet access and trusted SSL certificates, which means it requires some special configuration because we are working behind a proxy server.

Pip should be installed once you have Python, especially if you are getting it from an Anaconda distribution. We prefer pip because it is native to the Anaconda python distribution and is much faster/lightweight than conda.

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

Now that we have pip, we can use the config command to point it to access packages through the proxy server. In the same command prompt terminal, type the following (replacing YOUR_HOSTNAME and YOUR_PORT with the values you found in your proxy settings):

```
pip config set global.proxy YOUR_HOSTNAME:YOUR_PORT
pip config set global.trusted-host "pypi.python.org pypi.org files.pythonhosted.org test.pypi.org"
```

To double check that your configurations are saved you can always use the command:

```
pip config list
```

Now we can test the proxy configuration by trying to download a package using pip. The following should work in a command prompt terminal without any additional arguments (e.g. trusted host):

```
pip install pandas
```

`pandas` is just an example -- it should work with any pacakge name.

Congratuations! Pip is now successfully installed and configured!

## Testing our setup

Okay! We are almost done!

Now that we have everything set up, we can test that python on its own and jupyter notebooks with VSCode both accessing the internet correctly.

**Python**

First, Open up VSCode and open a new Command Prompt terminal by clicking on Terminal > New Terminal. Let's test our internet connection by making a simple request to `https://www.google.com`.

Start by downloading a package from pip called `requests`:

```
pip install requests
```

Next, let's start a python session by typing `python`.

Within the python session, type the following:

```
import requests
response = requests.get("https://www.google.com", timeout=5)
response.status_code
```

If the internet connection through the proxy is set up correctly, then you should get a `200` status code. Congrats! Python is set up correctly!

If you are running a more recent version of Python (~3.13), you might hit an error like this:

```
urllib3.exceptions.MaxRetryError: HTTPSConnectionPool(host='www.google.com', port=443): Max retries exceeded with url: / (Caused by SSLError(SSLCertVerificationError(1, '[SSL: CERTIFICATE_VERIFY_FAILED] certificate verify failed: Missing Authority Key Identifier (_ssl.c:1028)')))
```

This is because our certification file does not have the Authority Key Identifier, which is required for new versions of OpenSSL (3.0.10+) which is the default for newer versions of Python. To check if this is the problem, you can summarize the `.pem` file components by using the command:

```
openssl x509 -in PATH_TO_PEM_FILE -noout -text
```

This will print a summary to the console. It should have a section like this in order to work correctly with the newest versions of openssl:

```
X509v3 extensions:
    X509v3 Authority Key Identifier:
        keyid://////////////////////
```

But, our certificates may only have the following under `X509v3 extensions`:

```
X509v3 extensions:
    X509v3 Basic Constraints: critical
        ///////////
    X509v3 Key Usage:
        ///////////
```

While we update the certificates to accomodate this issue, we can use the truststore package in python to help us mitigate this issue. Use the following code slightly revised code to check for a stable internet connection:

```
import truststore
truststore.inject_into_ssl()

import requests
response = requests.get("https://www.google.com", timeout=5)
response.status_code
```

If you get a `200` status code, you are all set up!!

**_Note for Python 3.13+ users_**: For now, you will need to run these two lines of code at the beginning of your scripts to make sure the proxy set up is configured correctly.

**Jupyter Notebooks**

Now that python is correctly configured, let's ensure this is true for Jupyter notebooks as well.

First, install the necessary packages for ipython kernels and jupyter using pip (this might take like ~10-15 minutes, so don't worry if it installs for awhile):

```
pip install ipykernel jupyterlab notebook
```

Next, let's open a new .ipynb file by going to File > New File > Jupyter Notebook.

Once the new file opens, there should be a toggle on the top right corner that says "Select Kernel". Click on that. It should have the version of python that you pointed to in the python path in `settings.json` listed. If it doesn't, then go to "Select Another Kernel", "Python Environments..." and then your python version (with a path to your executable) should be listed. Select a version of Python to use in your kernel.

To make sure it's working correctly, add a code chunk in your new .ipynb file by pressing "+Code". Add the following to the code chunk and press the play button next to the top left hand corner.

```python
2 + 2
```

It should run, give a green check, and spit out 4 as the output below the code chunk.

Great! Base python is working.

Now, let's try the same code chunk from before to access the internet.

```python
import requests
response = requests.get("https://www.google.com", timeout=5)
response.status_code
```

You should get the same 200 status code.

## You did it!

Congratulations!! You made it!! Everything is successfully configured and you're ready to use python to your heart's content!!
