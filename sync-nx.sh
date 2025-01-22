#!/bin/bash

# Requires hostnames aliases correclty set in ~/.ssh/config
scp -o ConnectTimeout=3 ./.margot-nx-config ./.margot_remote_env pil1nx:~
scp -o ConnectTimeout=3 ./.margot-nx-config ./.margot_remote_env pil2nx:~
scp -o ConnectTimeout=3 ./.margot-nx-config ./.margot_remote_env pil3nx:~
scp -o ConnectTimeout=3 ./.margot-nx-config ./.margot_remote_env pil4nx:~
scp -o ConnectTimeout=3 ./.margot-nx-config ./.margot_remote_env pil5nx:~
scp -o ConnectTimeout=3 ./.margot-nx-config ./.margot_remote_env pil6nx:~
scp -o ConnectTimeout=3 ./.margot-nx-config ./.margot_remote_env pil7nx:~
scp -o ConnectTimeout=3 ./.margot-nx-config ./.margot_remote_env pil8nx:~
scp -o ConnectTimeout=3 ./.margot-nx-config ./.margot_remote_env pil9nx:~

