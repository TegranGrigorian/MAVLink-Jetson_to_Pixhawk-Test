echo "INSTALL SCRIPT RUNNING\n\nDO NOT CTRL C OUT OF THIS"
sleep 3
echo "STARTING INSTALL"

#starting
#!/bin/bash

echo "Updating system packages..."
sudo apt-get update -y

echo "Checking if Python 3.8 is installed..."
if ! command -v python3.8 &> /dev/null
then
    echo "Python 3.8 not found, installing..."
    sudo apt-get install python3.8 python3.8-dev python3.8-distutils -y
else
    echo "Python 3.8 is already installed."
fi

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

echo "Checking if virtualenv is installed..."
if ! command -v virtualenv &> /dev/null
then
    echo "virtualenv not found, installing..."
    python3.8 -m pip install virtualenv
else
    echo "virtualenv is already installed."
fi

if [ ! -d ".venv" ]; then
    echo "Creating virtual environment..."
    python3.8 -m venv .venv
else
    echo "Virtual environment already exists."
fi

echo "Activating virtual environment..."
source .venv/bin/activate

echo "Upgrading pip and installing dependencies..."
pip install --upgrade pip
pip install -r requirements.txt

echo "Installing development tools and other necessary system packages..."
sudo apt-get install build-essential libssl-dev libffi-dev python3-dev -y

echo "Installing MAVProxy and dependencies..."
sudo apt-get install python3-pyserial python3-pynmeagps python3-mavproxy -y

echo "Setup complete! Virtual environment is ready and dependencies have been installed."

echo "Installing ModemManager to avoid conflicts with MAVProxy..."
sudo apt-get install modemmanager -y

echo "All required packages have been installed successfully. You can now run MAVProxy and connect to your Pixhawk."


