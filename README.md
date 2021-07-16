# Beaver

Hello there, how are you?

I am working on an executable terminal file to run my C++ scripts, so I thought, why not share it?

So, what you can do with this executable file? Or, as I prefer to call it, beaver?

- Create the template of your projects, all you need to do is to call 'beaver create'

- Run your C++ project with 'beaver run' or just build it if you want to with 'beaver compile' (»Requires the step 'beaver create')

- And a lot of other stuff because this file is powered by premake :D

But, for that, we have to set beaver in your pc, so let's get started.

---

### Setting up:

[Linux](#linux)

Sorry, but I didn't have adapted, yet, the beaver for Windows :(

---

#### Linux

We have to

- [Create directory for beaver](#create-directory-for-beaver)

- [Set beaver's path](#set-beaver's-path)

- [Try it](#try-it)

#### Create directory for beaver

First you need to do is to open your terminal and type:

```shell
mkdir ~/beaver
```

This will create the folder that will keep the beaver.

After, download beaver and put it in this folder unziped.

For last, trade the name 'beaver' to '.beaver' just to hide the folder.

```shell
mv ~/beaver ~/.beaver
```

#### Set beaver's path

To set beaver's path, we have to change a file, the .bashrc. Generally, it is stored in /home/user_session folder.

```shell
nano ~/.bashrc
```

After you have opened it, write at the end of the file:

```shell
export PATH=$PATH:~/.beaver
```

At last, we just need to give permission to beaver, just writing in the terminal:

```shell
chmod +x beaver
```

Now, just write beaver in the terminal and should show up something like:

```
Enter 'beaver action' where action is one of the following:

create            Will create the resources needed to a new project into the current directory
delete            Will delete all project files. Be careful
clean             Will delete all compilable and executable files
compile           Will generate make file then compile using the make file.
run               Will generate make file then compile using the make file then run the project
clean             Remove all binaries and intermediate binaries and project files.
codelite          Generate CodeLite project files
gmake2            Generate GNU makefiles for Linux
vs2005            Generate Visual Studio 2005 project files
vs2008            Generate Visual Studio 2008 project files
vs2010            Generate Visual Studio 2010 project files
vs2012            Generate Visual Studio 2012 project files
vs2013            Generate Visual Studio 2013 project files
vs2015            Generate Visual Studio 2015 project files
vs2017            Generate Visual Studio 2017 project files
vs2019            Generate Visual Studio 2019 project files
xcode4            Generate Apple Xcode 4 project files
```

#### Try it

Create a folder to store your C++ project, move to that folder and create a project

```shell
mkdir ~/Documents/HelloWorld
cd ~/Documents/HelloWorld
beaver create
```

Then, just run the project :D

```shell
beaver run
```

For more information about beaver, type

```shell
beaver help
```

---

And that is it, I hope that beaver can help you to manage you C++ projects :D
