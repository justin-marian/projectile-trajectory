#!/bin/bash

# Set correct permissions on directory
chmod 0700 /run/user/1000/

BASE_DIR=../
OUTPUT_DIR="$BASE_DIR/output"
IMAGES_DIR="$OUTPUT_DIR/images"
LOG_FILE="$OUTPUT_DIR/log.txt"

# Define colors
RED='\033[0;31m'
BLUE='\033[0;34m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

display_instructions() {
    echo -e "===================================================================================="
    echo -e "                          ${GREEN}Projectile Trajectory Simulation${NC}             "
    echo -e "===================================================================================="
    echo -e "         This script will run tests to simulate the trajectory of a projectile.     "
    echo -e "      ${RED}Please ensure that Octave is installed and accessible from the command line.${NC}"
    echo -e "  The script will generate random initial velocity and launch angle for each test.  "
    echo -e "               After running the tests, you will have the option:                    "
    echo -e "                       ${GREEN}execute test${NC}, ${BLUE}clean up log${NC}, or ${RED}exit${NC}."
    echo -e "===================================================================================="
    echo
}

run_test() {
    num_tests=1
    mkdir -p ../output

    echo -e "${GREEN}Running test...${NC}"

    for ((i=1; i<=$num_tests; i++)); do
        # Generate random initial velocity and launch angle
        v0=$(shuf -i 10-500 -n 1)
        alpha0=$(shuf -i 6-89 -n 1)

        # Run Octave script to simulate trajectory
        octave --eval "projectile_trajectory($v0, $alpha0)"

        # Rename the resulting PNG images with an index to identify the test
        if [[ $i != 1 ]]; then
            echo -e "${GREEN}Running test $i${NC}"
            mv ${IMAGES_DIR}/velocity_position_curve.png \
                ${IMAGES_DIR}/velocity_position_curve_$i.png
            mv ${IMAGES_DIR}/trajectory_animation.png \
                ${IMAGES_DIR}/trajectory_animation_$i.png
        fi
    done
}

clean_log() {
    echo -e "${BLUE}Cleaning up log file...${NC}"
    > "${LOG_FILE}" # Cleans the file content.
}

display_instructions

# Menu
while true; do
    echo
    echo "Select an option:"
    echo -e "1. ${GREEN}Run test${NC}"
    echo -e "2. ${BLUE}Clean up log file${NC}"
    echo -e "3. ${RED}Exit${NC}"

    read choice

    case $choice in
        1) run_test;;
        2) clean_log;;
        3) echo -e "${RED}Exiting...${NC}"; exit;;
        *) echo -e "${RED}Invalid option${NC}";;
    esac
done
