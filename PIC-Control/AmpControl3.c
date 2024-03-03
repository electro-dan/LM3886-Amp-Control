/*****************************************************************************************************************
 Copyright Daniel Clarke https://electro-dan.co.uk, 3rd March 2024
 Free to use and adapt but NO guarantees or support
 For PIC18F4455
*****************************************************************************************************************/
#include "AmpControl3.h"

#define DELAY delay_s(2)
#define DELAY_SHORT    delay_ms(100)

// Configuration registers
#pragma DATA    _CONFIG1L, 00001000b // USBDIV off, CPU divide by 2, PLL direct
#pragma DATA    _CONFIG1H, 10001101b // enable oscillator switchover, disable failsafe clock monitor, HS
#pragma DATA    _CONFIG2L, 00011111b // USB voltage regulator disabled, brownout set for 2.1 volts, hardware brownout only, PWRT disabled
#pragma DATA    _CONFIG2H, 00011110b // Watchdog timer disabled
#pragma DATA    _CONFIG3H, 10000000b // MCLR enabled, RB4:RB0 digital on POR
#pragma DATA    _CONFIG4L, 10000000b // Debug off, extended instructions disabled, LVP disabled, disable stack full/underflow reset
#pragma DATA    _CONFIG5L, 00001111b // Read code protection off
#pragma DATA    _CONFIG5H, 11000000b // Read EEPROM and boot block protection off
#pragma DATA    _CONFIG6L, 00001111b // Write code protection off
#pragma DATA    _CONFIG6H, 11100000b // Write EEPROM, boot block and config register protection off
#pragma DATA    _CONFIG7L, 00001111b // Table read protection off
#pragma DATA    _CONFIG7H, 01000000b // Boot block table read protection off

// 20 MHz crystal but the system clock is 10MHz due to CPUDIV configuration
#pragma CLOCK_FREQ 10000000


/******************************************************
  Function called once only to initialise variables and
  setup the PIC registers
*******************************************************/
void initialise() {
    // IO ports setup
    trisa = 0x00; // all ouptuts
    porta = 0x00; // set to off
    trisb = 0x07; // RB0, RB1, RB2 are inputs
    portb = 0x20; // set to off, except RB5 (max7219 latch)
    trisc = 0xC0; // RC7 (Rx) and RC6 (Tx) are inputs
    portc = 0x04; // Set bit 2 on portc, the pga2310 latch /CS
    trisd = 0x40; // v3.0 - RB6 is an input
    portd = 0x80; // defaults to off except RD7
    trise = 0x00; // All outputs (relay 74ht595)
    porte = 0x00; // All off

    osccon.IDLEN = 1; // Enter idle mode on sleep
    osccon.IRCF2 = 1; // IRCF2 to IRCF0 are 110 for 4MHz for RC_RUN mode to save power
    osccon.IRCF1 = 1;
    osccon.IRCF0 = 0;

    // ADC setup
    adcon0 = 0x00; //  ADC off
    adcon1 = 0x0F; // All digital I/O
    
    //ucon.USBEN = 0; // USB off - v3.0 default is off, instruction not needed

    readData(); // Read in variables from EEPROM
    writeRelay(); // v1.1 moved to power on sequence

    // Timer calculator: http://eng-serve.com/pic/pic_timer.html
    // Timer 1 setup - interrupt every ~200ms seconds at 10Mhz
    t1con = 0x30;  //  00 11 0000 - 1:8 prescale, oscil off, internal clock, timer disabled
    iTimer1Count = 0; // Counter for number of interrupts
    tmr1h = TMR1H_SET; // Set TMR1 to 3072 (tmr1h 12)
    pie1.TMR1IE = 1; // Timer 1 interrupt
    pir1.TMR1IF = 0; // Clear timer 1 interrupt flag bit

    // Timer 2 setup - interrupt every 890us
    t2con = 0x29;  //  0 0101 0 01 - 1:6 postscale, timer off, 1:4 prescale
    pr2 = IR_PR2_890US; // Preload timer2 comparator value
    pie1.TMR2IE = 1; // Timer 2 interrupt
    pir2.TMR2IF = 0; // Clear timer 1 interrupt flag bit

    // Setup for RB0 Interrupt [Power Fail]
    intcon.INT0IE = 1; // RB0 Interrupt enabled (for power fail)
    intcon2.INTEDG0 = 1; // RB0 interrupt should occur on rising edge
    intcon.INT0IF = 0; // Clear RB0 interrupt flag bit
    
    // Setup for RB1 Interrupt [IR LED]
    intcon3.INT1E = 1; // RB1 Interrupt (for IR receive)
    intcon2.INTEDG1 = 0; // RB1 interrupt should occur on falling edge
    intcon3.INT1IF = 0; // Clear RB1 interrupt flag bit
    
    // Setup for RB2 Interrupt [DC fail]
    intcon3.INT2E = 1; // RB2 Interrupt (for DC Fail)
    intcon2.INTEDG2 = 0; // RB2 interrupt should occur on falling edge
    intcon3.INT2IF = 0; // Clear RB2 interrupt flag bit

    intcon2.RBPU = 1; // Port B pull-ups disabled (otherwise DC fail is not detected)

    intcon.PEIE = 1; // Enables all unmasked peripheral interrupts (required for RS232)

    // rs232 communications setup
    // SYNC = 0, BRGH = 1, BRG16 = 0
    // 10MHz Baud rate 9600 = 65 = ((10000000 / 9600) / 16) - 1
    //spbrg = 65; // 65 = ((10000000 / 9600) / 16) - 1
    //txsta = 0x26; // 00100110 - 8 bit, transmit enable, async mode, high speed, TSR empty, 9bit (0)
    //rcsta = 0x90; // 10010000 - serial port enabled, 8 bit reception, async mode continuous recieve, no frame error, no overrun error
    //baudcon = 0x42; // 01000010 - non-inverted, 8 bit generator, wake up on receive

    //pie1.RCIE = 1; // Usart interrupt receive (no send interrupt)
    //iRS232Index = 0;
    
    RED = 1; // Standby LED

    delay_s(2);
    
    // v3.0 altered display test
    ledOn();
    ledTest();
    delay_s(2);
    ledOff();
    
    //bluetoothSetup();

    intcon.GIE = 1;
}

//------------------------------------------------------------------------------
// Interrupt handler
//------------------------------------------------------------------------------
void interrupt(void) {
    // Exit power saving mode - change to PRI_RUN
    //osccon.SCS1 = 0;
    
    // external interrupt on RB2 - highest priority [DC fail]
    if (intcon3.INT2IF && intcon3.INT2IE) {
        if (!DC_FAIL) {
            MUTEOUT = 0; // Mute amps
            // Show fault on display
            // Flag this task to the task array
            cTask.TASK_INT_EXT2 = 1;
        }
        intcon3.INT2IF = 0;

        return; // do not process any other interrupt
    }
    // external interrupt on RB0 - next highest priority [AC fail]
    if (intcon.INT0IF && intcon.INT0IE) {
        MUTEOUT = 0; // Mute amps
        cTask.TASK_INT_EXT0 = 1;
        intcon.INT0IF = 0;

        return; // do not process any other interrupt
    }
    // external interrupt on RB1 - IR sensor
    if (intcon3.INT1IF && intcon3.INT1IE) {        
        intcon2.INTEDG1 = intfCounter.0; // Toggle edge detection
        intfCounter++;
        rc5_logicChange++;
        if (rc5_currentState == rc5_idleState) {
            // If the state was idle, start the timer
            rc5_logicInterval = 0;
            rc5_logicChange = 0;
            //delay_us(200);
            // Timer 2 should run for about 200us at first
            tmr2 = 0;
            pr2 = IR_PR2_200US;
            pir1.TMR2IF = 0; // Clear interrupt flag
            t2con.TMR2ON = 1; // Timer 2 is on
            rc5_currentState = rc5_initialWaitState;
        }
        intcon3.INT1IF = 0; //clear interrupt flag.
    }
    // Interrupt on timer2 - IR code https://tamilarduino.blogspot.com/2014/06/ir-remote-philips-rc5-decoding-using.html
    if(pir1.TMR2IF) {
        rc5_pinState = IR_PIN;
        if (rc5_currentState != rc5_initialWaitState) {
            rc5_logicInterval++;
            IR_LED = rc5_logicInterval.0; // Flick IR LED
        }
        char iReset = 0;
        // Switch statement to process IR depending on where/state of the command timer currently expects to be
        switch (rc5_currentState){
            // If in initial wait state - timer completed the first 200us, switch to the normal 890us
            case rc5_initialWaitState:
                // Timer 2 interrupt every 890us
                tmr2 = 0;
                pr2 = IR_PR2_890US; // Preload timer2 comparator value
                // Switch to start bit state
                rc5_currentState = rc5_startBitState;
                break;
            // If in start bit state - check for (second) start bit, Logic on RB1 must change in 890us or considers as a fault signal.
            case rc5_startBitState:
                if ((rc5_logicInterval == 1) && (rc5_logicChange == 1)) {
                    // Valid start bits were found
                    rc5_logicInterval = 0;
                    rc5_logicChange = 0;
                    rc5_bitCount = 0;
                    rc5_inputData = 0;
                    rc5_currentState = rc5_captureBitState; // Switch to capturing state
                } else {
                    iReset = 1;
                }
                break;
            // If in capture bit state - sample RB1 logic every 1780us (rc5_logicInterval = 2)
            // Data is only valid if the logic on RB1 changed
            // Data is stored in rc5_command and rc5_address
            case rc5_captureBitState:
                // Logic interval must be 2 - 1780us
                if(rc5_logicInterval == 2) {
                    // Logic change must occur 2 times or less, otherwise it is invalid
                    if(rc5_logicChange <= 2) {
                        rc5_logicInterval = 0;
                        rc5_logicChange = 0;
                        // If the number of bits received is less than 12, shift the new bit into the inputData
                        if(rc5_bitCount < 12) {
                            rc5_bitCount++;
                            rc5_inputData <<= 1; // Shift recorded bits to the left
                            if(rc5_pinState == 1) {
                                rc5_inputData.0 = 1; // Add the new bit in
                            }
                        } else {
                            // All 12 bits received
                            rc5_command = rc5_inputData & 0x3F; // 00111111 - command is the last 6 bits
                            rc5_inputData >>= 6; // Shift 6 bits right, clearing command
                            rc5_address = rc5_inputData & 0x1F; // 00011111 - address is now the last 5 bits
                            rc5_inputData >>= 5; // Shift 5 bits right, clearing address
                            // Last bit is the flick bit
                            rc5_flickBit = rc5_inputData;
                            
                            // Flag this task to the task array - IR command will be processed in the main loop
                            cTask.TASK_INT_EXT1 = 1;

                            // Command finished - reset status
                            iReset = 1;
                        }
                    } else {
                        // Not valid - reset status
                        iReset = 1;
                    }
                }
                break;
            default: 
                iReset = 1;
        }
        
        // Reset status if not valid
        if (iReset) {
            // Not valid - reset status
            rc5_currentState = rc5_idleState;
            t2con.TMR2ON = 0; // Disable Timer 2
            intcon2.INTEDG1 = 0; // Interrupt on falling edge
            IR_LED = 0; // switch off IR LED
        }
        pir1.TMR2IF = 0; // Clear interrupt flag
    }
    // timer 1 interrupt - reset display timer
    if (pir1.TMR1IF && pie1.TMR1IE) {
        // timer 1 will interrupt every 200ms with a 1:8 prescaler at 10MHz and TMR1 preload of 3072
        // this needs to interrupt longer than the RC5 message time (114ms)
        // If the mute button was pressed
        // iMuteWasPressed is cleared before this timer interrupt if the mute button is held
        if (iMuteHeld < MUTE_HOLD_TIME && iMuteWasPressed) {
            // flag for muting
            cTask.TASK_TIMER1_MUTE = 1;
        }
        // Into 1 second, this goes 5 times at 10MHz
        if (++iTimer1Count >= TMR1_1SEC) {
            iTimer1Count = 0;
            // Add this task to the task array
            cTask.TASK_TIMER1 = 1;
        }
        pir1.TMR1IF = 0; // Clear interrupt flag
    }
    // RS232
    // byte received interrupt
    /*if (pir1.RCIF && pie1.RCIE) {
        // pir1.RCIF is cleared automatically once rcreg is read
        if (rcsta.OERR) { // Overrun error rcsta.OERR
            rcsta.CREN = 0; // clear bit CREN
            rcsta.CREN = 1; // set bit CREN
        } else if (rcsta.FERR) {
            rs232Buffer[iRS232Index] = rcreg;
        } else {
            rs232Buffer[iRS232Index] = rcreg;
            // Read until line feed or EOT is detected
            if (!cTask.TASK_RS232) { 
                while (!pir1.TXIF);
                if ((rs232Buffer[iRS232Index] == 10) || (rs232Buffer[iRS232Index] == 4)) {
                    cTask.TASK_RS232 = 1;
                    //iRS232Index = 0; // Don't reset this until processed as loop needs to know length of command
                }
                // Otherwise increment buffer index for next byte received
                iRS232Index++;
            }
        }
    }*/
}

// Sends AT commands to the bluetooth module so that PIN and name are unique
/*void bluetoothSetup() {
    rs232Print("AT");
    delay_s(2);
    rs232Print("AT+NAMEAmp");
    delay_s(2);
    rs232Print("AT+PIN3886");
    delay_s(2);
}*/

void timer1Reset() {
    // switch off timer, and reset counters
    //t1con.TMR1ON = 0;
    iMuteWasPressed = 0;
    tmr1h = TMR1H_SET;
    tmr1l = 0;
}

/******************************************************
  EEPROM read and write methods
*******************************************************/
void saveData() {
    eepromWrite(0, 10); // To indicate EEPROM has been saved
    eepromWrite(1, iVolume);
    eepromWrite(2, iFrontBalance);
    eepromWrite(3, iRearBalance);
    eepromWrite(4, iRearAdjust);
    eepromWrite(5, iCentreAdjust);
    eepromWrite(6, iSubAdjust);
    eepromWrite(7, iActiveInput);
    eepromWrite(8, iSurroundMode);
    eepromWrite(9, iExtSurroundMode);
    eepromWrite(10, iTrigger);
}

void eepromWrite(char address, char data) {
    char intconsave = intcon;
    
    // Load address and data
    eeadr = address;
    eedata = data;

    eecon1.EEPGD = 0; // Point to DATA memory
    eecon1.CFGS = 0; // Access EEPROM
    eecon1.WREN = 1; // Enable writes
    
    // Required write sequence
    intcon = 0;
    eecon2 = 0x55; // Write 55h
    eecon2 = 0xAA; // Write 0AAh
    eecon1.WR = 1; // Set WR bit to begin write
    intcon = intconsave;
    eecon1.WREN = 0; // Disable writes on write complete (EEIF set)
    while(!pir2.EEIF); // Wait for the interrupt bit EEIF to be set
    pir2.EEIF = 0; // Clear EEIF
}

/******************************************************
  Function to read the current variables from ROM
*******************************************************/
void readData() {
    // Read initial values from EEPROM
    // Do not read other variables if the EEPROM has not been saved before
    // as all default will be 0xFF
    if (eepromRead(0) == 10) {
        iVolume = eepromRead(1);
        iFrontBalance = eepromRead(2);
        iRearBalance = eepromRead(3);
        iRearAdjust = eepromRead(4);
        iCentreAdjust = eepromRead(5);
        iSubAdjust = eepromRead(6);
        iActiveInput = eepromRead(7);
        iSurroundMode = eepromRead(8);
        iExtSurroundMode = eepromRead(9);
        iTrigger = eepromRead(10);
    }
}

char eepromRead(char address) {
    // Load address
    eeadr = address;
    eecon1.EEPGD = 0; // Point to DATA memory
    eecon1.CFGS = 0; // Access EEPROM
    
    // Read, data is available in eedata the next cycle.
    eecon1.RD = 1;
    
    // Return value
    return eedata;
}

/**************************************************************************************
    LED Display Functions
**************************************************************************************/

char ledData1[8];
char ledData2[8];

// Converts a string of characters into decoded 7 segment bytes for LED character array
// Optionally writes these bytes to LED displays
void ledPrint(char iLine, unsigned char *s) {
    char dig;
    for (dig = 0; dig < 8; dig++) {
        if (*s) {
            if (iLine == 1)
                ledData1[dig] = displayASCIItoSeg[*s++ - 0x20];
            else
                ledData2[dig] = displayASCIItoSeg[*s++ - 0x20];
        } else {
            if (iLine == 1)
                ledData1[dig] = 0;
            else
                ledData2[dig] = 0;
        }
    }
}

// Converts an ASCII char to decoded byte and places it in LED array
// Support decimal places
void ledChar(char iChar, char iHasDot) {
    char iDecoded = displayASCIItoSeg[iChar - 0x20];
    if (iHasDot)
        iDecoded = iDecoded | 0x80;
    if (ledCurrentLine == 1) {
        ledData1[ledCurrentCol] = iDecoded;
    } else {
        ledData2[ledCurrentCol] = iDecoded;
    }
    if (ledCurrentCol < 8)
        ledCurrentCol++;
}

// LED test function
void ledTest() {
    ledPrint(1, "Init on");
    ledPrint(2, "Testing");
    ledWrite();
}


// Setup the MAX7219 LED displays by sending the required configuration bytes
void ledSetup() {
    // Scan limit
    ledLatchDown();
    ledSendChar(0x0B);
    ledSendChar(0x07); // Scan all 8 digits
    ledSendChar(0x0B);
    ledSendChar(0x07); // Scan all 8 digits
    ledLatchUp();
    
    // Set no decode mode
    ledLatchDown();
    ledSendChar(0x09);
    ledSendChar(0);
    ledSendChar(0x09);
    ledSendChar(0);
    ledLatchUp();
    
    // Set intensity
    ledLatchDown();
    ledSendChar(0x0A);
    ledSendChar(0x06); // A: 21/32, 8: 17/32, 6:13/32
    ledSendChar(0x0A);
    ledSendChar(0x06); // A: 21/32, 8: 17/32, 6:13/32
    ledLatchUp();
}

// Start LED display
void ledOn() {
    // v3.0 Power on and setup
    LEDDATA = 0;
    LEDCLOCK = 0;
    LEDLATCH = 1;
    LEDDISPON = 0;
    //delay_s(1);
    delay_ms(250);
    ledSetup();
    
    // No shutdown
    ledLatchDown();
    ledSendChar(0x0C);
    ledSendChar(0x01); // no shutdown
    ledSendChar(0x0C);
    ledSendChar(0x01); // no shutdown
    ledLatchUp();
    // Startup time delay
    delay_us(250);
}

// Shutdown LED display
void ledOff() {
    // Shutdown
    ledLatchDown();
    ledSendChar(0x0C);
    ledSendChar(0x00); // shutdown
    ledSendChar(0x0C);
    ledSendChar(0x00); // shutdown
    ledLatchUp();
    // v3.0, remove the power
    LEDDISPON = 1;
    delay_ms(100);
}

// Write the bytes set in each array to the MAX7219 LED displays
void ledWrite() {
    char n;
    char d = 7; // Characters in array are written out backwards so start from furthest (7)
    
    // Loop through digits 0 to 8 (addressed as 1 to 9)
    for (n = 1; n < 9; n++) { 
        // Writing character to second device
        ledLatchDown();
        ledSendChar(n); // Digit to write
        ledSendChar(ledData2[d]); // Data to write
        
        // Writing character to first device
        ledSendChar(n); // Digit to write
        ledSendChar(ledData1[d]); // Digit to write
        ledLatchUp();
        d--; // Decrement array counter
    }
}

void ledLatchDown() {
    // Load the new register
    LEDDATA = 0;
    LEDCLOCK = 0;
    LEDLATCH = 0; // Clock must fall so that last bit is clocked out
}

void ledLatchUp() {
    // Load the new register
    LEDLATCH = 1;
    LEDCLOCK = 0; // Clock must fall after latch raised
    LEDDATA = 0; // Data to default
    delay_us(LEDDELAYUS); // Need to delay before starting again
}

// Write a single piece of data (byte) out serially
// Uses bit-banging to control protocol and delays
void ledSendChar(char iData) {
    for (char cBitSelect = 0x80; cBitSelect; cBitSelect >>= 1) {
        LEDCLOCK = 0; // Clock cleared
        if (iData & cBitSelect)
            LEDDATA = 1;
        else
            LEDDATA = 0;
        LEDCLOCK = 1; // Clock set high, so bit is loaded onto the shift register
    }
}

// Power on routine
void doPower() {
    if (iPower) {
        // Power off sequence
        MUTEOUT = 0; // Mute amps
        // Switch on green (for muted)
        BLUE = 0;
        GREEN = 1;
        RED = 0;
        
        // Disable timer 1
        t1con.TMR1ON = 0;

        //saveData(); // Save variables - moved because interrupts need to be enabled
        
        // Goodbye!
        ledPrint(1, "Goodbye");
        ledPrint(2, "");
        ledWrite();
        
        iPower = 0;
        // Write relay (disables or enables relays if powered)
        // V2.2 - moved here so that triggers are shut off immediately instead of after the delay
        // V2.4 - added a slight delay so the power isn't removed from the trigger output at the same time the mute occurs
        delay_ms(250);
        delay_ms(250); // v3.0, delay_ms call with 500 is invalid (max 255), added 2x 250 instead
        writeRelay();

        delay_ms(250); // Force a 1 second wait before powering down the amps
        delay_ms(250); // v3.0, delay_ms call with 500 is invalid (max 255), added 2x 250 instead
        POWEROUT = 0; // Power off amps

        delay_s(6); // Force a 6 second wait before the ability to switch on again (allows electronics to drain)
        
        ledOff();
        
        // Switch on red (for standby)
        BLUE = 0;
        GREEN = 0;
        RED = 1;
    } else if (DC_FAIL) {
        // Power on sequence - v2.0 only runs if there is no DC failure present
        POWEROUT = 1; // Power on amps
                
        // Switch on green (for muted)
        BLUE = 0;
        GREEN = 1;
        RED = 0;
        
        writeVolumes(); // Ensure volume level is sent out (this will also colour the LED)
        
        ledOn();
        ledPrint(1, "HELLO");
        ledPrint(2, "");
        ledWrite();
    
        iPower = 1;
        // Write relay (disables or enables relays if powered)
        // V2.2 - moved here so that triggers are enable immediately instead of after the delay
        writeRelay();

        // Delay mute
        // Flash Green/Blue for 5.4 seconds
        char l;
        for (l=0; l<27; l++) {
            // Green off, blue on
            BLUE = 1;
            GREEN = 0;
            DELAY_SHORT;
            // Blue off, green on
            BLUE = 0;
            GREEN = 1;
            DELAY_SHORT;
        }
        
        writeVolumes(); // Write volume a second time to avoid interference
        
        showInput();
        showVolume();
        ledWrite();
    
        // Check for DC failure
        if (!DC_FAIL) {
            showFault(); // Show that a fault has occured
            iPower = 0;
        } else {
            // Only unmute amps if no fault
            MUTEOUT = 1; // Unmute amps
        }
        
        // Enable timer 1
        t1con.TMR1ON = 1;
    }
}

void doVolumeUp() {
    // Increase level
    if (iVolume < 255) { // Don't process if volume is 255 or power is off
        // Increase level
        char iNewVol = iVolume + 2; // Increment by larger step for IR command VolumeUp
        if (iNewVol < iVolume)
            iNewVol = 255;
        iVolume = iNewVol;
        writeVolumes();
    }
}

void doVolumeDown() {
    // Decrease level
    if (iVolume > 0) { // Don't process if volume is 0 or power is off
        // Increase level
        char iNewVol = iVolume - 2; // Increment by larger step for IR command VolumeUp
        if (iNewVol > iVolume)
            iNewVol = 0;
        iVolume = iNewVol;
        writeVolumes();
    }
}

void doMute() {
    iMute = !iMute;
    writeVolumes();
}


/******************************************************
  Function to print the current volume to the LED display
*******************************************************/
void showVolume() {
    int iModulus = 0;
    char cGain = 95; // Gain level -95.5db - +31.5dB
    char cGainDecimalPoint = 0; // Gain decimal - either 0 or 5

    ledData2[0] = 0;
    ledData2[1] = 0;
    if (iMute) {
        printMute(); // Sound off
    } else {
        ledCurrentLine = 2;
        if (iVolume == 192) {
            // Gain is 0dB
            cGain = 0;
        } else if (iVolume > 192) {
            // Gain is postive
            cGain = 31 - ((255-iVolume) / 2);
        } else if (iVolume < 192) {
            // Gain is negative
            cGain = ((254-iVolume) / 2) - 31;
            ledCurrentCol = 1;
            ledChar('-', 0);
        }
        // Gain decimal - if volume is an odd number (test the last bit), it's 0.5dB
        // V3.0 made this more efficient
        if (iVolume.0 == 1)
            cGainDecimalPoint = 5;
        
        // V3.0 made this more efficient
        // Work out each digit
        // less program memory needed - may be slower executing
        // https://electronics.stackexchange.com/questions/158563/how-to-split-a-floating-point-number-into-individual-digits
        char cDig1 = 0;
        char cDig0 = 0;
        // incrementing variables for each digit
        // determine to tens digit
        while (cGain >= 10) {
            cGain = cGain - 10;
            // each time we take off 10, the left most digit is incremented
            cDig1++;
        }
        // the last digit is what's left on iValue
        cDig0 = cGain;
        
        // add 48 for ASCII equilvalent (48 = 0)
        // 1st digit in number
        ledCurrentCol = 2;
        if (cDig1 == 0)
            ledChar(' ', 0);
        else
            ledChar(cDig1 + 48, 0);
        // 2nd digit in number + added decimal point
        ledChar(cDig0 + 48, 1);
        
        // Decimal number
        ledChar(cGainDecimalPoint + 48, 0);
        ledChar(' ', 0);
        ledChar('d', 0);
        ledChar('b', 0);
    }
    
    // Display green LED if volume is 0 (effectively mute) or mute is on
    if ((iVolume == 0) || (iMute == 1)) {
        // Green on, blue off
        BLUE = 0;
        GREEN = 1;
    } else {
        // Green off, blue on
        BLUE = 1;
        GREEN = 0;
    }
}

/******************************************************
  Function to print the current input to the LED display
*******************************************************/
void showInput() { 
	// 0 = Front, 1 = Input 1, 2 = Input 2, 3 = Input 3, 4 = Input 4, 5 = Input 5
    switch (iActiveInput) {
        case 0:
            //ledPrint(1, "PC"); // Media Centre PC
            ledPrint(1, "TELE 51"); // 5.1 Input
            //ledPrint(1, "CinE 51"); // 5.1 Input
            ledData1[5] = 0xDB; // 5 with dot
            break;
        case 1:
            ledPrint(1, "Chr Cast"); // Chromecast
            break;
        case 2:
            ledPrint(1, "Phono"); // Phono
            break;
        case 3:
            ledPrint(1, "ALt"); // Auxiliary Input
            break;
    }
}

void showFault() {
    ledPrint(1, "FAULt"); // Show fault
    printMute();
    RED = 1;
    BLUE = 0;
}

void printMute() {
    ledPrint(2, "Snd OFF");
    ledWrite();
}

/******************************************************
  Apply relay selection to the 74HCT595 shift register
*******************************************************/
void writeRelay() {
    char iRelay = 0; // initialised empty

    // V2.0 changed outputs
    // TRG 1 = 00000001  0x01
    // TRG 2 = 00000010  0x02
    // INP 1 = 00000100  0x04
    // INP 2 = 00001000  0x08
    // INP 3 = 00010000  0x10
    // INP 0 = 00100000  0x20
    // SUR M = 01000000  0x40

    // Set surround mode relay if Active Input is 0 and ExtSurround is on
    if (iExtSurroundMode && (iActiveInput == 0)) {
        // Set bit 7
        iRelay = ((iRelay & 0xBF) + 0x40);
    }

    // Write selected input to input byte
    switch (iActiveInput) {
        // For each input, take the existing selected and logic AND with 0x43 (01000011) so the status 
        // of the power and surround switch remains. Then add the representation of the input 
        case 0:
            // Clear bits 2 to 5, Set bit 5, 
            iRelay = ((iRelay & 0x43) + 0x20);
            break;
        case 1:
            // Clear bits 2 to 5, Set bit 2, 
            iRelay = ((iRelay & 0x43) + 0x04);
            break;
        case 2:
            // Clear bits 2 to 5, Set bit 3, 
            iRelay = ((iRelay & 0x43) + 0x08);
            break;
        case 3:
            // Clear bits 2 to 5, Set bit 4, 
            iRelay = ((iRelay & 0x43) + 0x10);
            break;
    }
    
    if (iTrigger <= 3)
        iRelay += iTrigger;
    
    // v1.1 if power is off, disable all relays (to reduce standby current) and triggers
    if (!iPower)
        iRelay = 0;
    
    // Lower latch
    RELAYLATCH = 0;

    for (char cBitSelect = 0x01; cBitSelect; cBitSelect <<= 1) {
        if (iRelay & cBitSelect)
            RELAYDATA = 1; // Serial data output high
        else
            RELAYDATA = 0;

        RELAYCLOCK = 1; // Clock set high, so bit is loaded onto the shift register
        RELAYCLOCK = 0; // Clock cleared
    }

    // Load the new register
    RELAYLATCH = 1; // Set the latch to high so contents of shift register are put on the parallel output
}

void doInputDown() {
    // Decrement the active input
    iActiveInput--;
    if (iActiveInput > 4) // If overflowed (less than 0) was 5
        iActiveInput = 3; // was 4
    writeRelay();
}

void doInputUp() {
    // Increment the active input
    iActiveInput++;
    if (iActiveInput >= 4) // was 5
        iActiveInput = 0;
    writeRelay();
}

/******************************************************
  Apply volume levels (6 channels) to PGA2310 chips
*******************************************************/
void writeVolumes() {
    char n; // Loop counter
    char byteVolume[6] = {0,0,0,0,0,0};
    
    // Set front levels based on balance setting
    if (iFrontBalance == 0) {
        byteVolume[4] = iVolume; // Right balance adjust (reduce left channel)
        byteVolume[5] = iVolume; // Set other channel to volume level
    } else if (iFrontBalance > 0) {
        byteVolume[4] = getAdjustedVolume(iFrontBalance * -1); // Right balance adjust (reduce left channel)
        byteVolume[5] = iVolume; // Set other channel to volume level
    } else {
        byteVolume[5] = getAdjustedVolume(iFrontBalance); // Left balance adjust (reduce right channel)
        byteVolume[4] = iVolume; // Set other channel to volume level
    }

    // Set rear levels based on balance setting and adjustment
    if (iRearBalance == 0) {
        byteVolume[2] = getAdjustedVolume(iRearAdjust); // Rear level adjust
        byteVolume[3] = getAdjustedVolume(iRearAdjust); // Rear level adjust
    } else if (iRearBalance > 0) {
        byteVolume[2] = getAdjustedVolume((iRearBalance * -1) + iRearAdjust); // Right balance adjust (reduce left channel)
        byteVolume[3] = getAdjustedVolume(iRearAdjust); // Adjust other channel only
    } else {
        byteVolume[3] = getAdjustedVolume(iRearBalance + iRearAdjust); // Left balance adjust (reduce right channel)
        byteVolume[2] = getAdjustedVolume(iRearAdjust); // Adjust other channel only
    }

    // Set centre and sub woofer levels based on each adjustment
    byteVolume[1] = getAdjustedVolume(iCentreAdjust); // Centre level adjust
    byteVolume[0] = getAdjustedVolume(iSubAdjust);  // Sub level adjust

    // If set to stereo, clear first 4 bytes (rear l/r, centre, sub)
    if (!iSurroundMode) {
        for (char i = 0; i < 4; i++)
            byteVolume[i] = 0;
    }
    // If muted (volume zero or iMute is 1), set all to zero regardless of levels
    if ((iVolume == 0) || (iMute == 1)) {
        for (char i = 0; i < 6; i++)
            byteVolume[i] = 0;
        // Display correct LED colour - green for muted
        GREEN = 1;
        BLUE = 0;
    } else {
        // Blue for active
        GREEN = 0;
        BLUE = 1;
    }

    // Set latch to low
    VOLLATCH = 0;

    for (n = 0; n < 6; n++) { // 6 bytes to send
        // MSB first
        for (char cBitSelect = 0x80; cBitSelect; cBitSelect >>= 1) {
            // Clear clock for next bit
            VOLCLOCK = 0;

            if (byteVolume[n] & cBitSelect) // the set bit position in cBitSelect in vol is set, output high
                VOLDATA = 1;
            else
                VOLDATA = 0;

            // Raise clock so serial bit output is sent
            VOLCLOCK = 1;
        }
    }
    // Set latch to high
    VOLLATCH = 1;
}

/******************************************************
 Adjust the volume level and return the result, from 0 to 255 only
 *******************************************************/
char getAdjustedVolume(signed char iVolAdj) {
    // Returns an adjustment to the volume, floor at zero and ceiling at 255
    char iResult = iVolume + iVolAdj;
    // Prevent overflow
    if (iVolAdj < 0) { // Negative, new level should always be less than overall
        if (iResult > iVolume)
            iResult = 0;
    }
    else { // Positive, new level should be greater than overall
        if (iResult < iVolume)
            iResult = 255;
    }
    return iResult;
}

/***********************************************************************************
  Functions to display and adjust amp functions i.e. bass, treble, balance
************************************************************************************/
void functionValueDisplay(signed char iValue, char isBal) {
    ledData2[0] = 0;
    ledData2[1] = 0;
    
    ledCurrentLine = 2;
    // write characters to array
    if (isBal) {
        ledCurrentCol = 0;
        if (iValue < 0)
            ledChar('L', 0);
        if (iValue > 0)
            ledChar('r', 0);
    }
    ledCurrentCol = 1;
    if (iValue < 0)
        ledChar('-', 0);
    if (iValue > 0) {
        if (isBal)
            ledChar('-', 0);
    }

    char iAdj = abs(iValue);
    char iDecimal = 0;
    if (iAdj.0)
        iDecimal = 5;
    iAdj = iAdj / 2;
    
    // incrementing 10s
    // determine to tens digit
    ledCurrentCol = 2;
    if (iAdj >= 10) {
        ledChar('1', 0);
        iAdj -= 10;
    } else {
        ledChar(' ', 0);
    }    
    // 2nd digit in number + added decimal point
    ledChar(iAdj + 48, 1);
    
    // Decimal number
    ledChar(iDecimal + 48, 0);
    ledChar(' ', 0);
    ledChar('d', 0);
    ledChar('b', 0);
    
    // Write Result to LED display
    ledWrite();
    
}

void functionDisplay() {
    switch (iFunctionMode) {
        case 1: // Centre
            ledPrint(1, "Centre");
            functionValueDisplay(iCentreAdjust, 0);
            break;
        case 2: // Rear
            ledPrint(1, "rear");
            functionValueDisplay(iRearAdjust, 0);
            break;
        case 3: // Balance
            ledPrint(1, "balance");
            functionValueDisplay(iFrontBalance, 1);
            break;
        case 4: // Rear Balance
            ledPrint(1, "rear bal");
            functionValueDisplay(iRearBalance, 1);
            break;
        case 5: // Sub
            ledPrint(1, "Sub");
            //ledPrint(2, "Testing", 1);
            functionValueDisplay(iSubAdjust, 0);
            break;
        case 6: // Trigger 1
            ledPrint(1, "Trig 1");
            if (iTrigger.0)
                ledPrint(2, "On");
            else
                ledPrint(2, "Off");
            break;
        case 7: // Trigger 2
            ledPrint(1, "Trig 2");
            if (iTrigger.1)
                ledPrint(2, "On");
            else
                ledPrint(2, "Off");
            break;
        case 8: // External surround
            ledPrint(1, "51 Sound");
            ledData1[0] = 0xDB; // 5 with dot
            if (iExtSurroundMode)
                ledPrint(2, "On");
            else
                ledPrint(2, "Off");
            break;
        case 9: // Hafler surround
            ledPrint(1, "Hafler");
            if (iSurroundMode)
                ledPrint(2, "On");
            else
                ledPrint(2, "Off");
            break;
    }
    // Write Result to LED display
    ledWrite();
}

char functionValueRaise(signed char iValue) {
    if (iValue < 32)
        iValue++;
    return iValue;
}

char functionValueLower(signed char iValue) {
    if (iValue > -32)
        iValue--;
    return iValue;
}

void functionRaise() {
    switch (iFunctionMode) {
        case 1: // Centre
            iCentreAdjust = functionValueRaise(iCentreAdjust);
            writeVolumes();
            break;
        case 2: // Rear
            iRearAdjust = functionValueRaise(iRearAdjust);
            writeVolumes();
            break;
        case 3: // Balance
            iFrontBalance = functionValueRaise(iFrontBalance);
            writeVolumes();
            break;
        case 4: // Rear Balance
            iRearBalance = functionValueRaise(iRearBalance);
            writeVolumes();
            break;
        case 5: // Centre
            iSubAdjust = functionValueRaise(iSubAdjust);
            writeVolumes();
            break;
        case 6: // Trigger 1
            iTrigger.0 = 1;
            writeRelay();
            break;
        case 7: // Trigger 2
            iTrigger.1 = 1;
            writeRelay();
            break;
        case 8: // External surround
            if (iExtSurroundMode)
                iExtSurroundMode = 0;
            else
                iExtSurroundMode = 1;
            writeRelay();
            break;
        case 9: // Hafler surround
            if (iSurroundMode)
                iSurroundMode = 0;
            else
                iSurroundMode = 1;
            writeVolumes();
            break;
    }
    // Display the changed value
    functionDisplay();
}

void functionLower() {
    switch (iFunctionMode) {
        case 1: // Centre
            iCentreAdjust = functionValueLower(iCentreAdjust);
            writeVolumes();
            break;
        case 2: // Rear
            iRearAdjust = functionValueLower(iRearAdjust);
            writeVolumes();
            break;
        case 3: // Balance
            iFrontBalance = functionValueLower(iFrontBalance);
            writeVolumes();
            break;
        case 4: // Rear Balance
            iRearBalance = functionValueLower(iRearBalance);
            writeVolumes();
            break;
        case 5: // Centre
            iSubAdjust = functionValueLower(iSubAdjust);
            writeVolumes();
            break;
        case 6: // Trigger 1
            iTrigger.0 = 0;
            writeRelay();
            break;
        case 7: // Trigger 2
            iTrigger.1 = 0;
            writeRelay();
            break;
        case 8: // External surround
            if (iExtSurroundMode)
                iExtSurroundMode = 0;
            else
                iExtSurroundMode = 1;
            writeRelay();
            break;
        case 9: // Hafler surround
            if (iSurroundMode)
                iSurroundMode = 0;
            else
                iSurroundMode = 1;
            writeVolumes();
            break;
    }
    // Display the changed value
    functionDisplay();
}

void functionUp() {
    // Change to another function
    iFunctionMode++;
    // Cycle back to 1st function if at 9th
    if (iFunctionMode > 9)
        iFunctionMode = 1;
    // Display the function and value
    functionDisplay();
}

void functionDown() {
    // Change to another function
    iFunctionMode--;
    // Cycle back to 9th function if at 1st
    if (iFunctionMode < 1)
        iFunctionMode = 9;
    // Display the function and value
    functionDisplay();
}

/******************************************************
  Read and process remote control RC5 commands
*******************************************************/
void rc5Process() {
    IR_LED = 0; // switch off IR LED
    char iGotCommand = 0;
    if (rc5_address == 0) { // Addresses above zero are not for this device
        // Process commands
        if (iPower) { // Don't process the following if power is off
            // Get current volume level
            switch (rc5_command) {
                // For each command, cause the correct action 
                case 13: // Mute (13 / 0x0D / D)
                    if (rc5_flickBitOld != rc5_flickBit) { // Prevent repeated muting when holding the button
                        // reset mute held flag
                        iMuteHeld = 0;
                        if (iFunctionMode == 0) {
                            // reset timer
                            timer1Reset();
                            // Identify mute button was pressed
                            iMuteWasPressed = 1;
                        } else {
                            // exit function mode
                            iFunctionMode = 0;
                            iGotCommand = 1;
                            // turn off the timer
                            timer1Reset();
                        }
                    } else {
                        // Button held - this should reset timer1 before it interrupts, therefore avoiding processing the command until the button is released
                        iMuteHeld++;
                        // Reset timer
                        timer1Reset();
                        if (iMuteHeld >= MUTE_HOLD_TIME) {
                            // flag for entering function mode
                            iMuteWasPressed = 0;
                            cTask.TASK_TIMER1_FUNC = 1;
                        } else {
                            // Turn on the timer again
                            t1con.TMR1ON = 1;
                        }
                    }
                    break;
                case 16: // Volume up (16 / 0x10 / E)
                    if (iFunctionMode == 0) {
                        iGotCommand = 1;
                        doVolumeUp();
                    } else {
                        functionRaise();
                    }
                    break;
                case 17: // Volume down (17 / 0x11 / F)
                    if (iFunctionMode == 0) {
                        iGotCommand = 1;
                        doVolumeDown();
                    } else {
                        functionLower();
                    }
                    break;
                case 32: // Input right (32 / 0x20 / V)
                    if (rc5_flickBitOld != rc5_flickBit) { // Prevent repeated input changing when holding the button
                        if (iFunctionMode == 0) {
                            iGotCommand = 1;
                            doInputUp();
                        } else {
                            functionUp();
                        }
                    }
                    break;
                case 33: // Input left (33 / 0x21 / U)
                    if (rc5_flickBitOld != rc5_flickBit) { // Prevent repeated input changing when holding the button
                        if (iFunctionMode == 0) {
                            iGotCommand = 1;
                            doInputDown();
                        } else {
                            functionDown();
                        }
                    }
                    break;
            }
        }
        // Process power button regardless of power state
        if (rc5_command == 12) { // Power (12 / 0x0C / A)
            if (rc5_flickBitOld != rc5_flickBit) { // Prevent repeated power when holding the button
                // exit function mode
                iFunctionMode = 0;
                //iPowerExternal = 0; v1.1 removed this to allow forced power off
                // power up or down
                doPower();
            }
        }
        rc5_flickBitOld = rc5_flickBit;
        
        // Generic RS232 send and display if a command was received, and amp powered on
        if (iPower) {
            if (iGotCommand) {
                //sendRS232Status();
                showInput();
                showVolume();
                ledWrite();
            } else if (iFunctionMode) {
                iTimer1SecCounts = 0; // reset 30 sec timeout
            }
        }
    }
}

/*void sendRS232Status() {
    // Array length:
    // P[1]V[2]I[1]F[2]R[2]r[2]C[2]S[2]M[1]E[1]|
    // 26
    // or as bytes - 20
    rs232SendByte('P');
    rs232SendByte(iPower + 48); // ASCII representation
    
    rs232SendByte('V');
    rs232SendNibble(iVolume); // Split into two bytes
    
    rs232SendByte('Q');
    rs232SendByte(iMute + 48); // ASCII representation
    
    rs232SendByte('I');
    rs232SendByte(iActiveInput + 48); // ASCII representation
    
    rs232SendByte('F');
    rs232SendNibble(iFrontBalance); // Split into two bytes
    
    rs232SendByte('R');
    rs232SendNibble(iRearBalance); // Split into two bytes
    
    rs232SendByte('r');
    rs232SendNibble(iRearAdjust); // Split into two bytes
    
    rs232SendByte('C');
    rs232SendNibble(iCentreAdjust); // Split into two bytes
    
    rs232SendByte('S');
    rs232SendNibble(iSubAdjust); // Split into two bytes
    
    rs232SendByte('M');
    rs232SendByte(iSurroundMode + 48); // ASCII representation
    
    rs232SendByte('E');
    rs232SendByte(iExtSurroundMode + 48); // ASCII representation
    
    rs232SendByte('T');
    rs232SendByte(iTrigger + 48); // ASCII representation
    
    // Line feed
    rs232SendByte(10);
}

// Send single character byte over rs232
void rs232SendByte(char c) {
    txreg = c; 
    while (pir1.TXIF == 0); // Wait for byte to be transmitted
    while (txsta.TRMT == 0); // Wait for byte to be transmitted
    //delay_us(10);
}

// Send two bytes over rs232
void rs232SendNibble(char c) {
    // Splits one byte into two nibbles and sends
    // Upper nibble first
    char cu = (c & 0xF0) >> 4;
    // then lower
    char cl = (c & 0x0F);

    rs232SendByte(cu + 48);
    rs232SendByte(cl + 48);
    
    // Translation:
    // Byte of x = nibble character
    // 0   = 0,0
    // 64  = 4,0  0100 = 4,  4  + 48 = 52 : 4  - 0100 0000
    // 100 = 6,4  0110 = 6,  6  + 48 = 54 : 6  - 0110 0100
    // 128 = 8,0  1000 = 8,  8  + 48 = 56 : 8  - 1000 0000
    // 255 = ?,?  1111 = 15, 15 + 48 = 63 : ?  - 1111 1111
    
    // For the character values - 16 possible (adding to 48) gives:
    // 0,1,2,3,4,5,6,7,8,9,:,;,<,=,>,?
}

// V2.0 - send string over rs232
void rs232Print(unsigned char *s) {
      while (*s) {
        rs232SendByte(*s++);
    }
}

// From two bytes containing a nibble of the original byte, reconstruct the original
char rs232ReceiveNibbles(char i, char j) {
    // V3.0 do not need to minus 48 in here now
    // Upper nibble first
    char cu = i << 4;
    // then lower
    char cl = j & 0x0F; // V1.1 changed i to j, V2.0 changed F0 to 0F
    
    return cu + cl;
}

// Process a complete RS232 command
void rs232CommandReceived() {
    // Loop through received bytes
    char i = 0;
    char iNewPower;
    char iCommand;
    char iData1;
    char iData2;
    iNewPower = iPower; // V1.1 set new power to power intially, otherwise power changes when any command received
    while (i < iRS232Index) {
        // V3.0 made this more efficient by reading all three bytes from the buffer once here, then process after
        iCommand = rs232Buffer[i];
        iData1 = rs232Buffer[i + 1] - 48; // This could be 10 (line feed) for the G command, it's not checked though
        if ((i+2) < iRS232Index) // Make a check if the buffer has two more characters
            iData2 = rs232Buffer[i + 2] - 48;
        
        switch (iCommand) {
            case 'G':
                sendRS232Status();
                i = iRS232Index; // Break out of loop for get command (cannot get status and issue commands at the same time)
                break;
            case 'P': // Power
                iNewPower = iData1;
                i++; // Increment i to skip next byte
                break;
            case 'V': // Volume change
                iVolume = rs232ReceiveNibbles(iData1, iData2);
                i+=2; // Double increment to skip next two bytes
                break;
            case 'Q': // Mute
                iMute = iData1;
                i++; // Increment i to skip next byte
                break;
            case 'I': // Input
                if (iData1 < 4) // Valid inputs are 0 to 3
                    iActiveInput = iData1;
                i++; // Increment i to skip next byte
                break;
            case 'F': // Front balance
                iFrontBalance = rs232ReceiveNibbles(iData1, iData2);
                i+=2; // Double increment to skip next two bytes
                break;
            case 'R': // Rear balance
                iRearBalance = rs232ReceiveNibbles(iData1, iData2);
                i+=2; // Double increment to skip next two bytes
                break;
            case 'r': // Rear adjust
                iRearAdjust = rs232ReceiveNibbles(iData1, iData2);
                i+=2; // Double increment to skip next two bytes
                break;
            case 'C': // Centre adjust
                iCentreAdjust = rs232ReceiveNibbles(iData1, iData2);
                i+=2; // Double increment to skip next two bytes
                break;
            case 'S': // Sub adjust
                iSubAdjust = rs232ReceiveNibbles(iData1, iData2);
                i+=2; // Double increment to skip next two bytes
                break;
            case 'M': // Surround Mode
                iSurroundMode = iData1;
                i++; // Increment i to skip next byte
                break;
            case 'E': // Ext Surround Mode
                iExtSurroundMode = iData1;
                i++; // Increment i to skip next byte
                break;
            case 'T': // Trigger state
                iTrigger = iData1;
                i++; // Increment i to skip next byte
                break;
        }
        i++;
    }

    // Reset buffer length
    iRS232Index = 0;

    if (iNewPower != iPower) {
        // V1.1 Only change power if it is different from existing
        // The doPower routine will change the iPower variable
        //iPower = iNewPower;
        doPower();
    }
    // For get status, do nothing, otherwise write the data
    if (iPower && (rs232Buffer[0] != 'G')) { 
        writeVolumes();
        writeRelay();
        showVolume();
        showInput();
        ledWrite();
        t1con.TMR1ON = 1; // Start timer
    }
}*/

/******************************************************
  Events for when Timer 1 has finished counting
*******************************************************/
void onTimer1() {
    // This function will get called every second, if the amplifier is powered on
    iTimer1SecCounts++;
    if (iTimer1SecCounts >= 30) {
        // every 30 seconds, do a reset
        if (iPower && DC_FAIL) {
            // If powered on and DC fail is OK, unmute and show volume/input
            MUTEOUT = 1; // Unmute amps
            RED = 0;
            BLUE = 1;
            // exit function mode
            iFunctionMode = 0;
            // Show volume and input
            showVolume();
            showInput();
            ledWrite();
        }
        iTimer1SecCounts = 0;
    }
    // Count down for power off
    if (EXT_POWER && iPower && iPowerExternal) {
        // If off countdown has reached zero, power off
        if (iTimer1OffCount == 0) {
            // power off
            iTimer1OffCount = 10;
            doPower();
        } else {
            // otherwise decrement counter and display countdown on display
            iTimer1OffCount--;
            ledPrint(1, "Off In ");
            ledCurrentLine = 1;
            ledCurrentCol = 7;
            ledChar(iTimer1OffCount+48, 0);
            ledWrite();
         }
    } else if (iTimer1OffCount < 10) {
        // reset off count, external power must be back on
        iTimer1OffCount = 10;
        // exit function mode (in case it was entered)
        iFunctionMode = 0;
        // Show volume and input
        showVolume();
        showInput();
        ledWrite();
    }
}

//-----------------------------------------------------------------------------
// MAIN PROGRAM
//------------------------------------------------------------------------------
void main() {
    initialise();
    
    while (1) {
        // Task scheduler
        // If there are tasks to be performed, find out the
        // most recent task from the array and execute it
        while (cTask > 0) {
            if (cTask.TASK_INT_EXT2) {
                // A DC fault occurred - show on display
                showFault();
                t1con.TMR1ON = 1; // Switch on the timer - will reset fault if it clears within 5 seconds
                cTask.TASK_INT_EXT2 = 0;
            } else if (cTask.TASK_INT_EXT0) {
                // Power fail occurred
                // When power supply is disconnected, save variables to EEPROM
                saveData();
                cTask.TASK_INT_EXT0 = 0;
            } else if (cTask.TASK_TIMER1_MUTE) {
                // Mute and update display
                doMute();
                //sendRS232Status();
                showVolume();
                ledWrite();
                // reset the timer
                timer1Reset();
                cTask.TASK_TIMER1_MUTE = 0;
            } else if (cTask.TASK_TIMER1_FUNC) {
                // enter function mode
                iFunctionMode = 1;
                // Show first function
                functionDisplay();
                // turn off the timer
                timer1Reset();
                cTask.TASK_TIMER1_FUNC = 0;
            } else if (cTask.TASK_TIMER1) {
                onTimer1(); // Timer 1 has finished counting
                cTask.TASK_TIMER1 = 0;
            } else if (cTask.TASK_INT_EXT1) {
                rc5Process(); // IR sensor received a signal
                IR_LED = 0; // Ensure LED is off
                cTask.TASK_INT_EXT1 = 0;
            //} else if (cTask.TASK_RS232) {
            //    rs232CommandReceived();
            //    cTask.TASK_RS232 = 0;
            }
        }
        
        // Poll for EXT_POWER
        // if EXT_POWER is low (USB trigger high), iPower is off
        // v1.1 and not previously powered on externally
        if (!EXT_POWER && !iPower && !iPowerExternal) {
            // Powered on by external appliance
            iPowerExternal = 1;
            // set the input to the trigged input (input 1) = in2 on the tda7439
            iActiveInput = 0;
            doPower();
        }
        // if EXT_POWER is high (USB trigger low), iPower is on, and was powered on externally
        // ..then power off
        // This is done in a countdown timer - see onTimer1();
        //if (EXT_POWER && iPower && iPowerExternal) {
            // Powered off by external appliance
            // don't power off if iPowerExternal is zero (i.e. powered on by IR)
        //    doPower();
        //}
        // v1.1 If no external power signal, and power is off anyway, reset the iPowerExternal indicator
        if (EXT_POWER && !iPower) {
            iPowerExternal = 0;
        }
    }
} 
