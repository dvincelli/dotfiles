#!/bin/bash

[ -n "$SSH_AGENT_PID" ] || eval "$(ssh-agent -s)"
