#!/bin/bash

# Requires hostnames aliases correclty set in ~/.ssh/config
scp -o ConnectTimeout=3 .margot-fc-config .margot_remote_env pil1fc:~
scp -o ConnectTimeout=3 .margot-fc-config .margot_remote_env pil2fc:~

