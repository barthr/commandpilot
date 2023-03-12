## Commandpilot

*NOTE: This is a experimental script and can contain bugs or issues, no command is executed without the users consent*

<p align="center">
    <a href="https://asciinema.org/a/566707?autoplay=1"><img src="https://asciinema.org/a/566707.png"/></a>
</p>

Assistant to help with those pesky commands on how to do things. For example, how do you rsync files with progress from one computer to another

### Requirements:

- `OPENAI_API_KEY` environment variable
- Installation of jq (https://stedolan.github.io/jq/)
- Installation of gum (https://github.com/charmbracelet/gum)

### Installation

```bash
COMMAND_PILOT_PATH=~/.local/bin/commandpilot # or any path in your $PATH you would like, I like to use ~/.local/bin for my own "scripts" and "binaries"

# Download the script
wget https://raw.githubusercontent.com/barthr/commandpilot/master/command-pilot.sh -O $COMMAND_PILOT_PATH

# Set the correct permissions
chmod +x $COMMAND_PILOT_PATH 
```

Run it!

```bash
➜ commandpilot
> What command would you like help with?
```