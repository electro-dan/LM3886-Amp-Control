/*
 * References:
 * https://www.allaboutcircuits.com/projects/control-an-arduino-using-your-phone/
 * http://codeisall.com/android-expandable-layout/
 */

package uk.co.electro_dan.ampcontrol;

import android.app.ProgressDialog;
import android.bluetooth.BluetoothAdapter;
import android.bluetooth.BluetoothDevice;
import android.bluetooth.BluetoothSocket;
import android.content.Intent;
import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.support.v7.app.AppCompatActivity;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.CheckBox;
import android.widget.RadioButton;
import android.widget.RadioGroup;
import android.widget.SeekBar;
import android.widget.TextView;
import android.widget.Toast;
import android.widget.ToggleButton;

import com.github.aakira.expandablelayout.ExpandableRelativeLayout;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.util.Set;
import java.util.UUID;

public class MainActivity extends AppCompatActivity {

    private static final String TAG = "AMP Control";

    // Bluetooth variables
    private final String DEVICE_NAME = "Amp";
    private final UUID PORT_UUID = UUID.fromString("00001101-0000-1000-8000-00805f9b34fb"); //Serial Port Service ID
    private BluetoothDevice btDevice;
    private BluetoothSocket btSocket;
    private OutputStream outputStream;
    private InputStream inputStream;
    boolean isConnected;
    boolean doStopListenThread;

    // Amplifier variables
    public int iPower = 0;
    public int iMute = 0;
    public int iVolLevel = 0;
    public int iActiveInput = 0;
    public int iSurroundMode = 1;
    public int iExtSurroundMode = 1;
    public int iFrontBalance = 0;
    public int iRearBalance = 0;
    public int iRearAdjust = 0;
    public int iCentreAdjust = 0;
    public int iSubAdjust = 0;
    public int iTrigger = 0;
    
    // GUI elements
    private Button buttonVolUp;
    private Button buttonVolDown;
    private SeekBar seekBar;
    private ToggleButton toggleConnect;
    private ToggleButton togglePower;
    private ToggleButton toggleMute;
    private RadioGroup radiogroup;
    private TextView txtVol;

    private CheckBox check51Mode;
    private CheckBox checkHafler;
    private CheckBox checkTrigger1;
    private CheckBox checkTrigger2;
    private SeekBar seekBarFrontBal;
    private TextView txtFrontBal;
    private SeekBar seekBarRearBal;
    private TextView txtRearBal;
    private SeekBar seekBarRearAdj;
    private TextView txtRearAdj;
    private SeekBar seekBarCentreAdj;
    private TextView txtCentreAdj;
    private SeekBar seekBarSubAdj;
    private TextView txtSubAdj;

    private ProgressDialog pDialog;
    private Button expandableButton1;
    private ExpandableRelativeLayout expandableLayout1;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        buttonVolDown = (Button) findViewById(R.id.buttonVolDown);
        buttonVolUp = (Button) findViewById(R.id.buttonVolUp);
        seekBar = (SeekBar) findViewById(R.id.seekBar);
        txtVol = (TextView) findViewById(R.id.txtVol);
        toggleConnect = (ToggleButton) findViewById(R.id.toggleConnect);
        togglePower = (ToggleButton) findViewById(R.id.togglePower);
        toggleMute = (ToggleButton) findViewById(R.id.toggleMute);
        radiogroup = (RadioGroup) findViewById(R.id.radioGroup1);
        expandableButton1 = (Button) findViewById(R.id.expandableButton1);

        check51Mode = (CheckBox) findViewById(R.id.check51Mode);
        checkHafler = (CheckBox) findViewById(R.id.checkHafler);
        checkTrigger1 = (CheckBox) findViewById(R.id.checkTrigger1);
        checkTrigger2 = (CheckBox) findViewById(R.id.checkTrigger2);
        seekBarFrontBal = (SeekBar) findViewById(R.id.seekBarFrontBal);
        txtFrontBal = (TextView) findViewById(R.id.txtFrontBal);
        seekBarRearBal = (SeekBar) findViewById(R.id.seekBarRearBal);
        txtRearBal = (TextView) findViewById(R.id.txtRearBal);
        seekBarRearAdj = (SeekBar) findViewById(R.id.seekBarRearAdj);
        txtRearAdj = (TextView) findViewById(R.id.txtRearAdj);
        seekBarCentreAdj = (SeekBar) findViewById(R.id.seekBarCentreAdj);
        txtCentreAdj = (TextView) findViewById(R.id.txtCentreAdj);
        seekBarSubAdj = (SeekBar) findViewById(R.id.seekBarSubAdj);
        txtSubAdj = (TextView) findViewById(R.id.txtSubAdj);

        // Disable the GUI on startup
        setUiEnabled(false);

        // This is the action when toggling to connect to the bluetooth adapter
        toggleConnect.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View arg0) {
                if (toggleConnect.isChecked()) {
                    // If the user checked to connect...
                    // Show connecting dialog
                    pDialog = ProgressDialog.show(MainActivity.this, "Connecting", "Connecting to bluetooth, please wait...", true);
                    // Call the initialisation routine
                    btInit();
                } else {
                    // If the user checked to disconnect...
                    // Set disconnected
                    isConnected = false;
                    // Stop the listener thread
                    doStopListenThread = true;
                    // Disable the GUI
                    setUiEnabled(false);
                    // Close the bluetooth objects
                    try {
                        if (outputStream != null) outputStream.close();
                        if (inputStream != null) inputStream.close();
                        if (btSocket != null) btSocket.close();
                    } catch (IOException ioe) {
                        Log.e(TAG, "Can't disconnect", ioe);
                    }
                }
            }
        });

        // Add click handler to volume down button
        buttonVolDown.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View arg0) {
                // Toggle advanced settings
                iVolLevel -= 2;
                if (iVolLevel < 0)
                    iVolLevel = 0;
                // First call sets the slider
                updateLevelDisplay(false);
                // Second call sends the message
                updateLevelDisplay(true);
            }
        });

        // Add click handler to volume down button
        buttonVolUp.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View arg0) {
                // Toggle advanced settings
                iVolLevel += 2;
                if (iVolLevel > 255)
                    iVolLevel = 255;
                // First call sets the slider
                updateLevelDisplay(false);
                // Second call sends the message
                updateLevelDisplay(true);
            }
        });
        
        // Add a change listener to the seek bar
        seekBar.setOnSeekBarChangeListener(new SeekBar.OnSeekBarChangeListener() {
            public void onStopTrackingTouch(SeekBar bar) {
            }
            public void onStartTrackingTouch(SeekBar bar) {
            }
            public void onProgressChanged(SeekBar bar,int iProgress, boolean fromUser) {
                // Un-mute first
                if (toggleMute.isChecked()) {
                    // Un-mute if slider is dragged
                    toggleMute.setChecked(false);
                    iMute = 0;
                    sendMessageToAmp(R.string.msgMuteSend);
                    try {
                        Thread.sleep(200);
                    } catch (InterruptedException mie) {
                        Log.i("UI", "SeekBar sleep thread was interrupted");
                    }
                }
                updateLevelDisplay(fromUser);
            }
        });

        // Add change listener to the radio button group
        radiogroup.setOnCheckedChangeListener(new RadioGroup.OnCheckedChangeListener() {
            public void onCheckedChanged(RadioGroup group, int checkedId) {

                RadioButton checkedRadioButton = (RadioButton)findViewById(checkedId);
                TextView txtInputSelected = (TextView)findViewById(R.id.textView4);

                if ((checkedRadioButton != null) && (txtInputSelected != null)) {
                    // This switch comparing each radio ID against the checkedId is more reliable than getRadioInput
                    if (checkedRadioButton.isChecked()) {
                        switch (checkedId) {
                            case R.id.radioButton1:
                                iActiveInput = 0;
                                break;
                            case R.id.radioButton2:
                                iActiveInput = 1;
                                break;
                            case R.id.radioButton3:
                                iActiveInput = 2;
                                break;
                            case R.id.radioButton4:
                                iActiveInput = 3;
                                break;
                        }
                    }

                    txtInputSelected.setText(checkedRadioButton.getText());

                    // Set state to write relay
                    if (toggleConnect.isChecked()) {
                        sendMessageToAmp(R.string.msgInputSend);
                    }
                }
            }
        });

        // Add click handler to the input settings button
        togglePower.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View arg0) {
                // Change power status
                doPowerChange();
            }
        });

        toggleMute.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View arg0) {
                // Mute
                if (toggleConnect.isChecked()) {
                    if (toggleMute.isChecked())
                        iMute = 1;
                    else
                        iMute = 0;
                    sendMessageToAmp(R.string.msgMuteSend);
                }
            }
        });


        // Add click handler to expand button, for advanced settings
        expandableButton1.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View arg0) {
                // Toggle advanced settings
                expandableLayout1 = (ExpandableRelativeLayout) findViewById(R.id.expandableLayout1);
                if (expandableLayout1 != null)
                    expandableLayout1.toggle(); // toggle expand and collapse
            }
        });

        // Add click handler to the Hafler button
        checkHafler.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View arg0) {
                // Toggle surround
                if (toggleConnect.isChecked()) {
                    if (checkHafler.isChecked())
                        iSurroundMode = 1;
                    else
                        iSurroundMode = 0;
                    sendMessageToAmp(R.string.msgSurroundSend);
                }
            }
        });

        // Add click handler to the 5.1 mode button
        check51Mode.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View arg0) {
                // Toggle surround
                if (toggleConnect.isChecked()) {
                    if (check51Mode.isChecked())
                        iExtSurroundMode = 1;
                    else
                        iExtSurroundMode = 0;
                    sendMessageToAmp(R.string.msgExtSurroundSend);
                }
            }
        });

        // Add click handler to the Hafler button
        checkTrigger1.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View arg0) {
                // Toggle surround
                if (toggleConnect.isChecked()) {
                    if (checkTrigger1.isChecked())
                        iTrigger |= 1; // Set bit 0
                    else
                        iTrigger &= 2; // Clear bit 1
                    sendMessageToAmp(R.string.msgTriggerSend);
                }
            }
        });

        // Add click handler to the Hafler button
        checkTrigger2.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View arg0) {
                // Toggle surround
                if (toggleConnect.isChecked()) {
                    if (checkTrigger2.isChecked())
                        iTrigger |= 2; // Set bit 1
                    else
                        iTrigger &= 1; // Clear bit 1
                    sendMessageToAmp(R.string.msgTriggerSend);
                }
            }
        });

        // Add a change listener to the seek bar
        seekBarFrontBal.setOnSeekBarChangeListener(new SeekBar.OnSeekBarChangeListener() {
            public void onStopTrackingTouch(SeekBar bar) {
            }
            public void onStartTrackingTouch(SeekBar bar) {
            }
            public void onProgressChanged(SeekBar bar,int iProgress, boolean fromUser) {
                updateFrontBalance(fromUser);
            }
        });

        // Add a change listener to the seek bar
        seekBarRearBal.setOnSeekBarChangeListener(new SeekBar.OnSeekBarChangeListener() {
            public void onStopTrackingTouch(SeekBar bar) {
            }
            public void onStartTrackingTouch(SeekBar bar) {
            }
            public void onProgressChanged(SeekBar bar,int iProgress, boolean fromUser) {
                updateRearBalance(fromUser);
            }
        });

        // Add a change listener to the seek bar
        seekBarRearAdj.setOnSeekBarChangeListener(new SeekBar.OnSeekBarChangeListener() {
            public void onStopTrackingTouch(SeekBar bar) {
            }
            public void onStartTrackingTouch(SeekBar bar) {
            }
            public void onProgressChanged(SeekBar bar,int iProgress, boolean fromUser) {
                updateRearAdjust(fromUser);
            }
        });

        // Add a change listener to the seek bar
        seekBarCentreAdj.setOnSeekBarChangeListener(new SeekBar.OnSeekBarChangeListener() {
            public void onStopTrackingTouch(SeekBar bar) {
            }
            public void onStartTrackingTouch(SeekBar bar) {
            }
            public void onProgressChanged(SeekBar bar,int iProgress, boolean fromUser) {
                updateCentreAdjust(fromUser);
            }
        });

        // Add a change listener to the seek bar
        seekBarSubAdj.setOnSeekBarChangeListener(new SeekBar.OnSeekBarChangeListener() {
            public void onStopTrackingTouch(SeekBar bar) {
            }
            public void onStartTrackingTouch(SeekBar bar) {
            }
            public void onProgressChanged(SeekBar bar,int iProgress, boolean fromUser) {
                updateSubAdjust(fromUser);
            }
        });
    }

    // Disables or enables the interface based on the bluetooth connection
    public void setUiEnabled(boolean bool) {
        togglePower.setEnabled(bool);

        // For the rest of the components, make false if power is off
        bool = bool && (iPower == 1);

        seekBar.setEnabled(bool);
        buttonVolDown.setEnabled(bool);
        buttonVolUp.setEnabled(bool);
        toggleMute.setEnabled(bool);
        radiogroup.setEnabled(bool);
        for (int i = 0; i < radiogroup.getChildCount(); i++) {
            RadioButton btn = (RadioButton) radiogroup.getChildAt(i);
            btn.setEnabled(bool);
        }
        check51Mode.setEnabled(bool);
        checkHafler.setEnabled(bool);
        checkTrigger1.setEnabled(bool);
        checkTrigger2.setEnabled(bool);
        seekBarFrontBal.setEnabled(bool);
        seekBarRearBal.setEnabled(bool);
        seekBarRearAdj.setEnabled(bool);
        seekBarCentreAdj.setEnabled(bool);
        seekBarSubAdj.setEnabled(bool);
    }

    // Initialisation method for bluetooth. Will check bluetooth support, if present, requests it to be enabled. If enabled, goes straight to bond.
    public void btInit() {
        BluetoothAdapter btAdapter = BluetoothAdapter.getDefaultAdapter();
        if (btAdapter == null) {
            Toast.makeText(getApplicationContext(), "Device doesn't Support Bluetooth", Toast.LENGTH_SHORT).show();
        } else if (!btAdapter.isEnabled()) {
            Intent intentEnableAdapter = new Intent(BluetoothAdapter.ACTION_REQUEST_ENABLE);
            startActivityForResult(intentEnableAdapter, 0);
        } else {
            btBond();
        }
    }

    // This is called after the user has enabled bluetooth
    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data){
        super.onActivityResult(requestCode, resultCode, data);
        if (resultCode == RESULT_OK) {
            Log.i("Bluetooth", "Attempting to bond");
            // Now bluetooth is enabled, bond the device
            btBond();
        } else if (resultCode == RESULT_CANCELED) {
            if (pDialog != null)
                pDialog.dismiss();
            Toast.makeText(getApplicationContext(), "Enabling bluetooth cancelled", Toast.LENGTH_SHORT).show();
            toggleConnect.setChecked(false);
        }
    }

    // Checks bonded devices. Request to pair made here
    public void btBond() {
        boolean isFound = false;
        BluetoothAdapter btAdapter = BluetoothAdapter.getDefaultAdapter();
        Set<BluetoothDevice> bondedDevices = btAdapter.getBondedDevices();
        if (bondedDevices.isEmpty()) {
            Toast.makeText(getApplicationContext(), "Please Pair the Device first", Toast.LENGTH_SHORT).show();
            if (pDialog != null)
                pDialog.dismiss();
        } else {
            Log.i("Bluetooth", "Checking bonded devices");
            for (BluetoothDevice iterator : bondedDevices) {
                // If we found a paired device named 'Amp', we can connect to this one
                if (iterator.getName().equals(DEVICE_NAME)) {
                    btDevice = iterator;
                    isFound = true;
                    Log.i("Bluetooth", "Found " + DEVICE_NAME);
                    break;
                }
            }
        }
        // If we found 'Amp' is paired, now connect
        if (isFound)
            btConnect();
    }


    // Connect to the RF comm interface
    public void btConnect() {
        // Connect in a thread to prevent locking the GUI
        new Thread() {
            @Override
            public void run() {

                try {
                    btSocket = btDevice.createRfcommSocketToServiceRecord(PORT_UUID);
                    btSocket.connect();
                    isConnected = true;
                } catch (IOException e) {
                    e.printStackTrace();
                }
                // If we connected OK - get the input and output steams
                if (isConnected) {
                    try {
                        outputStream = btSocket.getOutputStream();
                    } catch (IOException e) {
                        isConnected = false;
                        e.printStackTrace();
                    }
                    try {
                        inputStream = btSocket.getInputStream();
                    } catch (IOException e) {
                        isConnected = false;
                        e.printStackTrace();
                    }
                }

                // Once connection is complete, send back to the handler
                Message msg = btConnectionHandler.obtainMessage();
                btConnectionHandler.sendMessage(msg);
            }
        }.start();
    }

    // Handles a completed bluetooth connection
    private final Handler btConnectionHandler = new Handler(new Handler.Callback() {
        @Override
        public boolean handleMessage(Message msg) {
            // Dismiss the connecting... dialog
            if (pDialog != null)
                pDialog.dismiss();

            // Based on connection
            if (isConnected) {
                // Enable the GUI
                toggleConnect.setChecked(true);
                //setUiEnabled(true); - now done in the receive handler based on power status of amp
                doStopListenThread = false;
                beginListenForData();
                // Get the status from the Amp
                sendMessageToAmp(R.string.msgGetStatus);
            } else {
                // If not connected, disable GUI
                toggleConnect.setChecked(false);
                setUiEnabled(false);
                // Show a message
                Toast.makeText(getApplicationContext(), "Could not connect to amplifier", Toast.LENGTH_SHORT).show();
            }
            return false;
        }
    });

    // This is the listener method, running a thread to listen for incoming status info from the Amp
    private void beginListenForData() {

        new Thread() {
            @Override
            public void run() {

                // Endless until requested to stop
                while (!doStopListenThread) {
                    try {
                        // Get the input stream
                        BufferedReader brInputStream = new BufferedReader(new InputStreamReader(inputStream));
                        final String sBTReceived = brInputStream.readLine();
                        if (sBTReceived != null) {

                            Log.d(TAG, "RECD: " + sBTReceived);

                            // Typical input string = P0V00Q0I0F00R00r00C00S00M1E1T1
                            // Valid stream must start with P
                            if (sBTReceived.startsWith("P")) {
                                // Valid stream must be 30 bytes long
                                if (sBTReceived.length() == 30) {
                                    // All OK - process input data
                                    // Start looping over the information - start from the 2nd character
                                    for (int iReceivedCounter = 1; iReceivedCounter < 30; iReceivedCounter++) {
                                        // Check the previous character
                                        int iIn;
                                        // Check the previous character in a switch
                                        switch (sBTReceived.charAt(iReceivedCounter - 1)) {
                                            case 'P':
                                                // Power status 1 or 0
                                                iIn = Character.getNumericValue(sBTReceived.charAt(iReceivedCounter));
                                                if ((iIn == 0) || (iIn == 1))
                                                    iPower = iIn;
                                                break;
                                            case 'Q':
                                                // Mute status 1 or 0
                                                iIn = Character.getNumericValue(sBTReceived.charAt(iReceivedCounter));
                                                if ((iIn == 0) || (iIn == 1))
                                                    iMute = iIn;
                                                break;
                                            case 'V':
                                                // Volume level comes from the two nibbles
                                                iVolLevel = rs232ReceiveNibble(sBTReceived.charAt(iReceivedCounter), sBTReceived.charAt(iReceivedCounter + 1), false);
                                                // Advance forward another character as this command was two bytes long
                                                iReceivedCounter++;
                                                break;
                                            case 'I':
                                                // Active input 1 to 5
                                                iIn = Character.getNumericValue(sBTReceived.charAt(iReceivedCounter));
                                                if ((iIn >= 0) && (iIn <= 5))
                                                    iActiveInput = iIn;
                                                break;
                                            case 'F':
                                                // Volume level comes from the two nibbles
                                                iFrontBalance = rs232ReceiveNibble(sBTReceived.charAt(iReceivedCounter), sBTReceived.charAt(iReceivedCounter + 1), true);
                                                // Advance forward another character as this command was two bytes long
                                                iReceivedCounter++;
                                                break;
                                            case 'R':
                                                // Volume level comes from the two nibbles
                                                iRearBalance = rs232ReceiveNibble(sBTReceived.charAt(iReceivedCounter), sBTReceived.charAt(iReceivedCounter + 1), true);
                                                // Advance forward another character as this command was two bytes long
                                                iReceivedCounter++;
                                                break;
                                            case 'r':
                                                // Volume level comes from the two nibbles
                                                iRearAdjust = rs232ReceiveNibble(sBTReceived.charAt(iReceivedCounter), sBTReceived.charAt(iReceivedCounter + 1), true);
                                                // Advance forward another character as this command was two bytes long
                                                iReceivedCounter++;
                                                break;
                                            case 'C':
                                                // Volume level comes from the two nibbles
                                                iCentreAdjust = rs232ReceiveNibble(sBTReceived.charAt(iReceivedCounter), sBTReceived.charAt(iReceivedCounter + 1), true);
                                                // Advance forward another character as this command was two bytes long
                                                iReceivedCounter++;
                                                break;
                                            case 'S':
                                                // Volume level comes from the two nibbles
                                                iSubAdjust = rs232ReceiveNibble(sBTReceived.charAt(iReceivedCounter), sBTReceived.charAt(iReceivedCounter + 1), true);
                                                // Advance forward another character as this command was two bytes long
                                                iReceivedCounter++;
                                                break;
                                            case 'M':
                                                // Surround mode 1 or 0
                                                iIn = Character.getNumericValue(sBTReceived.charAt(iReceivedCounter));
                                                if ((iIn == 0) || (iIn == 1))
                                                    iSurroundMode = iIn;
                                                break;
                                            case 'E':
                                                // External surround mode 1 or 0
                                                iIn = Character.getNumericValue(sBTReceived.charAt(iReceivedCounter));
                                                if ((iIn == 0) || (iIn == 1))
                                                    iExtSurroundMode = iIn;
                                                break;
                                            case 'T':
                                                // Trigger activation - 0, 1, 2 or 3
                                                iIn = Character.getNumericValue(sBTReceived.charAt(iReceivedCounter));
                                                if ((iIn >= 0) && (iIn <= 3))
                                                    iTrigger = iIn;
                                                break;
                                        }
                                    }

                                    // Send to handler to update the GUI
                                    Message msg = btReceivedUpdateHandler.obtainMessage();
                                    btReceivedUpdateHandler.sendMessage(msg);

                                }
                            }

                        }
                    } catch (IOException ex) {
                        doStopListenThread = true;
                    }
                }
            }
        }.start();
    }

    // Handler based on updated variables received from Amp
    private final Handler btReceivedUpdateHandler = new Handler(new Handler.Callback() {

        @Override
        public boolean handleMessage(Message msg) {
            // Update the app display
            togglePower.setChecked(iPower == 1);
            setUiEnabled(isConnected);
            updateLevelDisplay(false);
            setRadioInput();
            toggleMute.setChecked(iMute == 1);
            check51Mode.setChecked(iExtSurroundMode == 1);
            checkHafler.setChecked(iSurroundMode == 1);
            checkTrigger1.setChecked((iTrigger & 1) > 0);
            checkTrigger2.setChecked((iTrigger & 2) > 0);
            updateFrontBalance(false);
            updateRearBalance(false);
            updateRearAdjust(false);
            updateCentreAdjust(false);
            updateSubAdjust(false);
            return false;
        }
    });

    // Send a message to the amp via bluetooth
    private void sendMessageToAmp(int arg1) {
        if (toggleConnect.isChecked()) {
            // Build correct message
            StringBuilder sbOut = new StringBuilder();
            sbOut.append("Amp1:"); // Key

            // Depending on the argument, sends the command indicator based on the shared strings, and then the command value
            switch (arg1) {
                case R.string.msgGetStatus :
                    // Just send G
                    sbOut.append(getResources().getString(arg1));
                    break;
                case R.string.msgPowerSend :
                    // Send P followed by power value
                    sbOut.append(getResources().getString(arg1));
                    sbOut.append(iPower);
                    break;
                case R.string.msgMuteSend :
                    // Send P followed by power value
                    sbOut.append(getResources().getString(arg1));
                    sbOut.append(iMute);
                    break;
                case R.string.msgVolumeSend :
                    // Send V followed by two bytes representing volume nibbles
                    sbOut.append(getResources().getString(arg1));
                    sbOut.append(rs232SendNibble(iVolLevel));
                    break;
                case R.string.msgInputSend :
                    // Send I followed by input value
                    sbOut.append(getResources().getString(arg1));
                    sbOut.append(iActiveInput);
                    break;
                case R.string.msgFrontBalanceSend :
                    // Send F followed by two bytes representing volume nibbles
                    sbOut.append(getResources().getString(arg1));
                    sbOut.append(rs232SendNibble(iFrontBalance));
                    break;
                case R.string.msgRearBalanceSend :
                    // Send R followed by two bytes representing volume nibbles
                    sbOut.append(getResources().getString(arg1));
                    sbOut.append(rs232SendNibble(iRearBalance));
                    break;
                case R.string.msgRearAdjustSend :
                    // Send r followed by two bytes representing volume nibbles
                    sbOut.append(getResources().getString(arg1));
                    sbOut.append(rs232SendNibble(iRearAdjust));
                    break;
                case R.string.msgCenAdjustSend :
                    // Send C followed by two bytes representing volume nibbles
                    sbOut.append(getResources().getString(arg1));
                    sbOut.append(rs232SendNibble(iCentreAdjust));
                    break;
                case R.string.msgSubAdjustSend :
                    // Send S followed by two bytes representing volume nibbles
                    sbOut.append(getResources().getString(arg1));
                    sbOut.append(rs232SendNibble(iSubAdjust));
                    break;
                case R.string.msgSurroundSend :
                    // Send M followed by new value
                    sbOut.append(getResources().getString(arg1));
                    sbOut.append(iSurroundMode);
                    break;
                case R.string.msgExtSurroundSend :
                    // Send E followed by new value
                    sbOut.append(getResources().getString(arg1));
                    sbOut.append(iExtSurroundMode);
                    break;
                case R.string.msgTriggerSend :
                    // Send T followed by new value
                    sbOut.append(getResources().getString(arg1));
                    sbOut.append(iTrigger);
                    break;
            }

            // Send end of message indicator
            sbOut.append("\n");

            try {
                // Write the complete message to the amp
                Log.i("String sent to amp", sbOut.toString());
                outputStream.write(sbOut.toString().getBytes());
            } catch (IOException e) {
                Log.e("Exception", e.getMessage());
                e.printStackTrace();
            }
        }
    }

    // Splits one byte into two nibbles and sends
    private String rs232SendNibble(int i) {
        if (i < 0) {
            i += 256;
        }


        byte[] bytes = new byte[2];
        // Upper nibble first
        bytes[0] = (byte)(((i & 0xF0) >> 4) + 48);
        // then lower
        bytes[1] = (byte)((i & 0x0F) + 48);

        return new String(bytes);

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

    // From two nibbles, returns the complete byte
    private int rs232ReceiveNibble(char su, char sl, boolean isSigned) {
        // Upper nibble first
        int cu = (su - 48) << 4;
        // then lower
        int cl = (sl - 48) & 0x0F;

        int co = cu + cl;
        if (isSigned && (co >= 128)) {
            co -= 256;
        }

        return co;
    }

    // Update the volume level and show dB value
    private void updateLevelDisplay(boolean fromUser) {
        // If received from the user (user moved slider), get the volume level from the slider, or set it instead
        if (fromUser) {
            // only allow changes by 10 up or down
            if ((seekBar.getProgress() > (iVolLevel+10)) || (seekBar.getProgress() < (iVolLevel-10))) {
                seekBar.setProgress(iVolLevel);
            } else {
                iVolLevel = seekBar.getProgress(); // Seek bar contains the new volume
            }
        } else
            seekBar.setProgress(iVolLevel); // Seek bar needs setting to the current volume

        // Calculate dB level
        // Gain is 0dB
        float fLevel = 0;
        if (iVolLevel != 192) {
            fLevel = 31 - ((254-(float)iVolLevel) / 2);
        }
        NumberFormat formatter = new DecimalFormat("+#0.0;-#0.0");
        String sVolMessage = formatter.format(fLevel) + " dB";
        txtVol.setText(sVolMessage);

        // If connected and request was from user, send this to the amp
        if (isConnected && fromUser) {
            sendMessageToAmp(R.string.msgVolumeSend);
        }
    }

    // Set the current radio button from the current active input
    private void setRadioInput() {
        TextView txtInputSelected = (TextView)findViewById(R.id.textView4);
        RadioGroup radiogroup = (RadioGroup)findViewById(R.id.radioGroup1);

        if ((txtInputSelected != null) && (radiogroup != null)) {
            // Get the nth child from the input number
            RadioButton btn = (RadioButton) radiogroup.getChildAt(iActiveInput);
            // Check this button (others get deselected)
            radiogroup.check(btn.getId());
            // Set the current input text box to the text of this button
            txtInputSelected.setText(btn.getText());
        }
    }

    // Power change method - changes the power state with a wait dialog
    public void doPowerChange() {
        if (iPower == 1) {
            // Switch off by sending new power
            iPower = 0;
            sendMessageToAmp(R.string.msgPowerSend);
            // Show powering off please wait... dialog
            pDialog = ProgressDialog.show(MainActivity.this, "Switching off", "Powering off, please wait...", true);
        } else {
            // Switch on by sending new power
            iPower = 1;
            sendMessageToAmp(R.string.msgPowerSend);
            // Show powering on please wait... dialog
            pDialog = ProgressDialog.show(MainActivity.this, "Switching on", "Powering on, please wait...", true);
        }
        // Wait for power to change - 9 seconds
        new Thread() {
            @Override
            public void run() {
                try {
                    Thread.sleep(9000);
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
                // After waiting 9 seconds, send to handler to dismiss the please wait... message
                Message msg = powerComplete.obtainMessage();
                powerComplete.sendMessage(msg);
            }
        }.start();
    }

    // Handler for power change complete
    private final Handler powerComplete = new Handler(new Handler.Callback() {
        @Override
        public boolean handleMessage(Message msg) {
            // Power sequence completes, dismiss the please wait... message
            if (pDialog != null)
                pDialog.dismiss();
            setUiEnabled(isConnected);
            return false;
        }
    });


    // Update the front balance level and show dB value
    private void updateFrontBalance(boolean fromUser) {
        // For balance - positive means right balance - reduce left channel, negative means reduce right channel
        // If received from the user (user moved slider), get the volume level from the slider, or set it instead
        if (fromUser)
            iFrontBalance = seekBarFrontBal.getProgress() - 31; // Seek bar contains the new volume
        else
            seekBarFrontBal.setProgress(iFrontBalance + 31); // Seek bar needs setting to the current volume

        // Calculate dB level
        // Gain is 0dB
        float fLevel = 0;
        NumberFormat formatter;
        if (iFrontBalance != 0) {
            fLevel = (((float)iFrontBalance) / 2);
            formatter = new DecimalFormat("R+#0.0;L+#0.0");
        } else {
            formatter = new DecimalFormat("#0.0");
        }
        String sVolMessage = formatter.format(fLevel) + " dB";
        txtFrontBal.setText(sVolMessage);

        // If connected and request was from user, send this to the amp
        if (isConnected && fromUser) {
            sendMessageToAmp(R.string.msgFrontBalanceSend);
        }
    }

    // Update the rear balance level and show dB value
    private void updateRearBalance(boolean fromUser) {
        // For balance - positive means right balance - reduce left channel, negative means reduce right channel
        // If received from the user (user moved slider), get the volume level from the slider, or set it instead
        if (fromUser)
            iRearBalance = seekBarRearBal.getProgress() - 31; // Seek bar contains the new volume
        else
            seekBarRearBal.setProgress(iRearBalance + 31); // Seek bar needs setting to the current volume

        // Calculate dB level
        // Gain is 0dB
        float fLevel = 0;
        NumberFormat formatter;
        if (iRearBalance != 0) {
            fLevel = (((float)iRearBalance) / 2);
            formatter = new DecimalFormat("R+#0.0;L+#0.0");
        } else {
            formatter = new DecimalFormat("#0.0");
        }
        String sVolMessage = formatter.format(fLevel) + " dB";
        txtRearBal.setText(sVolMessage);

        // If connected and request was from user, send this to the amp
        if (isConnected && fromUser) {
            sendMessageToAmp(R.string.msgRearBalanceSend);
        }
    }

    // Update the Rear adjust level and show dB value
    private void updateRearAdjust(boolean fromUser) {
        // If received from the user (user moved slider), get the volume level from the slider, or set it instead
        if (fromUser)
            iRearAdjust = seekBarRearAdj.getProgress() - 31; // Seek bar contains the new volume
        else
            seekBarRearAdj.setProgress(iRearAdjust + 31); // Seek bar needs setting to the current volume

        // Calculate dB level
        // Gain is 0dB
        float fLevel = 0;
        NumberFormat formatter;
        if (iRearAdjust != 0) {
            fLevel = (((float)iRearAdjust) / 2);
            formatter = new DecimalFormat("+#0.0;-#0.0");
        } else {
            formatter = new DecimalFormat("#0.0");
        }
        String sVolMessage = formatter.format(fLevel) + " dB";
        txtRearAdj.setText(sVolMessage);

        // If connected and request was from user, send this to the amp
        if (isConnected && fromUser) {
            sendMessageToAmp(R.string.msgRearAdjustSend);
        }
    }

    // Update the Centre adjust level and show dB value
    private void updateCentreAdjust(boolean fromUser) {
        // If received from the user (user moved slider), get the volume level from the slider, or set it instead
        if (fromUser)
            iCentreAdjust = seekBarCentreAdj.getProgress() - 31; // Seek bar contains the new volume
        else
            seekBarCentreAdj.setProgress(iCentreAdjust + 31); // Seek bar needs setting to the current volume

        // Calculate dB level
        // Gain is 0dB
        float fLevel = 0;
        NumberFormat formatter;
        if (iCentreAdjust != 0) {
            fLevel = (((float)iCentreAdjust) / 2);
            formatter = new DecimalFormat("+#0.0;-#0.0");
        } else {
            formatter = new DecimalFormat("#0.0");
        }
        String sVolMessage = formatter.format(fLevel) + " dB";
        txtCentreAdj.setText(sVolMessage);

        // If connected and request was from user, send this to the amp
        if (isConnected && fromUser) {
            sendMessageToAmp(R.string.msgCenAdjustSend);
        }
    }
    
    // Update the Sub adjust level and show dB value
    private void updateSubAdjust(boolean fromUser) {
        // If received from the user (user moved slider), get the volume level from the slider, or set it instead
        if (fromUser)
            iSubAdjust = seekBarSubAdj.getProgress() - 31; // Seek bar contains the new volume
        else
            seekBarSubAdj.setProgress(iSubAdjust + 31); // Seek bar needs setting to the current volume

        // Calculate dB level
        // Gain is 0dB
        float fLevel = 0;
        NumberFormat formatter;
        if (iSubAdjust != 0) {
            fLevel = (((float)iSubAdjust) / 2);
            formatter = new DecimalFormat("+#0.0;-#0.0");
        } else {
            formatter = new DecimalFormat("#0.0");
        }
        String sVolMessage = formatter.format(fLevel) + " dB";
        txtSubAdj.setText(sVolMessage);

        // If connected and request was from user, send this to the amp
        if (isConnected && fromUser) {
            sendMessageToAmp(R.string.msgSubAdjustSend);
        }
    }
}
