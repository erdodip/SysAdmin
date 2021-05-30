#!/bin/bash
# Write your SSH remote port forward tunnelling command here, e.g.
# ssh -TNi ../id_rsa -R <REMOTE_PORT>:localhost:<LOCAL_PORT> codecool@<REMOTE_IP>

autossh -vTNi ../id_rsa -R 13083:localhost:8083 codecool@18.184.218.192 || (sudo apt-get update && sudo apt-get install -y autossh && autossh -vTNi ../id_rsa -R 13083:localhost:8083 codecool@18.184.218.192)
