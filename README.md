MezeMacs
![image](https://github.com/Menezess42/MezEmacs/assets/67249275/c726348b-93bb-4eb0-8b4d-40c6f40afcd5)


It's important to know that I use Windows, so my configuration is based on my operating system.
## Setting Up a .Bat file
I created a .bat file and put the code below:
````bat
@echo off
start "" "path\to\emacs folder\bin\runemacs.exe" --daemon
# It is important to note that the path is not to the .emacs.d,
# but the path to the Emacs installation folder.
````
I opened the Windows Run dialog using the __⊞Win+R__ keys and typed "__shell:startup__". This opens a folder called "Startup," and anything you place in there will start along with the Windows initialization. I did this because Emacs with several packages on Windows takes a long time to open. So, without running the server, if we type "emacs test.txt," it will load everything again and won't have the same agility as "vim test.txt."

## Creating a shortcut
To connect to the server, I created a shortcut on the desktop by pressing "🖰Lef_bt," and in the field that asks for the item's path, I inserted the following code:
````
path\to\emacs folder\bin\emacsclientw.exe -c -n -a path\to\emacs folder\bin\runemacs.exe
# It is important to note that the path is not to the .emacs.d,
# but the path to the Emacs installation folder.
````
- __c:__ This argument tells emacsclientw.exe to create a new Emacs window if one is not already open.
- __n:__ This argument instructs emacsclientw.exe not to wait for Emacs to be closed before returning to the command prompt. This allows the command to continue running in the background while Emacs is open.
- __a: path\to\emacs__ folder\bin\runemacs.exe: This argument specifies the path to the runemacs.exe executable, which is used as an alternative to start Emacs if emacsclientw.exe is not available or cannot connect to an existing Emacs server.
## Adding mezemacs as a command in my PowerShell $PROFILE
To be able to use the command "mezemacs test.txt" in the terminal, I added the following function to my $PROFILE:
````powershell
function MezEmacs {
    param (
        [String]$File
    )
    if ($File) {
        & "path\to\emacs folder\bin\emacsclientw.exe" -c -n -a "path\to\emacs folder\bin\runemacs.exe" $File
    } else {
        & "path\to\emacs folder\bin\emacsclientw.exe" -c -n -a "path\to\emacs folder\bin\runemacs.exe"
    }
}
````
