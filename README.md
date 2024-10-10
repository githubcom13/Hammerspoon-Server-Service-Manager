
# Hammerspoon-Server-Service-Manager

A Hammerspoon script for managing Apache, Nginx, PHP, and MySQL server services directly from the macOS menu bar.

## Features
- Start, stop, and restart server services (Apache, Nginx, PHP, MySQL).
- View and clear service logs.
- Open configuration files for each service.
- Display notifications for service status changes.
- Designed to work seamlessly with the macOS menu bar.

## Requirements
- **Hammerspoon**: Make sure you have Hammerspoon installed on your Mac. You can download it from [Hammerspoon.org](https://www.hammerspoon.org).
- **Homebrew**: This script uses `brew` to manage the services, so Homebrew must be installed on your system. You can install Homebrew using the following command:
  ```bash
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  ```

## Installation
1. **Clone the repository**:
   ```bash
   git clone https://github.com/githubcom13/Hammerspoon-Server-Service-Manager.git
   ```

2. **Copy the script to your Hammerspoon configuration**:
   Move the content of the repository to your Hammerspoon configuration directory:
   ```bash
   cp Hammerspoon-Server-Service-Manager/init.lua ~/.hammerspoon/
   ```

3. **Reload Hammerspoon**:
   Open Hammerspoon and click on the "Reload Config" button or use the following command:
   ```lua
   hs.reload()
   ```

## Usage

The script adds a menu bar icon called "Services" to your macOS menu bar.
Click on the "Services" icon to:
- Start, stop, or restart individual services.
- View and clear logs for Apache, Nginx, PHP, and MySQL.
- Open configuration files for easy editing.

## Setting up Hammerspoon with the Lua Code

To integrate the Lua code with Hammerspoon, follow these steps:

1. **Download the `init.lua` file**:
   Make sure you have the `init.lua` file in your project directory. This file contains the necessary Lua code to manage your server services.

2. **Copy the `init.lua` file to the Hammerspoon configuration directory**:
   Run the following command in your terminal to move the `init.lua` file to the Hammerspoon configuration folder:
   ```bash
   cp init.lua ~/.hammerspoon/
   ```

3. **Reload the Hammerspoon configuration**:
   Open Hammerspoon and reload the configuration by clicking on the Hammerspoon icon in the menu bar and selecting "Reload Config," or run the following command in the Hammerspoon console:
   ```lua
   hs.reload()
   ```

4. **Verify the setup**:
   After reloading, you should see the "Services" menu in your macOS menu bar, allowing you to manage Apache, Nginx, PHP, and MySQL services directly.

## Menu Previews

### Service Controls Menu
![Service Controls Menu](images/menu-services.png)

### View Logs Menu
![View Logs Menu](images/menu-logs.png)

### Configuration Menu
![Configuration Menu](images/menu-config.png)

## Configuration
- You can modify the services managed by this script by editing the `init.lua` file.
- To change the PHP version detected by the script, update the command in the `getPHPVersion()` function.

## Troubleshooting
- **Service Not Starting**: Make sure that the services are installed via Homebrew using `brew install httpd`, `brew install nginx`, `brew install php`, and `brew install mysql`.
- **Log Files Not Found**: Verify the paths to log files in the `init.lua` file. Paths might differ depending on your Homebrew installation.

## Contributing
Contributions are welcome! Please follow these steps to contribute:
1. Fork the repository.
2. Create a new branch (`git checkout -b feature-branch`).
3. Commit your changes (`git commit -am 'Add new feature'`).
4. Push to the branch (`git push origin feature-branch`).
5. Open a Pull Request.

## License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgements
- [Hammerspoon](https://www.hammerspoon.org) for their powerful automation tools.
- [Homebrew](https://brew.sh) for package management on macOS.
