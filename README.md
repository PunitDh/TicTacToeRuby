# T1A3 Terminal Application - Unbeatable TicTacToe in Ruby

## Link to Repository
https://github.com/PunitDh/TicTacToeRuby
https://replit.com/@PunitDh/TicTacToeRuby

## Purpose and Scope
The application is a TicTacToe board game. The player places either an 'X' or and 'O' on a standard 3x3 square grid. The goal is to get three in a row, either horizontally, vertically or diagonally. It is possible to block an opponent's win. If no winners are declared, the game results in a draw..
The game allows both single-player and multi-player modes (locally). Both modes are quite straightforward. In either mode, the player is asked to enter their name. The computer then 'tosses a coin' (generates a random number) to determine who goes first.
The game then begins. The player is asked to enter inputs 

## Features
### Choosing between (1)-Player and (2)-Player Mode
Ability to choose between 1 or 2 player mode

### Artificial Intelligence and Simulation Mode


### Saving/Loading Games From File


## Help
### How to install and run the application
There are different ways to download and install the TicTacToe application. (**Note:** You must have ruby installed on the system in order to run this application.)

To install the latest ruby version, you can use the following command on a UNIX-based system such as a Mac:
    ```
    $ rbenv install
    ```
This will install the latest version of Ruby on the system.

Or, if using Windows, WSL or Linux, enter the following commands.
    
    > xcode-select --install
    > /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    > brew install rbenv
    > rbenv init
    

1. Then clone the git repository using the command:
    ``` wsl
    $ gh repo clone PunitDh/TicTacToeRuby
    ```
1. Alternatively, you can download the application as a .ZIP file from the repository link https://github.com/PunitDh/TicTacToeRuby.

    Simply click on `Code` and then `Download ZIP` to download all files in a ZIP file.

2. After that, open the command line terminal app.

    - If running from a UNIX system, Mac, LINUX distribution system such as (Ubuntu), navigate to the app folder, then type in command line:

    ```
    $ bundle update
    $ ./tictactoe
    ```

    - Alternatively, if using Windows, open Windows Powershell, navigate to the app folder, and type:
    ```
    > bundle update
    
    ```
    Any dependencies required by the application will be installed after you run the `bundle update` command.

    If the bundles don't get installed correctly, you can use the `gem install` commands to install the following Ruby gems manually:

    ```
    $ gem install tty-prompt
    $ gem install colorize
    $ gem install uuid
    $ gem install tty-table
    ```
3. Run the app by typing in the command line:
    If using UNIX, Mac, Linux, Ubuntu, WSL, simply run:
    ```
    $ ./tictactoe
    ```

    If using Windows Powershell:
    ```
    > ruby .\tictactoe
    ```
## Flow Chart
![](docs/control-flow.png)

## 