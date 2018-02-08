# timewaster

## Important note:
The docker side of things is still being worked on.



Vagrant files to instantiate 3 VMs which run a Java demo env.
This leverages the sandbox configurations from Datadog.

The demo shows Java APM monitoring and Log monitoring.  This is done using agent 6.
Postgres monitoring is enabled for the postgres instance using agent 5.

When provisioning the VMs, the scripts always pull the latest agent (i.e. latest agent 6 and latest main-stream agent for the DB monitoring).

The generateload.sh script can be used to generate load.

## Demoing by VMs:
Vagrantfile contains the configuration to start the 3 VMs.
These 2 VMs are:
twui: has the UI for timewaster
twws: has the web service for timewaster
twdb: is the postgres DB for timewaster
They get created on a NAT network and have fixed IP addresses (would be nice to fix this... later).
For each VM, the Vagrantfile copies the data directory over to `/data` and I think that Vagrant maps its directory to /vagrant anyway.

Once the VM has been  created, vagrant runs the script for that VM - i.e. setup_<vmname> where <vmname> is twui, twws or twdb.
This script does the work of customising the VM.  For example the twdb script will create the user and create the table the demo app needs.

## VM-Specific notes
### TW Database
The agent is expected to be v5.
File locations are for V5 agent.
A custom host file is copied to /etc/hosts

### TW Web service
The agent is expected to be V6.
A custom host file is copied to /etc/hosts
Setting the variables for the Java Agent communication and other settings is done in setenv.sh which is copied from the data directory to /usr/share/tomcat8/bin/setenv.sh (Note that the directory had to be created by the script.)

### TW Web service
The agent is expected to be V6.
A custom host file is copied to /etc/hosts
Setting the variables for the Java Agent communication and other settings is done in setenv.sh which is copied from the data directory to /usr/share/tomcat8/bin/setenv.sh (Note that the directory had to be created by the script.)
