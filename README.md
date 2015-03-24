# Server Chef

This project forms the base of all the server configurations using Chef as the platform.

To install a new server, please follow these instructions

# Install script

Download the `installserver` file from this project to the /root folder

	wget -P /root https://raw.githubusercontent.com/joshbmarshall/myservers/master/installserver
	sh /root/installserver

# Configure the chef parameters

Copy the config.json.src to config.json and edit to suit the new server.

# Run the chef

Start the chef for the first time, by executing /root/serverchef/dochef.sh

If all goes well, the server is now set up.
The system will automatically update and run chef daily.
