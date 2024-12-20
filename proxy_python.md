# Proxy set-up for python


## Prerequisites: Install Python and Conda

Before proceeding, ensure that both **Python** and **Conda** are installed on your system and available in your system's **PATH**. This will allow you to use these tools from the command line or Anaconda Prompt.

### 1. Make sure Python and Conda are installed and added to your PATH

To verify if **Python** and **Conda** are properly installed and accessible from the command line, follow these steps:
1. Open the **Anaconda Prompt**.
2. Type the following command and press **Enter**:
  ```
  conda --version
  ```
3. If there is a version, then conda is installed and the filepath is on your PATH. If nothing is returned from the above, then you need to complete a few more steps.
4. Type the following command and press **Enter**:
  ```
  where conda
  ```
5. Add the filepath to conda to your path, by following the instructions here:  
[How to add Conda to PATH](https://stackoverflow.com/questions/44515769/conda-is-not-recognized-as-internal-or-external-command).

Repeat the above with `python` instead of `conda`.

### 2. Test to make sure that both conda and python are working correctly from Command Prompt
In a new session of command prompt (not Anaconda Prompt), type the following:
```
python
```
It should look a little something like this:

<img src="https://github.com/user-attachments/assets/9ad34208-0f95-4d49-b59a-456cdfe5d903" style="width:600px;"/>

It should open a new session of python. It might open the Microsoft Office Store. If it does, follow the instructions here for how to reset the default for the App execution aliases: [CMD opens Windows Store when I type 'python'](https://stackoverflow.com/questions/58754860/cmd-opens-windows-store-when-i-type-python).

Test the same for `conda` in a fresh command prompt session. It should look something like this:
<img src="https://github.com/user-attachments/assets/986c7c18-0c2e-40e5-981e-7c4bedfa48d6" style="width:600px;"/>

### 3. Set HTTP_PROXY and HTTPS_PROXY as environmental variables in your local machine

Like the instructions linked above, you need to:
1. in Control Panel, type in **advanced system settings**
2. Click on **Environment Variables...**
3. In the first "User variables" section, click on **New...**
<img src="https://github.com/user-attachments/assets/1970bd03-5252-42df-b182-f292f5f5b6bf" style="width:600px;"/>

4. Add HTTP_PROXY as:
```
http://bcpxy.nycnet:8080
```
5. Add HTTP_PROXY as:
```
https://bcpxy.nycnet:8080
```

It should look like the following after you add the variables:

<img src="https://github.com/user-attachments/assets/64887d6e-b505-4912-a1b4-94632a71c5d0" style="width:600px;"/>


### 4. Test proxy with pip
The following should work in the command prompt without any additional arguments (e.g. trusted host)
```
python -m pip install scikit-learn
```

If it's not working, you can install with trusted host like the following:
```
python -m pip install scikit-learn --trusted-host pypi.org --trusted-host files.pythonhosted.org 
```



### 4. Test proxy with conda

THIS ISN'T WORKING YET

```
conda config --set proxy_servers.http http://bcpxy.nycnet:8080
conda config --set proxy_servers.https https://bcpxy.nycnet:8080
```


