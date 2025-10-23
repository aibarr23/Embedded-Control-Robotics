# Ari Mahpour
# 07/21/2021
# This Pytest module compiles and loads the Arduino with an INO file

import pytest
import xunitparser
import os
import serial
from serial.tools import list_ports

# Assumes you have only one device plugged in with the 
# VID and PID specified
# TO DO: Add error handling if device cannot be found
def getPortByVIDPID(VID, PID):
    for port in list_ports.comports():
        if (port.vid == VID and port.pid == PID):
            return port.device

def test_load_device():
    ARDUINO_DUE_VID = 0x2341
    ARDUINO_DUE_PID = 0x003d
    BOARD_NAME = "arduino:sam:arduino_due_x"
    FILE_NAME = "analog_in_out.ino"

    # Ensure that there is an Arduino Due connected
    target_port = getPortByVIDPID(ARDUINO_DUE_VID, ARDUINO_DUE_PID)
    assert target_port is not None, "Cannot find an Arduino connected with the specified VID and PID."

    # Call the Arduino command to compile and verify the design
    command = "arduino --verbose --board " + BOARD_NAME + " --port " + target_port + " --upload " + FILE_NAME
    print("Running command:", command)
    exit_code = os.system(command)
    assert exit_code==0, "Returned with non-zero exit code."