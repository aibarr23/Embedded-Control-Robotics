# Ari Mahpour
# 07/21/2021
# This Pytest module uses the Analog Discovery 2 to demonstrates hardware in the loop (HIL) testing

import pytest
import xunitparser
import os
import time
from serial import Serial
from serial.tools import list_ports
try:
    from AD2 import AD2
except ModuleNotFoundError as e:
    print("AD2 Library not found. Downloading now.")
    command = "wget https://gitlab.com/docker-embedded/analog-discovery-2-on-raspberry-pi-4/-/raw/main/AD2.py"
    exit_code = os.system(command)
    assert exit_code==0, "Returned with non-zero exit code."
    from AD2 import AD2

ARDUINO_DUE_VID = 0x2341
ARDUINO_DUE_PID = 0x003d
BAUD = 115200

# Assumes you have only one device plugged in with the 
# VID and PID specified
# TO DO: Add error handling if device cannot be found
def getPortByVIDPID(VID, PID):
    for port in list_ports.comports():
        if (port.vid == VID and port.pid == PID):
            return port.device

# Acquire ADC telemetry by reading from the Arduino UART (USB)
def getADCData():
    command = "getADCValue\r"
    pytest.global_variable_1.write(command.encode())
    time.sleep(0.5)
    return(pytest.global_variable_1.readline().decode("utf-8").strip())

def setup_module():
    # Ensure that there is an Arduino Due connected
    COMPort = getPortByVIDPID(ARDUINO_DUE_VID, ARDUINO_DUE_PID)
    assert COMPort is not None, "Cannot find an Arduino connected with the specified VID and PID."

    # Configure global handles to hardware devices
    pytest.global_variable_1 = Serial(COMPort, BAUD, timeout=1)
    pytest.global_variable_2 = AD2()

# Verify that calls to the Waveforms software can be made
def test_sw_version():
    assert pytest.global_variable_2.dwf_version == "3.16.3"

def test_adc():
    CHANNEL = 0

    # Get ADC reading via UART from Arduino
    for voltage in range(1, 30, 1):
        voltage /= 10
        pytest.global_variable_1.flush()

        # Set the output voltage
        print("Setting output voltage to:", voltage)
        pytest.global_variable_2.gen_dc(CHANNEL, voltage)
        time.sleep(0.1)

        # Get ADC read over serial
        adc_val = round(int(getADCData())*3.3/1023.0, 2)
        print("ADC Value:", adc_val)

        # Check for a 10% range
        assert adc_val * 0.9 < adc_val < adc_val * 1.1, "ADC Value out of range"
        time.sleep(0.5)