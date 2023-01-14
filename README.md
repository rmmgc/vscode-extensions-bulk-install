[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

_NOTE: Tested only on Mac_

# What it does

This script takes a `.txt` file that contains a list of VS Code extensions, separated by new line, and installs all of them.

Check `sample.txt` to see how input `.txt` file should be formatted.

# Why you might need this

Whenever you need to install more than one extension and do not want to do it via VS Code Interface.

It can be useful during environment setup. You can use it to quickly install all VS Code extensions from the old machine to the new one.

# How to use

Let's assume you want to install extensions you had on the old machine to the new one. First thing you have to do is to create a `.txt` file that will be used as an input for the script.

### Create input file
This file should contain a list of VS Code extensions you want to install. Run the following command, on the old machine, to generate the input file.

```
code --list-extensions > extensions-list.txt
```

Two things are going to happen here. First `code --list-extensions` will list all installed VS Code extensions, separated by new line, and output it. This output will then be saved into an `extensions-list.txt` file. Feel free to change file name.

And that's it, you now have a file that contains all your VS Code extensions ready to be used by the script. You can now share this file however you want.

### Run the script

There are different ways to run the script, but I would recommend [Single command](#single-command) way.

#### Single command

As the name implies, everything is done in one command.

```
curl -fsSL https://raw.githubusercontent.com/rmmgc/vscode-extensions-bulk-install/main/bulk-install.sh | sh -s <path_to_input_file>
```

Make sure to replace `path_to_input_file` with path to your input file where you have listed all your extensions.

#### Clone repo

Another way to run the script is to clone the repository.

```
git clone git@github.com:rmmgc/vscode-extensions-bulk-install.git
```

Now you can run the script directly from the repo directory.

```
sh <path_to_repo>/bulk-install.sh <path_to_input_file>
```

Make sure that paths are correctly specified.

#### Copy raw code

For whatever reason, you can also just copy the raw code, create a new script file, on your machine, and paste the code into it. Raw code  [available here](https://raw.githubusercontent.com/rmmgc/vscode-extensions-bulk-install/main/bulk-install.sh).
