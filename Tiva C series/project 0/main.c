/*
 * main.c
 *
 *  Created on: Oct 10, 2022
 *      Author: aibar
 */

/*
 * Revised code
 * main.c
 *
 * ECE 266 Lab 1, Fall 2019
 *
 * Created by Zhao Zhang
 * Updated by Muntasir Ali and Anthony Ibarra
 */

#include <stdint.h>
#include <stdbool.h>
#include <stdio.h>
#include "launchpad.h"

// Data type for the color state of the on-board LED, which consists of three sub-LEDs
typedef struct {
    bool red;               // Red sub-LED on or off
    bool blue;              // Blue sub-LED on or off
    bool green;             // Green sub-LED on or off
} ledColor_t;

// On/off state of the LED
static enum {Off, On} ledState = Off;

// Array of LED color settings, for selecting color
static ledColor_t ledColors[] = {
    {true, false, false},   // Red on, Blue off, Green off
    {false, true, false},   // Red off, Blue on, Green off
    {false, false, true}    // Red off, Blue off, Green on
};

// Size of the ledColors[] array
#define LED_COLOR_NUM    (sizeof(ledColors) / sizeof(ledColor_t))

// Current color choice
static int colorChoice = 0;

/*
 * Event-drive code for flashing LED, looping through all the color choices
 */
void
flashLED(uint32_t time)							// the scheduled time
{
    ledColor_t *color;                          // pointer to color setting

    switch (ledState) {
    case Off:
        // Turn on LED by setting the sub-LED colors, then change the state to On
        // See ledTurnOfOff() in launchpad.h
        color = &ledColors[colorChoice];
        ledTurnOnOff(color->red, color->blue, color->green);
        ledState = On;
        break;

    case On:
        // Turn off all sub-LEDs, then change the state to Off
        // See ledTurnOnOff() in launchpad.h
        ledTurnOnOff(false, false, false);
        ledState = Off;
        break;

    }

    // Schedule the next callback event with a delay of 1000 ms from the current time
    schdCallback(flashLED, time + 1000);
}

/*
 * Event driven code for checking push button
 */
void
checkPushButton(uint32_t time)
{
    // Read the pushbutton state; see pbRead() in launchpad.h
    int code = pbRead();
    uint32_t delay = 10;

    switch (code) {
    case 1:
        // Switch to next color setting, with wrap-around
        colorChoice = (colorChoice + 1) % LED_COLOR_NUM;

        // Use an inertia for soft de-bouncing
        delay = 250;
        break;

    case 2:

        // See uprintf() in launchpad.h

        // Switch to the color setting 2 steps over red->green->blue->red->etc..
        colorChoice = (colorChoice + 2) % LED_COLOR_NUM;

        //Print out switch2 is pushed
        uprintf("%s\n\r", "SW2 is pushed");

        // Use an inertia for soft de-bouncing
        delay = 250;
        break;
    }

    schdCallback(checkPushButton, time + delay);
}

/*
 * The main function: Print out a message, schedule the first callback events, and then
 * run the callback scheduler.
 */
int main(void)
{
    lpInit();

    // Pring out a message
    // See uprintf() in launchpad.h
    uprintf("%s\n\r", "Hello World!");

    // Prints out the Welcome Message
    uprintf("%s\n\r", "Welcome to ECE 266!");

    // Schedule the first callback events for LED flashing and push button checking.
    // Each of them triggers a callback chains.
    // See schdCallback() in launchpad.h
    schdCallback(flashLED, 1000);
    schdCallback(checkPushButton, 1005);

    // Run the callback scheduler
    // See schdExecute() in launchpad.h
    while (true) {
        schdExecute();
    }
}

