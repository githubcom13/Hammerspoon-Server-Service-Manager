-- SECTION: Utility Functions
-- General-purpose functions used throughout the script

-- Function to execute shell commands and return the result
local function runShellCommand(command)
    local output, status = hs.execute(command, true)
    return output, status
end

-- Function to display notifications
local function notify(message, isError)
    local title = isError and "Service Manager - Error" or "Service Manager"
    local subtitle = isError and "An error occurred" or nil
    hs.notify.new({title=title, informativeText=message, subtitle=subtitle}):send()
end

-- Function to detect the installed PHP version
local function getPHPVersion()
    local output = runShellCommand("php -v")
    local version = output:match("PHP (%d+%.%d+)") -- Extracts the major and minor version (e.g., "8.3")
    return version or "8.3"  -- Default value if detection fails
end

-- Dynamically retrieve the installed PHP version
local phpVersion = getPHPVersion()

-- SECTION: Service Management
-- Functions related to starting, stopping, and checking the status of services

-- Function to check if a service is running and return its status
local function checkServiceStatus(service)
    local output = runShellCommand("brew services list | grep " .. service)
    if string.find(output, "started") then
        return "Started"
    else
        return "Stopped"
    end
end

-- Function to start a service with error handling
local function serviceStart(service)
    local _, status = runShellCommand("brew services start " .. service)
    if status then
        notify(service .. " has been started.")
    else
        notify("Failed to start " .. service .. ". Please check the service configuration.", true)
    end
    updateMenu()
end

-- Function to restart a service with error handling
local function serviceRestart(service)
    local _, status = runShellCommand("brew services restart " .. service)
    if status then
        notify(service .. " has been restarted.")
    else
        notify("Failed to restart " .. service .. ". Please check the service configuration.", true)
    end
    updateMenu()
end

-- Function to stop a service with error handling
local function serviceStop(service)
    local _, status = runShellCommand("brew services stop " .. service)
    if status then
        notify(service .. " has been stopped.")
    else
        notify("Failed to stop " .. service .. ". Please check the service configuration.", true)
    end
    updateMenu()
end

-- Function to start all services
local function startAllServices()
    serviceStart("httpd")
    serviceStart("nginx")
    serviceStart("php")
    serviceStart("mysql")
end

-- Function to restart all services
local function restartAllServices()
    serviceRestart("httpd")
    serviceRestart("nginx")
    serviceRestart("php")
    serviceRestart("mysql")
end

-- Function to stop all services
local function stopAllServices()
    serviceStop("httpd")
    serviceStop("nginx")
    serviceStop("php")
    serviceStop("mysql")
end

-- SECTION: Log Handling
-- Functions related to viewing and clearing log files

-- Function to open a log file in the Console app
local function openLog(logPath)
    hs.execute("open -a Console " .. logPath)
end

-- Function to clear a log file
local function logClear(logPath)
    runShellCommand("> " .. logPath)
    notify("Log file at " .. logPath .. " has been cleared.")
end

-- SECTION: Menu Creation
-- Functions to create and update the Hammerspoon menubar menu

-- Function to create the menu table for the menubar item
local function createMenuTable()
    return {
        { title = "Service Controls", menu = {
            { title = "Start All Services", fn = startAllServices },
            { title = "Restart All Services", fn = restartAllServices },
            { title = "Stop All Services", fn = stopAllServices },
            { title = "-" },
            { title = "Apache: " .. checkServiceStatus("httpd"), disabled = true },
            { title = "Start Apache", fn = function() serviceStart("httpd") end },
            { title = "Restart Apache", fn = function() serviceRestart("httpd") end },
            { title = "Stop Apache", fn = function() serviceStop("httpd") end },
            { title = "-" },
            { title = "Nginx: " .. checkServiceStatus("nginx"), disabled = true },
            { title = "Start Nginx", fn = function() serviceStart("nginx") end },
            { title = "Restart Nginx", fn = function() serviceRestart("nginx") end },
            { title = "Stop Nginx", fn = function() serviceStop("nginx") end },
            { title = "-" },
            { title = "PHP: " .. checkServiceStatus("php"), disabled = true },
            { title = "Start PHP", fn = function() serviceStart("php") end },
            { title = "Restart PHP", fn = function() serviceRestart("php") end },
            { title = "Stop PHP", fn = function() serviceStop("php") end },
            { title = "-" },
            { title = "MySQL: " .. checkServiceStatus("mysql"), disabled = true },
            { title = "Start MySQL", fn = function() serviceStart("mysql") end },
            { title = "Restart MySQL", fn = function() serviceRestart("mysql") end },
            { title = "Stop MySQL", fn = function() serviceStop("mysql") end },
        }},
        { title = "View Logs", menu = {
            { title = "Apache Access Log", fn = function() openLog("/opt/homebrew/var/log/httpd/access_log") end },
            { title = "Apache Error Log", fn = function() openLog("/opt/homebrew/var/log/httpd/error_log") end },
            { title = "Nginx Access Log", fn = function() openLog("/opt/homebrew/var/log/nginx/access.log") end },
            { title = "Nginx Error Log", fn = function() openLog("/opt/homebrew/var/log/nginx/error.log") end },
            { title = "MySQL Error Log", fn = function() openLog("/opt/homebrew/var/mysql/mysql.log") end },
            { title = "PHP Log", fn = function() openLog("/opt/homebrew/var/log/php-fpm.log") end },
        }},
        { title = "Manage Logs", menu = {
            { title = "Clear Apache Error Log", fn = function() logClear("/opt/homebrew/var/log/httpd/error_log") end },
            { title = "Clear Nginx Error Log", fn = function() logClear("/opt/homebrew/var/log/nginx/error.log") end },
            { title = "Clear MySQL Error Log", fn = function() logClear("/opt/homebrew/var/mysql/mysql.log") end },
            { title = "Clear PHP Log", fn = function() logClear("/opt/homebrew/var/log/php-fpm.log") end },
        }},
    }
end

-- Function to dynamically update the menu
function updateMenu()
    menuBar:setMenu(createMenuTable())
end

-- Initialize the menu
menuBar = hs.menubar.new()
menuBar:setTitle("Services")
updateMenu()