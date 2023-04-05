#ifndef _AMPCONTROL3_H_
#define _AMPCONTROL3_H_

#include <system.h>
#include <stdio.h>

// Tasks
char cTask = 0;
#define TASK_INT_EXT0		0
//#define TASK_RS232			1
#define TASK_INT_TX			2
#define TASK_INT_EXT1		3
#define TASK_INT_EXT2		4
#define TASK_TIMER1_MUTE	5
#define TASK_TIMER1_FUNC    6
#define TASK_TIMER1			7

// LED and Relay outputs
#define POWEROUT (porta.0) // Output for the main power relays
#define MUTEOUT (porta.1) // Output for the unmute relay
#define IR_LED (porta.2) // Red IR LED pin
#define RED (porta.3) // Red LED pin
#define GREEN (porta.4) // Green LED pin
#define BLUE (porta.5) // Blue LED pin

// Pins for monitoring
#define PWR_FAIL (portb.0) // AC detection for when amp is unplugged - if this is high, then AC was removed
#define IR_PIN (portb.1) // IR detector input pin
#define DC_FAIL (portb.2) // Amp DC detection - if this is low, then in a fault condition!
#define EXT_POWER (portd.6) // Externally triggered power - if this is low, then a device connected by USB is on

// MAX7219 pins
#define LEDDATA (portb.3)
#define LEDCLOCK (portb.4)
#define LEDLATCH (portb.5)
#define LEDDISPON (portd.7) // v3.0 added this to control power Vss to MAX7219 - low = display on

// PGA2310 pins
#define VOLDATA (portc.0)
#define VOLCLOCK (portc.1)
#define VOLLATCH (portc.2)

// 74HCT595 pins
#define RELAYDATA (porte.0)
#define RELAYCLOCK (porte.1)
#define RELAYLATCH (porte.2)

// MAX7219 bit-bang delay
#define LEDDELAYUS 40

// Timer2 preloads for IR timing
// 21 for 208us on 10MHz, 1:8 postscaler
// 34 for 16MHz, 50 for 24MHz
#define IR_PR2_200US 21
// 92 for 872us on 10MHz, 1:8 postscaler
// 148 for 16MHz, 222 for 24MHz
#define IR_PR2_890US 92

// For setting TMR1 to 3072 (tmr1h=12) - so it interrupts after roughly 200ms at 10Mhz, 1:8 prescaler
#define TMR1H_SET 12
#define TMR1_1SEC 5

#define RX_BUFFER_SIZE	30

char iVolume = 0; // Overall system volume 0-255
char iMute = 0; // 1 if muted
char iMuteHeld = 0;
char iMuteWasPressed = 0;
signed char iFrontBalance = 0; // signed offset to front speakers left/right balance
signed char iRearBalance = 0; // signed offset to rear speakers left/right balance
signed char iRearAdjust = 0; // signed offset to rear speakers volume
signed char iCentreAdjust = 0; // signed offset to centre speaker volume
signed char iSubAdjust = 0; // signed offset to subwoofer volume

char iPower = 0; // 1 if powered on
char iPowerExternal = 0; // 1 if powered on by external USB trigger
char iActiveInput = 0; // The active input 0 to 3
char iTrigger = 1; // The active 12V trigger outputs - by default, trigger 1 on, trigger 2 off
char iSurroundMode = 1; // Surround sound mode. 0 = stereo, 1 = all 6 channels
char iExtSurroundMode = 1; // Surround sound decoding. 0 = internal hafler, 1 = external decoded via 5.1 input
char iFunctionMode = 0;

// Buffer and index pointer for RS232 receiving
//char iRS232Index;
//char rs232Buffer[RX_BUFFER_SIZE];

// Timer 1 overflow counting
char iTimer1Count = 0;
char iTimer1SecCounts = 0;
char iTimer1OffCount = 10;

// RC5 message time (~114ms) multiple
#define MUTE_HOLD_TIME 9

// Original table
/***************************************************************************************

Characters:
    7 6 5 4  3 2 1 0
    p a b c  d e f g
  = 0 0 0 0  0 0 0 0  00
0 = 0 1 1 1  1 1 1 0  7E
1 = 0 0 1 1  0 0 0 0  30
2 = 0 1 1 0  1 1 0 1  6D
3 = 0 1 1 1  1 0 0 1  79
4 = 0 0 1 1  0 0 1 1  33
5 = 0 1 0 1  1 0 1 1  5B
6 = 0 1 0 1  1 1 1 1  5F
7 = 0 1 1 1  0 0 0 0  70
8 = 0 1 1 1  1 1 1 1  7F
9 = 0 1 1 1  1 0 1 1  7B
- = 0 0 0 0  0 0 0 1  01

A = 0 1 1 1  0 1 1 1  77
b = 0 0 0 1  1 1 1 1  1F
c = 0 0 0 0  1 1 0 1  0D
d = 0 0 1 1  1 1 0 1  3D
E = 0 1 0 0  1 1 1 1  4F
F = 0 1 0 0  0 1 1 1  47
g = 0 1 1 1  1 0 1 1  7B
h = 0 0 0 1  0 1 1 1  17
H = 0 0 1 1  0 1 1 1  37
i = 0 0 0 1  0 0 0 0  10
L = 0 0 0 0  1 1 1 0  0E
o = 0 0 0 1  1 1 0 1  1D
P = 0 1 1 0  0 1 1 1  67
r = 0 0 0 0  0 1 0 1  05
S = 0 1 0 1  1 0 1 1  5B
T = 0 1 0 0  0 1 1 0  46
t = 0 0 0 0  1 1 1 1  0F
u = 0 0 0 1  1 1 0 0  1C
y = 0 0 1 1  0 0 1 1  33

**************************************************************************************/

// This table, taken from http://www.ccsinfo.com/forum/viewtopic.php?p=57034 is ideal for writing the converted character out
// However as the dot is the MSB for the MAX7219 when writing, bit shift 1 to the right
// Converted using spreadsheet formula ="0x"&RIGHT("0"&DEC2HEX(BITRSHIFT(HEX2DEC(RIGHT(A1,2)),1)),2)
// Modification - capital T output differently
const char displayASCIItoSeg[] = {// ASCII to SEVEN-SEGMENT conversion table
    0x00,       // ' ', 
    0x00,       // '!', No seven-segment conversion for exclamation point
    0x22,       // '"', Double quote
    0x00,       // '#', Pound sign
    0x00,       // '$', No seven-segment conversion for dollar sign
    0x00,       // '%', No seven-segment conversion for percent sign
    0x00,       // '&', No seven-segment conversion for ampersand
    0x20,       // ''', Single quote
    0x4E,       // '(', Same as '['
    0x78,       // ')', Same as ']'
    0x00,       // '*', No seven-segment conversion for asterix
    0x00,       // '+', No seven-segment conversion for plus sign
    0x00,       // ', '
    0x01,       // '-', Minus sign
    0x00,       // '.', No seven-segment conversion for period
    0x00,       // '/', No seven-segment conversion for slash
    0x7E,       // '0', 
    0x30,       // '1', 
    0x6D,       // '2', 
    0x79,       // '3', 
    0x33,       // '4', 
    0x5B,       // '5', 
    0x5F,       // '6', 
    0x70,       // '7', 
    0x7F,       // '8', 
    0x7B,       // '9', 
    0x00,       // ':', No seven-segment conversion for colon
    0x00,       // ';', No seven-segment conversion for semi-colon
    0x00,       // '<', No seven-segment conversion for less-than sign
    0x09,       // '=', Equal sign
    0x00,       // '>', No seven-segment conversion for greater-than sign
    0x65,       //'?', Question mark
    0x00,       // '@', No seven-segment conversion for commercial at-sign
    0x77,       // 'A', 
    0x1F,       // 'B', Actually displayed as 'b'
    0x4E,       // 'C', 
    0x3D,       // 'D', Actually displayed as 'd'
    0x4F,       // 'E', 
    0x47,       // 'F', 
    0x5E,       // 'G', Actually displayed as 'g'
    0x37,       // 'H', 
    0x30,       // 'I', Same as '1'
    0x3C,       // 'J', 
    0x00,       // 'K', No seven-segment conversion
    0x0E,       // 'L', 
    0x00,       // 'M', No seven-segment conversion
    0x15,       // 'N', Actually displayed as 'n'
    0x7E,       // 'O', Same as '0'
    0x67,       // 'P', 
    0x00,       // 'Q', No seven-segment conversion
    0x05,       // 'R', Actually displayed as 'r'
    0x5B,       // 'S', Same as '5'
    0x70,       // 'T', Displayed as 7
    0x3E,       // 'U', 
    0x00,       // 'V', No seven-segment conversion
    0x00,       // 'W', No seven-segment conversion
    0x00,       // 'X', No seven-segment conversion
    0x3B,       // 'Y', 
    0x00,       // 'Z', No seven-segment conversion
    0x00,       // '[', 
    0x00,       // '\', No seven-segment conversion
    0x00,       // ']', 
    0x00,       // '^', No seven-segment conversion
    0x00,       // '_', Underscore
    0x00,       // '`', No seven-segment conversion for reverse quote
    0x7D,       // 'a', 
    0x1F,       // 'b', 
    0x0D,       // 'c', 
    0x3D,       // 'd', 
    0x6F,       // 'e', 
    0x47,       // 'f', Actually displayed as 'F'
    0x5E,       // 'g', 
    0x17,       // 'h', 
    0x10,       // 'i', 
    0x3C,       // 'j', Actually displayed as 'J'
    0x00,       // 'k', No seven-segment conversion
    0x0E,       // 'l', Actually displayed as 'L'
    0x00,       // 'm', No seven-segment conversion
    0x15,       // 'n', 
    0x1D,       // 'o', 
    0x67,       // 'p', Actually displayed as 'P'
    0x00,       // 'q', No seven-segment conversion
    0x05,       // 'r', 
    0x5B,       // 's', Actually displayed as 'S'
    0x0F,       // 't', 
    0x1C,       // 'u', 
    0x00,       // 'v', No seven-segment conversion
    0x00,       // 'w', No seven-segment conversion
    0x00,       // 'x', No seven-segment conversion
    0x3B,       // 'y', Actually displayed as 'Y'
    0x00        // 'z', No seven-segment conversion
}; 

// Functions
//void rs232SendByte(char c);
//void rs232SendNibble(char c);
//void rs232Print(unsigned char *s);
//void bluetoothSetup();

void timer1Reset();

void saveData();
void eepromWrite(char address, char data);
void readData();
char eepromRead(char address);

char ledCurrentLine = 1;
char ledCurrentCol = 0;
void ledPrint(char iLine, unsigned char *s);
void ledChar(char iChar, char iHasDot);
void ledTest();
void ledSetup();
void ledOn();
void ledOff();
void ledClear();
void ledWrite();
void ledSendChar(char iData);
void ledLatchUp();
void ledLatchDown();

void printMute();
void doPower();
void doMute();
void showVolume();
void showInput();
void showFault();

void writeRelay();
void doInputUp();
void doInputDown();

void writeVolumes();
char getAdjustedVolume(signed char iVolAdj);

void rc5HalfPulse();
void rc5QtrPulse();

//void sendRS232Status();

char getVolume();
void setVolume(char iVol);
char getFrontBalance();
char getRearBalance();
char getRearAdjust();
char getCentreAdjust();
char getSubAdjust();
char getSurroundMode();
char getExtSurroundMode();
char getActiveInput();

void resetTimer1Count();

void onInterruptEXT0();
void onInterruptEXT2();
void functionDisplay();
void functionValueDisplay(char iValue);
char functionValueRaise(char iValue);
char functionValueLower(char iValue);
void functionRaise();
void functionLower();
void functionUp();
void functionDown();
void rc5Process();

// For IR
char intfCounter = 0;
char rc5_Held = 0;
unsigned short rc5_inputData; // input data takes 12 bits
char rc5_bitCount;
char rc5_logicInterval, rc5_logicChange;
enum {
    rc5_idleState,
    rc5_initialWaitState,
    rc5_startBitState,
    rc5_captureBitState
};

char rc5_currentState = rc5_idleState;
char rc5_pinState = 1;

char rc5_flickBit = 0;
char rc5_flickBitOld = 0;
char rc5_address = 0;
char rc5_command = 0;

#endif //_AMPCONTROL3_H_
