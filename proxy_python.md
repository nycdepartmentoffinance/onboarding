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

7. If at this point there is no python.exe on your machine, reach out to the City Help Desk to have Anaconda installed. 
8. Add the file path to python to your **PATH**, by following the instructions here:
[How to add Conda to PATH](https://stackoverflow.com/questions/44515769/conda-is-not-recognized-as-internal-or-external-command).

  **Note:** Before the last step of the stack overflow instructions, enter the following:
  ```
  config --set ssl_verify false
  ```

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

Now that python is successfully set up, we can configure our proxy settings in order to connect to the internet properly. To do this, we need to set `HTTP_PROXY` and `HTTPS_PROXY` as environmental variables in your local machine.

Like the instructions linked above, you need to:  
1. In Control Panel, type in **View advanced system settings**
2. Click on **Environment Variables...**
3. In the first "User variables" section, click on **New...**
4. Add HTTP_PROXY as:
```
http://bcpxy.nycnet:8080
```
It should look like this:

<img src="https://github.com/user-attachments/assets/1970bd03-5252-42df-b182-f292f5f5b6bf" style="width:600px;"/>

5. Add HTTPS_PROXY as:
```
https://bcpxy.nycnet:8080
```

It should look like the following after you add the variables:

<img src="https://github.com/user-attachments/assets/64887d6e-b505-4912-a1b4-94632a71c5d0" style="width:600px;"/>


To test if these were set correctly, you can check by opening the command prompt and entering the following:

```
echo %HTTP_PROXY%
```

It should return the value you just set it as.

### 4. Test proxy with pip
The following should work in the command prompt without any additional arguments (e.g. trusted host)
```
python -m pip install PACKAGE_NAME
```

If it's not working, you can install with trusted host like the following:
```
python -m pip install PACKAGE_NAME --trusted-host pypi.org --trusted-host files.pythonhosted.org 
```

