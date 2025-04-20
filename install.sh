echo "INSTALL SCRIPT RUNNING\n\nDO NOT CTRL C OUT OF THIS"
sleep 3
echo "STARTING INSTALL"

#starting
#!/bin/bash

# Update system packages
echo "Updating system packages..."
sudo apt-get update -y

# Install Python 3.8 if it's not installed
echo "Checking if Python 3.8 is installed..."
if ! command -v python3.8 &> /dev/null
then
    echo "Python 3.8 not found, installing..."
    sudo apt-get install python3.8 python3.8-dev python3.8-distutils -y
else
    echo "Python 3.8 is already installed."
fi

# Install pip for Python 3.8 if not installed
echo "Checking if pip for Python 3.8 is installed..."
if ! command -v python3.8 -m pip &> /dev/null
then
    echo "Pip for Python 3.8 not found, installing..."
    curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
    sudo python3.8 get-pip.py
    rm get-pip.py
else
    echo "Pip for Python 3.8 is already installed."
fi

# Install virtualenv if it's not installed
echo "Checking if virtualenv is installed..."
if ! command -v virtualenv &> /dev/null
then
    echo "virtualenv not found, installing..."
    python3.8 -m pip install virtualenv
else
    echo "virtualenv is already installed."
fi

# Create a new virtual environment if it doesn't exist
if [ ! -d ".venv" ]; then
    echo "Creating virtual environment..."
    python3.8 -m venv .venv
else
    echo "Virtual environment already exists."
fi

# Activate the virtual environment
echo "Activating virtual environment..."
source .venv/bin/activate

# Upgrade pip and install dependencies
echo "Upgrading pip and installing dependencies..."
pip install --upgrade pip
pip install -r requirements.txt

# Install necessary system packages (development tools)
echo "Installing development tools and other necessary system packages..."
sudo apt-get install build-essential libssl-dev libffi-dev python3-dev -y

# Install MAVProxy dependencies
echo "Installing MAVProxy and dependencies..."
sudo apt-get install python3-pyserial python3-pynmeagps python3-mavproxy -y

# Inform the user the setup is complete
echo "Setup complete! Virtual environment is ready and dependencies have been installed."

# Install ModemManager (optional, if you face any issues)
echo "Installing ModemManager to avoid conflicts with MAVProxy..."
sudo apt-get install modemmanager -y

# Final message
echo "All required packages have been installed successfully. You can now run MAVProxy and connect to your Pixhawk."


