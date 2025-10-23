# Arduino Due Pytest HIL Example
Hardware in the loop testing demonstrated on the Arduino Due

## Demonstration
The purpose of this code repository is to demonstrate hardware in the loop testing on an Arduino device.
Specifically it will demonstrate the following capabilities:
1. Compiling Arduino code and then loading the Arduino via command line
2. Drive analog signals into the Arduino via an Analog Discovery 2 (controlled by the dwf Python library)
3. Read back the analog values from the Arduino via serial and validate the input matches the output