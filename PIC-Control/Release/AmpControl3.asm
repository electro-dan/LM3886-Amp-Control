;/////////////////////////////////////////////////////////////////////////////////
;// Code Generator: BoostC Compiler - http://www.sourceboost.com
;// Version       : 8.01
;// License Type  : Pro License
;// Limitations   : PIC18 max code size:Unlimited, max RAM banks:Unlimited
;/////////////////////////////////////////////////////////////////////////////////

	include "P18F4455.inc"
__HEAPSTART                      EQU	0x000000AC ; Start address of heap 
__HEAPEND                        EQU	0x000007FF ; End address of heap 
gbl_status                       EQU	0x00000FD8 ; bytes:1
gbl_prodl                        EQU	0x00000FF3 ; bytes:1
gbl_prodh                        EQU	0x00000FF4 ; bytes:1
gbl_sppdata                      EQU	0x00000F62 ; bytes:1
gbl_sppcfg                       EQU	0x00000F63 ; bytes:1
gbl_sppeps                       EQU	0x00000F64 ; bytes:1
gbl_sppcon                       EQU	0x00000F65 ; bytes:1
gbl_ufrm                         EQU	0x00000F66 ; bytes:1
gbl_ufrml                        EQU	0x00000F66 ; bytes:1
gbl_ufrmh                        EQU	0x00000F67 ; bytes:1
gbl_uir                          EQU	0x00000F68 ; bytes:1
gbl_uie                          EQU	0x00000F69 ; bytes:1
gbl_ueir                         EQU	0x00000F6A ; bytes:1
gbl_ueie                         EQU	0x00000F6B ; bytes:1
gbl_ustat                        EQU	0x00000F6C ; bytes:1
gbl_ucon                         EQU	0x00000F6D ; bytes:1
gbl_uaddr                        EQU	0x00000F6E ; bytes:1
gbl_ucfg                         EQU	0x00000F6F ; bytes:1
gbl_uep0                         EQU	0x00000F70 ; bytes:1
gbl_uep1                         EQU	0x00000F71 ; bytes:1
gbl_uep2                         EQU	0x00000F72 ; bytes:1
gbl_uep3                         EQU	0x00000F73 ; bytes:1
gbl_uep4                         EQU	0x00000F74 ; bytes:1
gbl_uep5                         EQU	0x00000F75 ; bytes:1
gbl_uep6                         EQU	0x00000F76 ; bytes:1
gbl_uep7                         EQU	0x00000F77 ; bytes:1
gbl_uep8                         EQU	0x00000F78 ; bytes:1
gbl_uep9                         EQU	0x00000F79 ; bytes:1
gbl_uep10                        EQU	0x00000F7A ; bytes:1
gbl_uep11                        EQU	0x00000F7B ; bytes:1
gbl_uep12                        EQU	0x00000F7C ; bytes:1
gbl_uep13                        EQU	0x00000F7D ; bytes:1
gbl_uep14                        EQU	0x00000F7E ; bytes:1
gbl_uep15                        EQU	0x00000F7F ; bytes:1
gbl_porta                        EQU	0x00000F80 ; bytes:1
gbl_portb                        EQU	0x00000F81 ; bytes:1
gbl_portc                        EQU	0x00000F82 ; bytes:1
gbl_portd                        EQU	0x00000F83 ; bytes:1
gbl_porte                        EQU	0x00000F84 ; bytes:1
gbl_lata                         EQU	0x00000F89 ; bytes:1
gbl_latb                         EQU	0x00000F8A ; bytes:1
gbl_latc                         EQU	0x00000F8B ; bytes:1
gbl_latd                         EQU	0x00000F8C ; bytes:1
gbl_late                         EQU	0x00000F8D ; bytes:1
gbl_ddra                         EQU	0x00000F92 ; bytes:1
gbl_trisa                        EQU	0x00000F92 ; bytes:1
gbl_ddrb                         EQU	0x00000F93 ; bytes:1
gbl_trisb                        EQU	0x00000F93 ; bytes:1
gbl_ddrc                         EQU	0x00000F94 ; bytes:1
gbl_trisc                        EQU	0x00000F94 ; bytes:1
gbl_ddrd                         EQU	0x00000F95 ; bytes:1
gbl_trisd                        EQU	0x00000F95 ; bytes:1
gbl_ddre                         EQU	0x00000F96 ; bytes:1
gbl_trise                        EQU	0x00000F96 ; bytes:1
gbl_osctune                      EQU	0x00000F9B ; bytes:1
gbl_pie1                         EQU	0x00000F9D ; bytes:1
gbl_pir1                         EQU	0x00000F9E ; bytes:1
gbl_ipr1                         EQU	0x00000F9F ; bytes:1
gbl_pie2                         EQU	0x00000FA0 ; bytes:1
gbl_pir2                         EQU	0x00000FA1 ; bytes:1
gbl_ipr2                         EQU	0x00000FA2 ; bytes:1
gbl_eecon1                       EQU	0x00000FA6 ; bytes:1
gbl_eecon2                       EQU	0x00000FA7 ; bytes:1
gbl_eedata                       EQU	0x00000FA8 ; bytes:1
gbl_eeadr                        EQU	0x00000FA9 ; bytes:1
gbl_rcsta                        EQU	0x00000FAB ; bytes:1
gbl_txsta                        EQU	0x00000FAC ; bytes:1
gbl_txreg                        EQU	0x00000FAD ; bytes:1
gbl_rcreg                        EQU	0x00000FAE ; bytes:1
gbl_spbrg                        EQU	0x00000FAF ; bytes:1
gbl_spbrgh                       EQU	0x00000FB0 ; bytes:1
gbl_t3con                        EQU	0x00000FB1 ; bytes:1
gbl_tmr3l                        EQU	0x00000FB2 ; bytes:1
gbl_tmr3h                        EQU	0x00000FB3 ; bytes:1
gbl_cmcon                        EQU	0x00000FB4 ; bytes:1
gbl_cvrcon                       EQU	0x00000FB5 ; bytes:1
gbl_ccp1as                       EQU	0x00000FB6 ; bytes:1
gbl_eccp1as                      EQU	0x00000FB6 ; bytes:1
gbl_ccp1del                      EQU	0x00000FB7 ; bytes:1
gbl_eccp1del                     EQU	0x00000FB7 ; bytes:1
gbl_baudcon                      EQU	0x00000FB8 ; bytes:1
gbl_baudctl                      EQU	0x00000FB8 ; bytes:1
gbl_ccp2con                      EQU	0x00000FBA ; bytes:1
gbl_ccpr2                        EQU	0x00000FBB ; bytes:1
gbl_ccpr2l                       EQU	0x00000FBB ; bytes:1
gbl_ccpr2h                       EQU	0x00000FBC ; bytes:1
gbl_ccp1con                      EQU	0x00000FBD ; bytes:1
gbl_eccp1con                     EQU	0x00000FBD ; bytes:1
gbl_ccpr1                        EQU	0x00000FBE ; bytes:1
gbl_ccpr1l                       EQU	0x00000FBE ; bytes:1
gbl_ccpr1h                       EQU	0x00000FBF ; bytes:1
gbl_adcon2                       EQU	0x00000FC0 ; bytes:1
gbl_adcon1                       EQU	0x00000FC1 ; bytes:1
gbl_adcon0                       EQU	0x00000FC2 ; bytes:1
gbl_adres                        EQU	0x00000FC3 ; bytes:1
gbl_adresl                       EQU	0x00000FC3 ; bytes:1
gbl_adresh                       EQU	0x00000FC4 ; bytes:1
gbl_sspcon2                      EQU	0x00000FC5 ; bytes:1
gbl_sspcon1                      EQU	0x00000FC6 ; bytes:1
gbl_sspstat                      EQU	0x00000FC7 ; bytes:1
gbl_sspadd                       EQU	0x00000FC8 ; bytes:1
gbl_sspbuf                       EQU	0x00000FC9 ; bytes:1
gbl_t2con                        EQU	0x00000FCA ; bytes:1
gbl_pr2                          EQU	0x00000FCB ; bytes:1
gbl_tmr2                         EQU	0x00000FCC ; bytes:1
gbl_t1con                        EQU	0x00000FCD ; bytes:1
gbl_tmr1l                        EQU	0x00000FCE ; bytes:1
gbl_tmr1h                        EQU	0x00000FCF ; bytes:1
gbl_rcon                         EQU	0x00000FD0 ; bytes:1
gbl_wdtcon                       EQU	0x00000FD1 ; bytes:1
gbl_hlvdcon                      EQU	0x00000FD2 ; bytes:1
gbl_lvdcon                       EQU	0x00000FD2 ; bytes:1
gbl_osccon                       EQU	0x00000FD3 ; bytes:1
gbl_t0con                        EQU	0x00000FD5 ; bytes:1
gbl_tmr0l                        EQU	0x00000FD6 ; bytes:1
gbl_tmr0h                        EQU	0x00000FD7 ; bytes:1
gbl_fsr2l                        EQU	0x00000FD9 ; bytes:1
gbl_fsr2h                        EQU	0x00000FDA ; bytes:1
gbl_plusw2                       EQU	0x00000FDB ; bytes:1
gbl_preinc2                      EQU	0x00000FDC ; bytes:1
gbl_postdec2                     EQU	0x00000FDD ; bytes:1
gbl_postinc2                     EQU	0x00000FDE ; bytes:1
gbl_indf2                        EQU	0x00000FDF ; bytes:1
gbl_bsr                          EQU	0x00000FE0 ; bytes:1
gbl_fsr1l                        EQU	0x00000FE1 ; bytes:1
gbl_fsr1h                        EQU	0x00000FE2 ; bytes:1
gbl_plusw1                       EQU	0x00000FE3 ; bytes:1
gbl_preinc1                      EQU	0x00000FE4 ; bytes:1
gbl_postdec1                     EQU	0x00000FE5 ; bytes:1
gbl_postinc1                     EQU	0x00000FE6 ; bytes:1
gbl_indf1                        EQU	0x00000FE7 ; bytes:1
gbl_wreg                         EQU	0x00000FE8 ; bytes:1
gbl_fsr0l                        EQU	0x00000FE9 ; bytes:1
gbl_fsr0h                        EQU	0x00000FEA ; bytes:1
gbl_plusw0                       EQU	0x00000FEB ; bytes:1
gbl_preinc0                      EQU	0x00000FEC ; bytes:1
gbl_postdec0                     EQU	0x00000FED ; bytes:1
gbl_postinc0                     EQU	0x00000FEE ; bytes:1
gbl_indf0                        EQU	0x00000FEF ; bytes:1
gbl_intcon3                      EQU	0x00000FF0 ; bytes:1
gbl_intcon2                      EQU	0x00000FF1 ; bytes:1
gbl_intcon                       EQU	0x00000FF2 ; bytes:1
gbl_prod                         EQU	0x00000FF3 ; bytes:1
gbl_tablat                       EQU	0x00000FF5 ; bytes:1
gbl_tblptr                       EQU	0x00000FF6 ; bytes:1
gbl_tblptrl                      EQU	0x00000FF6 ; bytes:1
gbl_tblptrh                      EQU	0x00000FF7 ; bytes:1
gbl_tblptru                      EQU	0x00000FF8 ; bytes:1
gbl_pc                           EQU	0x00000FF9 ; bytes:1
gbl_pcl                          EQU	0x00000FF9 ; bytes:1
gbl_pclath                       EQU	0x00000FFA ; bytes:1
gbl_pclatu                       EQU	0x00000FFB ; bytes:1
gbl_stkptr                       EQU	0x00000FFC ; bytes:1
gbl_tos                          EQU	0x00000FFD ; bytes:1
gbl_tosl                         EQU	0x00000FFD ; bytes:1
gbl_tosh                         EQU	0x00000FFE ; bytes:1
gbl_tosu                         EQU	0x00000FFF ; bytes:1
gbl_cTask                        EQU	0x00000072 ; bytes:1
gbl_iVolume                      EQU	0x00000073 ; bytes:1
gbl_iMute                        EQU	0x00000074 ; bytes:1
gbl_iMuteHeld                    EQU	0x00000075 ; bytes:1
gbl_iMuteWasPressed              EQU	0x00000076 ; bytes:1
gbl_iFrontBalance                EQU	0x00000077 ; bytes:1
gbl_iRearBalance                 EQU	0x00000078 ; bytes:1
gbl_iRearAdjust                  EQU	0x00000079 ; bytes:1
gbl_iCentreAdjust                EQU	0x0000007A ; bytes:1
gbl_iSubAdjust                   EQU	0x0000007B ; bytes:1
gbl_iPower                       EQU	0x0000007C ; bytes:1
gbl_iPowerExternal               EQU	0x0000007D ; bytes:1
gbl_iActiveInput                 EQU	0x0000007E ; bytes:1
gbl_iTrigger                     EQU	0x0000007F ; bytes:1
gbl_iSurroundMode                EQU	0x00000080 ; bytes:1
gbl_iExtSurroundMode             EQU	0x00000081 ; bytes:1
gbl_iFunctionMode                EQU	0x00000082 ; bytes:1
gbl_iTimer1Count                 EQU	0x00000083 ; bytes:1
gbl_iTimer1SecCounts             EQU	0x00000084 ; bytes:1
gbl_iTimer1OffCount              EQU	0x00000085 ; bytes:1
gbl_displayASCIItoSeg            EQU	0x00000005 ; bytes:91
gbl_ledCurrentLine               EQU	0x00000086 ; bytes:1
gbl_ledCurrentCol                EQU	0x00000087 ; bytes:1
gbl_intfCounter                  EQU	0x00000088 ; bytes:1
gbl_rc5_Held                     EQU	0x00000089 ; bytes:1
gbl_rc5_inputData                EQU	0x00000070 ; bytes:2
gbl_rc5_bitCount                 EQU	0x0000008A ; bytes:1
gbl_rc5_logicInterval            EQU	0x0000008B ; bytes:1
gbl_rc5_logicChange              EQU	0x0000008C ; bytes:1
gbl_rc5_currentState             EQU	0x0000008D ; bytes:1
gbl_rc5_pinState                 EQU	0x0000008E ; bytes:1
gbl_rc5_flickBit                 EQU	0x0000008F ; bytes:1
gbl_rc5_flickBitOld              EQU	0x00000090 ; bytes:1
gbl_rc5_address                  EQU	0x00000091 ; bytes:1
gbl_rc5_command                  EQU	0x00000092 ; bytes:1
gbl_ledData1                     EQU	0x00000060 ; bytes:8
gbl_ledData2                     EQU	0x00000068 ; bytes:8
eepromWrit_0001B_arg_address     EQU	0x00000093 ; bytes:1
eepromWrit_0001B_arg_data        EQU	0x00000094 ; bytes:1
eepromWrit_0001B_1_intconsave    EQU	0x00000095 ; bytes:1
CompTempVarRet582                EQU	0x00000094 ; bytes:1
eepromRead_00000_arg_address     EQU	0x00000093 ; bytes:1
ledPrint_00000_arg_iLine         EQU	0x00000099 ; bytes:1
ledPrint_00000_arg_s             EQU	0x0000009A ; bytes:2
ledPrint_00000_1_dig             EQU	0x000000A5 ; bytes:1
CompTempVar585                   EQU	0x000000A6 ; bytes:1
CompTempVar586                   EQU	0x000000A7 ; bytes:1
CompTempVar587                   EQU	0x000000A8 ; bytes:1
CompTempVar588                   EQU	0x000000A9 ; bytes:1
CompTempVar591                   EQU	0x000000A6 ; bytes:1
CompTempVar592                   EQU	0x000000A7 ; bytes:1
CompTempVar593                   EQU	0x000000A8 ; bytes:1
CompTempVar594                   EQU	0x000000A9 ; bytes:1
ledChar_00000_arg_iChar          EQU	0x0000009B ; bytes:1
ledChar_00000_arg_iHasDot        EQU	0x0000009C ; bytes:1
ledChar_00000_1_iDecoded         EQU	0x0000009D ; bytes:1
CompTempVar600                   EQU	0x0000009C ; bytes:8
CompTempVar602                   EQU	0x0000009C ; bytes:8
ledWrite_00000_1_n               EQU	0x00000099 ; bytes:1
ledWrite_00000_1_d               EQU	0x0000009A ; bytes:1
ledSendCha_0001D_arg_iData       EQU	0x0000009B ; bytes:1
ledSendCha_0001D_2_cBitSelect    EQU	0x0000009C ; bytes:1
CompTempVar610                   EQU	0x0000009C ; bytes:8
CompTempVar612                   EQU	0x0000009C ; bytes:8
CompTempVar614                   EQU	0x00000094 ; bytes:1
doPower_00000_51_l               EQU	0x00000094 ; bytes:1
CompTempVar616                   EQU	0x0000009C ; bytes:6
CompTempVar618                   EQU	0x00000095 ; bytes:1
CompTempVar668                   EQU	0x00000093 ; bytes:1
showVolume_00000_1_iModulus      EQU	0x00000095 ; bytes:2
showVolume_00000_1_cGain         EQU	0x00000097 ; bytes:1
showVolume_00000_1_cGainDe_0001F EQU	0x00000098 ; bytes:1
showVolume_00000_7_cDig1         EQU	0x00000099 ; bytes:1
showVolume_00000_7_cDig0         EQU	0x0000009A ; bytes:1
CompTempVar662                   EQU	0x0000009B ; bytes:1
CompTempVar664                   EQU	0x0000009B ; bytes:1
CompTempVar651                   EQU	0x0000009C ; bytes:8
CompTempVar654                   EQU	0x0000009C ; bytes:9
CompTempVar656                   EQU	0x0000009C ; bytes:6
CompTempVar658                   EQU	0x0000009C ; bytes:4
CompTempVar666                   EQU	0x0000009C ; bytes:6
writeRelay_00000_1_iRelay        EQU	0x00000095 ; bytes:1
writeRelay_00000_2_cBitSelect    EQU	0x00000096 ; bytes:1
writeVolum_0001E_1_n             EQU	0x00000095 ; bytes:1
writeVolum_0001E_1_byteVolume    EQU	0x00000096 ; bytes:6
CompTempVarRet669                EQU	0x0000009E ; bytes:1
CompTempVar642                   EQU	0x0000009D ; bytes:1
writeVolum_0001E_45_i            EQU	0x0000009C ; bytes:1
writeVolum_0001E_50_i            EQU	0x0000009C ; bytes:1
writeVolum_0001E_64_cBitSelect   EQU	0x0000009C ; bytes:1
getAdjuste_00021_arg_iVolAdj     EQU	0x0000009C ; bytes:1
getAdjuste_00021_1_iResult       EQU	0x0000009D ; bytes:1
CompTempVar670                   EQU	0x0000009C ; bytes:7
CompTempVar672                   EQU	0x0000009C ; bytes:5
CompTempVar674                   EQU	0x0000009C ; bytes:8
CompTempVar676                   EQU	0x0000009C ; bytes:9
CompTempVar678                   EQU	0x0000009C ; bytes:4
CompTempVar680                   EQU	0x0000009C ; bytes:7
CompTempVar682                   EQU	0x0000009C ; bytes:3
CompTempVar684                   EQU	0x0000009C ; bytes:4
CompTempVar686                   EQU	0x0000009C ; bytes:7
CompTempVar688                   EQU	0x0000009C ; bytes:3
CompTempVar690                   EQU	0x0000009C ; bytes:4
CompTempVar692                   EQU	0x0000009C ; bytes:9
CompTempVar695                   EQU	0x0000009C ; bytes:3
CompTempVar697                   EQU	0x0000009C ; bytes:4
CompTempVar699                   EQU	0x0000009C ; bytes:7
CompTempVar701                   EQU	0x0000009C ; bytes:3
CompTempVar703                   EQU	0x0000009C ; bytes:4
CompTempVarRet709                EQU	0x00000095 ; bytes:1
CompTempVarRet710                EQU	0x00000095 ; bytes:1
rc5Process_00000_1_iGotCommand   EQU	0x00000093 ; bytes:1
interrupt_27_iReset              EQU	0x000000AA ; bytes:1
CompTempVar711                   EQU	0x000000AB ; bytes:1
CompTempVar712                   EQU	0x000000AB ; bytes:1
doVolumeUp_00000_2_iNewVol       EQU	0x00000094 ; bytes:1
doVolumeDo_00029_2_iNewVol       EQU	0x00000094 ; bytes:1
functionVa_00023_arg_iValue      EQU	0x00000094 ; bytes:1
functionVa_00023_arg_isBal       EQU	0x00000095 ; bytes:1
functionVa_00023_1_iAdj          EQU	0x00000096 ; bytes:1
functionVa_00023_1_iDecimal      EQU	0x00000097 ; bytes:1
functionVa_00025_arg_iValue      EQU	0x00000094 ; bytes:1
functionVa_00027_arg_iValue      EQU	0x00000094 ; bytes:1
CompTempVar713                   EQU	0x0000009C ; bytes:8
delay_us_00000_arg_del           EQU	0x0000009B ; bytes:1
delay_ms_00000_arg_del           EQU	0x00000095 ; bytes:1
delay_s_00000_arg_del            EQU	0x00000094 ; bytes:1
Int1Context                      EQU	0x00000001 ; bytes:4
	ORG 0x00000000
	GOTO	_startup
	ORG 0x00000008
	GOTO	interrupt
	ORG 0x0000000C
delay_us_00000
; { delay_us ; function begin
	MOVLW 0x01
	ADDWF delay_us_00000_arg_del, F, 1
	RRCF delay_us_00000_arg_del, F, 1
	MOVLW 0xFF
	ANDWF delay_us_00000_arg_del, F, 1
label1
	NOP
	NOP
	DECFSZ delay_us_00000_arg_del, F, 1
	BRA	label1
	RETURN
; } delay_us function end

	ORG 0x00000020
delay_ms_00000
; { delay_ms ; function begin
	MOVF delay_ms_00000_arg_del, F, 1
	NOP
	BNZ	label2
	RETURN
label2
	MOVLW 0xF9
label3
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	ADDLW 0xFF
	BTFSS STATUS,Z
	BRA	label3
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	DECFSZ delay_ms_00000_arg_del, F, 1
	BRA	label2
	RETURN
; } delay_ms function end

	ORG 0x00000050
delay_s_00000
; { delay_s ; function begin
label4
	MOVLW 0xFA
	MOVWF delay_ms_00000_arg_del, 1
	CALL delay_ms_00000
	MOVLW 0xFA
	MOVWF delay_ms_00000_arg_del, 1
	CALL delay_ms_00000
	MOVLW 0xFA
	MOVWF delay_ms_00000_arg_del, 1
	CALL delay_ms_00000
	MOVLW 0xFA
	MOVWF delay_ms_00000_arg_del, 1
	CALL delay_ms_00000
	DECFSZ delay_s_00000_arg_del, F, 1
	BRA	label4
	RETURN
; } delay_s function end

	ORG 0x00000076
ledSendCha_0001D
; { ledSendChar ; function begin
	MOVLW 0x80
	MOVWF ledSendCha_0001D_2_cBitSelect, 1
label5
	MOVF ledSendCha_0001D_2_cBitSelect, F, 1
	BTFSC STATUS,Z
	RETURN
	BCF gbl_portb,4
	MOVF ledSendCha_0001D_2_cBitSelect, W, 1
	ANDWF ledSendCha_0001D_arg_iData, W, 1
	BZ	label6
	BSF gbl_portb,3
	BRA	label7
label6
	BCF gbl_portb,3
label7
	BSF gbl_portb,4
	BCF STATUS,C
	RRCF ledSendCha_0001D_2_cBitSelect, F, 1
	BRA	label5
; } ledSendChar function end

	ORG 0x00000096
ledLatchUp_00000
; { ledLatchUp ; function begin
	BSF gbl_portb,5
	BCF gbl_portb,4
	BCF gbl_portb,3
	MOVLW 0x28
	MOVLB 0x00
	MOVWF delay_us_00000_arg_del, 1
	CALL delay_us_00000
	RETURN
; } ledLatchUp function end

	ORG 0x000000A8
ledLatchDo_0001C
; { ledLatchDown ; function begin
	BCF gbl_portb,3
	BCF gbl_portb,4
	BCF gbl_portb,5
	RETURN
; } ledLatchDown function end

	ORG 0x000000B0
ledWrite_00000
; { ledWrite ; function begin
	MOVLW 0x07
	MOVLB 0x00
	MOVWF ledWrite_00000_1_d, 1
	MOVLW 0x01
	MOVWF ledWrite_00000_1_n, 1
label8
	MOVLW 0x09
	CPFSLT ledWrite_00000_1_n, 1
	RETURN
	CALL ledLatchDo_0001C
	MOVF ledWrite_00000_1_n, W, 1
	MOVWF ledSendCha_0001D_arg_iData, 1
	CALL ledSendCha_0001D
	LFSR 0x00,  gbl_ledData2
	MOVF FSR0L, W
	MOVF ledWrite_00000_1_d, W, 1
	ADDWF FSR0L, F
	MOVF INDF0, W
	MOVWF ledSendCha_0001D_arg_iData, 1
	CALL ledSendCha_0001D
	MOVF ledWrite_00000_1_n, W, 1
	MOVWF ledSendCha_0001D_arg_iData, 1
	CALL ledSendCha_0001D
	LFSR 0x00,  gbl_ledData1
	MOVF FSR0L, W
	MOVF ledWrite_00000_1_d, W, 1
	ADDWF FSR0L, F
	MOVF INDF0, W
	MOVWF ledSendCha_0001D_arg_iData, 1
	CALL ledSendCha_0001D
	CALL ledLatchUp_00000
	DECF ledWrite_00000_1_d, F, 1
	INCF ledWrite_00000_1_n, F, 1
	BRA	label8
; } ledWrite function end

	ORG 0x00000102
ledPrint_00000
; { ledPrint ; function begin
	CLRF ledPrint_00000_1_dig, 1
label9
	MOVLW 0x08
	CPFSLT ledPrint_00000_1_dig, 1
	RETURN
	MOVF ledPrint_00000_arg_s+D'1', W, 1
	MOVWF FSR0H
	MOVF ledPrint_00000_arg_s, W, 1
	MOVWF FSR0L
	MOVF INDF0, F
	BZ	label11
	DECF ledPrint_00000_arg_iLine, W, 1
	BNZ	label10
	LFSR 0x00,  gbl_displayASCIItoSeg
	MOVF FSR0L, W
	MOVF FSR0H, W
	MOVWF CompTempVar586, 1
	MOVF FSR0L, W
	MOVWF CompTempVar587, 1
	MOVF ledPrint_00000_arg_s+D'1', W, 1
	MOVWF FSR0H
	MOVF ledPrint_00000_arg_s, W, 1
	MOVWF FSR0L
	INFSNZ ledPrint_00000_arg_s, F, 1
	INCF ledPrint_00000_arg_s+D'1', F, 1
	MOVLW 0x20
	SUBWF INDF0, W
	MOVWF CompTempVar585, 1
	MOVF CompTempVar585, W, 1
	ADDWF CompTempVar587, F, 1
	MOVF CompTempVar587, W, 1
	MOVWF FSR0L
	MOVF CompTempVar586, W, 1
	MOVWF FSR0H
	MOVF INDF0, W
	MOVWF CompTempVar588, 1
	LFSR 0x00,  gbl_ledData1
	MOVF FSR0L, W
	MOVF ledPrint_00000_1_dig, W, 1
	ADDWF FSR0L, F
	MOVF CompTempVar588, W, 1
	MOVWF INDF0
	BRA	label13
label10
	LFSR 0x00,  gbl_displayASCIItoSeg
	MOVF FSR0L, W
	MOVF FSR0H, W
	MOVWF CompTempVar592, 1
	MOVF FSR0L, W
	MOVWF CompTempVar593, 1
	MOVF ledPrint_00000_arg_s+D'1', W, 1
	MOVWF FSR0H
	MOVF ledPrint_00000_arg_s, W, 1
	MOVWF FSR0L
	INFSNZ ledPrint_00000_arg_s, F, 1
	INCF ledPrint_00000_arg_s+D'1', F, 1
	MOVLW 0x20
	SUBWF INDF0, W
	MOVWF CompTempVar591, 1
	MOVF CompTempVar591, W, 1
	ADDWF CompTempVar593, F, 1
	MOVF CompTempVar593, W, 1
	MOVWF FSR0L
	MOVF CompTempVar592, W, 1
	MOVWF FSR0H
	MOVF INDF0, W
	MOVWF CompTempVar594, 1
	LFSR 0x00,  gbl_ledData2
	MOVF FSR0L, W
	MOVF ledPrint_00000_1_dig, W, 1
	ADDWF FSR0L, F
	MOVF CompTempVar594, W, 1
	MOVWF INDF0
	BRA	label13
label11
	DECF ledPrint_00000_arg_iLine, W, 1
	BNZ	label12
	LFSR 0x00,  gbl_ledData1
	MOVF FSR0L, W
	MOVF ledPrint_00000_1_dig, W, 1
	ADDWF FSR0L, F
	MOVLW 0x00
	MOVWF INDF0
	BRA	label13
label12
	LFSR 0x00,  gbl_ledData2
	MOVF FSR0L, W
	MOVF ledPrint_00000_1_dig, W, 1
	ADDWF FSR0L, F
	MOVLW 0x00
	MOVWF INDF0
label13
	INCF ledPrint_00000_1_dig, F, 1
	BRA	label9
; } ledPrint function end

	ORG 0x000001C0
ledChar_00000
; { ledChar ; function begin
	LFSR 0x00,  gbl_displayASCIItoSeg
	MOVF FSR0L, W
	MOVLW 0x20
	SUBWF ledChar_00000_arg_iChar, W, 1
	ADDWF FSR0L, F
	MOVF INDF0, W
	MOVWF ledChar_00000_1_iDecoded, 1
	MOVF ledChar_00000_arg_iHasDot, F, 1
	BZ	label14
	MOVLW 0x80
	IORWF ledChar_00000_1_iDecoded, W, 1
	MOVWF ledChar_00000_1_iDecoded, 1
label14
	DECF gbl_ledCurrentLine, W, 1
	BNZ	label15
	LFSR 0x00,  gbl_ledData1
	MOVF FSR0L, W
	MOVF gbl_ledCurrentCol, W, 1
	ADDWF FSR0L, F
	MOVF ledChar_00000_1_iDecoded, W, 1
	MOVWF INDF0
	BRA	label16
label15
	LFSR 0x00,  gbl_ledData2
	MOVF FSR0L, W
	MOVF gbl_ledCurrentCol, W, 1
	ADDWF FSR0L, F
	MOVF ledChar_00000_1_iDecoded, W, 1
	MOVWF INDF0
label16
	MOVLW 0x08
	CPFSLT gbl_ledCurrentCol, 1
	RETURN
	INCF gbl_ledCurrentCol, F, 1
	RETURN
; } ledChar function end

	ORG 0x00000206
printMute_00000
; { printMute ; function begin
	MOVLW 0x02
	MOVLB 0x00
	MOVWF ledPrint_00000_arg_iLine, 1
	MOVLW 0x53
	MOVWF CompTempVar610, 1
	MOVLW 0x6E
	MOVWF CompTempVar610+D'1', 1
	MOVLW 0x64
	MOVWF CompTempVar610+D'2', 1
	MOVLW 0x20
	MOVWF CompTempVar610+D'3', 1
	MOVLW 0x4F
	MOVWF CompTempVar610+D'4', 1
	MOVLW 0x46
	MOVWF CompTempVar610+D'5', 1
	MOVWF CompTempVar610+D'6', 1
	CLRF CompTempVar610+D'7', 1
	MOVLW HIGH(CompTempVar610+D'0')
	MOVWF ledPrint_00000_arg_s+D'1', 1
	MOVLW LOW(CompTempVar610+D'0')
	MOVWF ledPrint_00000_arg_s, 1
	CALL ledPrint_00000
	CALL ledWrite_00000
	RETURN
; } printMute function end

	ORG 0x0000023A
ledSetup_00000
; { ledSetup ; function begin
	CALL ledLatchDo_0001C
	MOVLW 0x0B
	MOVLB 0x00
	MOVWF ledSendCha_0001D_arg_iData, 1
	CALL ledSendCha_0001D
	MOVLW 0x07
	MOVWF ledSendCha_0001D_arg_iData, 1
	CALL ledSendCha_0001D
	MOVLW 0x0B
	MOVWF ledSendCha_0001D_arg_iData, 1
	CALL ledSendCha_0001D
	MOVLW 0x07
	MOVWF ledSendCha_0001D_arg_iData, 1
	CALL ledSendCha_0001D
	CALL ledLatchUp_00000
	CALL ledLatchDo_0001C
	MOVLW 0x09
	MOVWF ledSendCha_0001D_arg_iData, 1
	CALL ledSendCha_0001D
	CLRF ledSendCha_0001D_arg_iData, 1
	CALL ledSendCha_0001D
	MOVLW 0x09
	MOVWF ledSendCha_0001D_arg_iData, 1
	CALL ledSendCha_0001D
	CLRF ledSendCha_0001D_arg_iData, 1
	CALL ledSendCha_0001D
	CALL ledLatchUp_00000
	CALL ledLatchDo_0001C
	MOVLW 0x0A
	MOVWF ledSendCha_0001D_arg_iData, 1
	CALL ledSendCha_0001D
	MOVLW 0x06
	MOVWF ledSendCha_0001D_arg_iData, 1
	CALL ledSendCha_0001D
	MOVLW 0x0A
	MOVWF ledSendCha_0001D_arg_iData, 1
	CALL ledSendCha_0001D
	MOVLW 0x06
	MOVWF ledSendCha_0001D_arg_iData, 1
	CALL ledSendCha_0001D
	CALL ledLatchUp_00000
	RETURN
; } ledSetup function end

	ORG 0x000002B2
getAdjuste_00021
; { getAdjustedVolume ; function begin
	MOVF getAdjuste_00021_arg_iVolAdj, W, 1
	ADDWF gbl_iVolume, W, 1
	MOVWF getAdjuste_00021_1_iResult, 1
	BTFSS getAdjuste_00021_arg_iVolAdj,7, 1
	BRA	label17
	MOVF getAdjuste_00021_1_iResult, W, 1
	CPFSLT gbl_iVolume, 1
	BRA	label18
	CLRF getAdjuste_00021_1_iResult, 1
	BRA	label18
label17
	MOVF gbl_iVolume, W, 1
	CPFSLT getAdjuste_00021_1_iResult, 1
	BRA	label18
	SETF getAdjuste_00021_1_iResult, 1
label18
	MOVF getAdjuste_00021_1_iResult, W, 1
	MOVWF CompTempVarRet669, 1
	RETURN
; } getAdjustedVolume function end

	ORG 0x000002D4
functionVa_00023
; { functionValueDisplay ; function begin
	CLRF gbl_ledData2, 1
	CLRF gbl_ledData2+D'1', 1
	MOVLW 0x02
	MOVWF gbl_ledCurrentLine, 1
	MOVF functionVa_00023_arg_isBal, F, 1
	BZ	label20
	CLRF gbl_ledCurrentCol, 1
	BTFSS functionVa_00023_arg_iValue,7, 1
	BRA	label19
	MOVLW 0x4C
	MOVWF ledChar_00000_arg_iChar, 1
	CLRF ledChar_00000_arg_iHasDot, 1
	CALL ledChar_00000
label19
	MOVLW 0x00
	BTFSC functionVa_00023_arg_iValue,7, 1
	BRA	label20
	CPFSGT functionVa_00023_arg_iValue, 1
	BRA	label20
	MOVLW 0x72
	MOVWF ledChar_00000_arg_iChar, 1
	CLRF ledChar_00000_arg_iHasDot, 1
	CALL ledChar_00000
label20
	MOVLW 0x01
	MOVWF gbl_ledCurrentCol, 1
	BTFSS functionVa_00023_arg_iValue,7, 1
	BRA	label21
	MOVLW 0x2D
	MOVWF ledChar_00000_arg_iChar, 1
	CLRF ledChar_00000_arg_iHasDot, 1
	CALL ledChar_00000
label21
	MOVLW 0x00
	BTFSC functionVa_00023_arg_iValue,7, 1
	BRA	label22
	CPFSGT functionVa_00023_arg_iValue, 1
	BRA	label22
	MOVF functionVa_00023_arg_isBal, F, 1
	BZ	label22
	MOVLW 0x2D
	MOVWF ledChar_00000_arg_iChar, 1
	CLRF ledChar_00000_arg_iHasDot, 1
	CALL ledChar_00000
label22
	MOVLW 0x00
	CPFSLT functionVa_00023_arg_iValue, 1
	BRA	label23
	BRA	label24
label23
	BTFSC functionVa_00023_arg_iValue,7, 1
	BRA	label24
	MOVF functionVa_00023_arg_iValue, W, 1
	MOVWF functionVa_00023_1_iAdj, 1
	BRA	label25
label24
	COMF functionVa_00023_arg_iValue, W, 1
	MOVWF functionVa_00023_1_iAdj, 1
	INCF functionVa_00023_1_iAdj, F, 1
label25
	CLRF functionVa_00023_1_iDecimal, 1
	BTFSS functionVa_00023_1_iAdj,0, 1
	BRA	label26
	MOVLW 0x05
	MOVWF functionVa_00023_1_iDecimal, 1
label26
	MOVF functionVa_00023_1_iAdj, F, 1
	BCF STATUS,C
	RRCF functionVa_00023_1_iAdj, F, 1
	MOVLW 0x02
	MOVWF gbl_ledCurrentCol, 1
	MOVLW 0x0A
	CPFSLT functionVa_00023_1_iAdj, 1
	BRA	label27
	BRA	label28
label27
	MOVLW 0x31
	MOVWF ledChar_00000_arg_iChar, 1
	CLRF ledChar_00000_arg_iHasDot, 1
	CALL ledChar_00000
	MOVLW 0x0A
	SUBWF functionVa_00023_1_iAdj, F, 1
	BRA	label29
label28
	MOVLW 0x20
	MOVWF ledChar_00000_arg_iChar, 1
	CLRF ledChar_00000_arg_iHasDot, 1
	CALL ledChar_00000
label29
	MOVLW 0x30
	ADDWF functionVa_00023_1_iAdj, W, 1
	MOVWF ledChar_00000_arg_iChar, 1
	MOVLW 0x01
	MOVWF ledChar_00000_arg_iHasDot, 1
	CALL ledChar_00000
	MOVLW 0x30
	ADDWF functionVa_00023_1_iDecimal, W, 1
	MOVWF ledChar_00000_arg_iChar, 1
	CLRF ledChar_00000_arg_iHasDot, 1
	CALL ledChar_00000
	MOVLW 0x20
	MOVWF ledChar_00000_arg_iChar, 1
	CLRF ledChar_00000_arg_iHasDot, 1
	CALL ledChar_00000
	MOVLW 0x64
	MOVWF ledChar_00000_arg_iChar, 1
	CLRF ledChar_00000_arg_iHasDot, 1
	CALL ledChar_00000
	MOVLW 0x62
	MOVWF ledChar_00000_arg_iChar, 1
	CLRF ledChar_00000_arg_iHasDot, 1
	CALL ledChar_00000
	CALL ledWrite_00000
	RETURN
; } functionValueDisplay function end

	ORG 0x000003BA
writeVolum_0001E
; { writeVolumes ; function begin
	MOVLB 0x00
	CLRF writeVolum_0001E_1_byteVolume, 1
	CLRF writeVolum_0001E_1_byteVolume+D'1', 1
	CLRF writeVolum_0001E_1_byteVolume+D'2', 1
	CLRF writeVolum_0001E_1_byteVolume+D'3', 1
	CLRF writeVolum_0001E_1_byteVolume+D'4', 1
	CLRF writeVolum_0001E_1_byteVolume+D'5', 1
	MOVF gbl_iFrontBalance, F, 1
	BNZ	label30
	MOVF gbl_iVolume, W, 1
	MOVWF writeVolum_0001E_1_byteVolume+D'4', 1
	MOVF gbl_iVolume, W, 1
	MOVWF writeVolum_0001E_1_byteVolume+D'5', 1
	BRA	label32
label30
	MOVLW 0x00
	BTFSC gbl_iFrontBalance,7, 1
	BRA	label31
	CPFSGT gbl_iFrontBalance, 1
	BRA	label31
	MOVLW 0xFF
	MULWF gbl_iFrontBalance, 1
	MOVF PRODL, W
	MOVWF getAdjuste_00021_arg_iVolAdj, 1
	CALL getAdjuste_00021
	MOVF CompTempVarRet669, W, 1
	MOVWF writeVolum_0001E_1_byteVolume+D'4', 1
	MOVF gbl_iVolume, W, 1
	MOVWF writeVolum_0001E_1_byteVolume+D'5', 1
	BRA	label32
label31
	MOVF gbl_iFrontBalance, W, 1
	MOVWF getAdjuste_00021_arg_iVolAdj, 1
	CALL getAdjuste_00021
	MOVF CompTempVarRet669, W, 1
	MOVWF writeVolum_0001E_1_byteVolume+D'5', 1
	MOVF gbl_iVolume, W, 1
	MOVWF writeVolum_0001E_1_byteVolume+D'4', 1
label32
	MOVF gbl_iRearBalance, F, 1
	BNZ	label33
	MOVF gbl_iRearAdjust, W, 1
	MOVWF getAdjuste_00021_arg_iVolAdj, 1
	CALL getAdjuste_00021
	MOVF CompTempVarRet669, W, 1
	MOVWF writeVolum_0001E_1_byteVolume+D'2', 1
	MOVF gbl_iRearAdjust, W, 1
	MOVWF getAdjuste_00021_arg_iVolAdj, 1
	CALL getAdjuste_00021
	MOVF CompTempVarRet669, W, 1
	MOVWF writeVolum_0001E_1_byteVolume+D'3', 1
	BRA	label35
label33
	MOVLW 0x00
	BTFSC gbl_iRearBalance,7, 1
	BRA	label34
	CPFSGT gbl_iRearBalance, 1
	BRA	label34
	MOVLW 0xFF
	MULWF gbl_iRearBalance, 1
	MOVF PRODL, W
	MOVWF getAdjuste_00021_arg_iVolAdj, 1
	MOVF PRODH, W
	MOVWF CompTempVar642, 1
	MOVLW 0xFF
	MULWF gbl_iRearBalance, 1
	MOVF PRODL, W
	ADDWF CompTempVar642, F, 1
	MOVF gbl_iRearAdjust, W, 1
	ADDWF getAdjuste_00021_arg_iVolAdj, F, 1
	CALL getAdjuste_00021
	MOVF CompTempVarRet669, W, 1
	MOVWF writeVolum_0001E_1_byteVolume+D'2', 1
	MOVF gbl_iRearAdjust, W, 1
	MOVWF getAdjuste_00021_arg_iVolAdj, 1
	CALL getAdjuste_00021
	MOVF CompTempVarRet669, W, 1
	MOVWF writeVolum_0001E_1_byteVolume+D'3', 1
	BRA	label35
label34
	MOVF gbl_iRearAdjust, W, 1
	ADDWF gbl_iRearBalance, W, 1
	MOVWF getAdjuste_00021_arg_iVolAdj, 1
	CALL getAdjuste_00021
	MOVF CompTempVarRet669, W, 1
	MOVWF writeVolum_0001E_1_byteVolume+D'3', 1
	MOVF gbl_iRearAdjust, W, 1
	MOVWF getAdjuste_00021_arg_iVolAdj, 1
	CALL getAdjuste_00021
	MOVF CompTempVarRet669, W, 1
	MOVWF writeVolum_0001E_1_byteVolume+D'2', 1
label35
	MOVF gbl_iCentreAdjust, W, 1
	MOVWF getAdjuste_00021_arg_iVolAdj, 1
	CALL getAdjuste_00021
	MOVF CompTempVarRet669, W, 1
	MOVWF writeVolum_0001E_1_byteVolume+D'1', 1
	MOVF gbl_iSubAdjust, W, 1
	MOVWF getAdjuste_00021_arg_iVolAdj, 1
	CALL getAdjuste_00021
	MOVF CompTempVarRet669, W, 1
	MOVWF writeVolum_0001E_1_byteVolume, 1
	TSTFSZ gbl_iSurroundMode, 1
	BRA	label37
	CLRF writeVolum_0001E_45_i, 1
label36
	MOVLW 0x04
	CPFSLT writeVolum_0001E_45_i, 1
	BRA	label37
	LFSR 0x00,  writeVolum_0001E_1_byteVolume
	MOVF FSR0L, W
	MOVF writeVolum_0001E_45_i, W, 1
	ADDWF FSR0L, F
	MOVLW 0x00
	MOVWF INDF0
	INCF writeVolum_0001E_45_i, F, 1
	BRA	label36
label37
	MOVF gbl_iVolume, F, 1
	BZ	label38
	DECF gbl_iMute, W, 1
	BNZ	label41
label38
	CLRF writeVolum_0001E_50_i, 1
label39
	MOVLW 0x06
	CPFSLT writeVolum_0001E_50_i, 1
	BRA	label40
	LFSR 0x00,  writeVolum_0001E_1_byteVolume
	MOVF FSR0L, W
	MOVF writeVolum_0001E_50_i, W, 1
	ADDWF FSR0L, F
	MOVLW 0x00
	MOVWF INDF0
	INCF writeVolum_0001E_50_i, F, 1
	BRA	label39
label40
	BSF gbl_porta,4
	BCF gbl_porta,5
	BRA	label42
label41
	BCF gbl_porta,4
	BSF gbl_porta,5
label42
	BCF gbl_portc,2
	CLRF writeVolum_0001E_1_n, 1
label43
	MOVLW 0x06
	CPFSLT writeVolum_0001E_1_n, 1
	BRA	label48
	MOVLW 0x80
	MOVWF writeVolum_0001E_64_cBitSelect, 1
label44
	MOVF writeVolum_0001E_64_cBitSelect, F, 1
	BZ	label47
	BCF gbl_portc,1
	LFSR 0x00,  writeVolum_0001E_1_byteVolume
	MOVF FSR0L, W
	MOVF writeVolum_0001E_1_n, W, 1
	ADDWF FSR0L, F
	MOVF writeVolum_0001E_64_cBitSelect, W, 1
	ANDWF INDF0, W
	BZ	label45
	BSF gbl_portc,0
	BRA	label46
label45
	BCF gbl_portc,0
label46
	BSF gbl_portc,1
	BCF STATUS,C
	RRCF writeVolum_0001E_64_cBitSelect, F, 1
	BRA	label44
label47
	INCF writeVolum_0001E_1_n, F, 1
	BRA	label43
label48
	BSF gbl_portc,2
	RETURN
; } writeVolumes function end

	ORG 0x00000512
writeRelay_00000
; { writeRelay ; function begin
	MOVLB 0x00
	CLRF writeRelay_00000_1_iRelay, 1
	MOVF gbl_iExtSurroundMode, F, 1
	BZ	label49
	MOVF gbl_iActiveInput, F, 1
	BNZ	label49
	MOVLW 0xBF
	ANDWF writeRelay_00000_1_iRelay, F, 1
	MOVLW 0x40
	ADDWF writeRelay_00000_1_iRelay, F, 1
label49
	MOVF gbl_iActiveInput, F, 1
	BZ	label51
	DECF gbl_iActiveInput, W, 1
	BZ	label52
	MOVLW 0x02
	CPFSEQ gbl_iActiveInput, 1
	BRA	label50
	BRA	label53
label50
	MOVLW 0x03
	CPFSEQ gbl_iActiveInput, 1
	BRA	label55
	BRA	label54
label51
	MOVLW 0x43
	ANDWF writeRelay_00000_1_iRelay, F, 1
	MOVLW 0x20
	ADDWF writeRelay_00000_1_iRelay, F, 1
	BRA	label55
label52
	MOVLW 0x43
	ANDWF writeRelay_00000_1_iRelay, F, 1
	MOVLW 0x04
	ADDWF writeRelay_00000_1_iRelay, F, 1
	BRA	label55
label53
	MOVLW 0x43
	ANDWF writeRelay_00000_1_iRelay, F, 1
	MOVLW 0x08
	ADDWF writeRelay_00000_1_iRelay, F, 1
	BRA	label55
label54
	MOVLW 0x43
	ANDWF writeRelay_00000_1_iRelay, F, 1
	MOVLW 0x10
	ADDWF writeRelay_00000_1_iRelay, F, 1
label55
	MOVF gbl_iTrigger, W, 1
	SUBLW 0x03
	BNC	label56
	MOVF gbl_iTrigger, W, 1
	ADDWF writeRelay_00000_1_iRelay, F, 1
label56
	TSTFSZ gbl_iPower, 1
	BRA	label57
	CLRF writeRelay_00000_1_iRelay, 1
label57
	BCF gbl_porte,2
	MOVLW 0x01
	MOVWF writeRelay_00000_2_cBitSelect, 1
label58
	MOVF writeRelay_00000_2_cBitSelect, F, 1
	BZ	label61
	MOVF writeRelay_00000_2_cBitSelect, W, 1
	ANDWF writeRelay_00000_1_iRelay, W, 1
	BZ	label59
	BSF gbl_porte,0
	BRA	label60
label59
	BCF gbl_porte,0
label60
	BSF gbl_porte,1
	BCF gbl_porte,1
	BCF STATUS,C
	RLCF writeRelay_00000_2_cBitSelect, F, 1
	BRA	label58
label61
	BSF gbl_porte,2
	RETURN
; } writeRelay function end

	ORG 0x00000598
showVolume_00000
; { showVolume ; function begin
	MOVLB 0x00
	CLRF showVolume_00000_1_iModulus, 1
	CLRF showVolume_00000_1_iModulus+D'1', 1
	MOVLW 0x5F
	MOVWF showVolume_00000_1_cGain, 1
	CLRF showVolume_00000_1_cGainDe_0001F, 1
	CLRF gbl_ledData2, 1
	CLRF gbl_ledData2+D'1', 1
	MOVF gbl_iMute, F, 1
	BZ	label62
	CALL printMute_00000
	BRA	label72
label62
	MOVLW 0x02
	MOVWF gbl_ledCurrentLine, 1
	MOVLW 0xC0
	CPFSEQ gbl_iVolume, 1
	BRA	label63
	CLRF showVolume_00000_1_cGain, 1
	BRA	label65
label63
	MOVLW 0xC0
	CPFSGT gbl_iVolume, 1
	BRA	label64
	MOVF gbl_iVolume, W, 1
	SUBLW 0xFF
	MOVWF CompTempVar662, 1
	BCF STATUS,C
	RRCF CompTempVar662, F, 1
	MOVF CompTempVar662, W, 1
	SUBLW 0x1F
	MOVWF showVolume_00000_1_cGain, 1
	BRA	label65
label64
	MOVLW 0xC0
	CPFSLT gbl_iVolume, 1
	BRA	label65
	MOVF gbl_iVolume, W, 1
	SUBLW 0xFE
	MOVWF CompTempVar664, 1
	BCF STATUS,C
	RRCF CompTempVar664, F, 1
	MOVLW 0x1F
	SUBWF CompTempVar664, W, 1
	MOVWF showVolume_00000_1_cGain, 1
	MOVLW 0x01
	MOVWF gbl_ledCurrentCol, 1
	MOVLW 0x2D
	MOVWF ledChar_00000_arg_iChar, 1
	CLRF ledChar_00000_arg_iHasDot, 1
	CALL ledChar_00000
label65
	BTFSS gbl_iVolume,0, 1
	BRA	label66
	MOVLW 0x05
	MOVWF showVolume_00000_1_cGainDe_0001F, 1
label66
	CLRF showVolume_00000_7_cDig1, 1
	CLRF showVolume_00000_7_cDig0, 1
label67
	MOVLW 0x0A
	CPFSLT showVolume_00000_1_cGain, 1
	BRA	label68
	BRA	label69
label68
	MOVLW 0x0A
	SUBWF showVolume_00000_1_cGain, W, 1
	MOVWF showVolume_00000_1_cGain, 1
	INCF showVolume_00000_7_cDig1, F, 1
	BRA	label67
label69
	MOVF showVolume_00000_1_cGain, W, 1
	MOVWF showVolume_00000_7_cDig0, 1
	MOVLW 0x02
	MOVWF gbl_ledCurrentCol, 1
	MOVF showVolume_00000_7_cDig1, F, 1
	BNZ	label70
	MOVLW 0x20
	MOVWF ledChar_00000_arg_iChar, 1
	CLRF ledChar_00000_arg_iHasDot, 1
	CALL ledChar_00000
	BRA	label71
label70
	MOVLW 0x30
	ADDWF showVolume_00000_7_cDig1, W, 1
	MOVWF ledChar_00000_arg_iChar, 1
	CLRF ledChar_00000_arg_iHasDot, 1
	CALL ledChar_00000
label71
	MOVLW 0x30
	ADDWF showVolume_00000_7_cDig0, W, 1
	MOVWF ledChar_00000_arg_iChar, 1
	MOVLW 0x01
	MOVWF ledChar_00000_arg_iHasDot, 1
	CALL ledChar_00000
	MOVLW 0x30
	ADDWF showVolume_00000_1_cGainDe_0001F, W, 1
	MOVWF ledChar_00000_arg_iChar, 1
	CLRF ledChar_00000_arg_iHasDot, 1
	CALL ledChar_00000
	MOVLW 0x20
	MOVWF ledChar_00000_arg_iChar, 1
	CLRF ledChar_00000_arg_iHasDot, 1
	CALL ledChar_00000
	MOVLW 0x64
	MOVWF ledChar_00000_arg_iChar, 1
	CLRF ledChar_00000_arg_iHasDot, 1
	CALL ledChar_00000
	MOVLW 0x62
	MOVWF ledChar_00000_arg_iChar, 1
	CLRF ledChar_00000_arg_iHasDot, 1
	CALL ledChar_00000
label72
	MOVF gbl_iVolume, F, 1
	BZ	label73
	DECF gbl_iMute, W, 1
	BNZ	label74
label73
	BCF gbl_porta,5
	BSF gbl_porta,4
	RETURN
label74
	BSF gbl_porta,5
	BCF gbl_porta,4
	RETURN
; } showVolume function end

	ORG 0x0000068A
showInput_00000
; { showInput ; function begin
	MOVLB 0x00
	MOVF gbl_iActiveInput, F, 1
	BZ	label76
	DECF gbl_iActiveInput, W, 1
	BZ	label77
	MOVLW 0x02
	CPFSEQ gbl_iActiveInput, 1
	BRA	label75
	BRA	label78
label75
	MOVLW 0x03
	CPFSEQ gbl_iActiveInput, 1
	RETURN
	BRA	label79
label76
	MOVLW 0x01
	MOVWF ledPrint_00000_arg_iLine, 1
	MOVLW 0x20
	MOVWF CompTempVar651+D'4', 1
	MOVLW 0x31
	MOVWF CompTempVar651+D'6', 1
	MOVLW 0x35
	MOVWF CompTempVar651+D'5', 1
	MOVLW 0x45
	MOVWF CompTempVar651+D'1', 1
	MOVWF CompTempVar651+D'3', 1
	MOVLW 0x4C
	MOVWF CompTempVar651+D'2', 1
	MOVLW 0x54
	MOVWF CompTempVar651, 1
	CLRF CompTempVar651+D'7', 1
	MOVLW HIGH(CompTempVar651+D'0')
	MOVWF ledPrint_00000_arg_s+D'1', 1
	MOVLW LOW(CompTempVar651+D'0')
	MOVWF ledPrint_00000_arg_s, 1
	CALL ledPrint_00000
	MOVLW 0xDB
	MOVWF gbl_ledData1+D'5', 1
	RETURN
label77
	MOVLW 0x01
	MOVWF ledPrint_00000_arg_iLine, 1
	MOVLW 0x20
	MOVWF CompTempVar654+D'3', 1
	MOVLW 0x43
	MOVWF CompTempVar654, 1
	MOVWF CompTempVar654+D'4', 1
	MOVLW 0x61
	MOVWF CompTempVar654+D'5', 1
	MOVLW 0x68
	MOVWF CompTempVar654+D'1', 1
	MOVLW 0x72
	MOVWF CompTempVar654+D'2', 1
	MOVLW 0x73
	MOVWF CompTempVar654+D'6', 1
	MOVLW 0x74
	MOVWF CompTempVar654+D'7', 1
	CLRF CompTempVar654+D'8', 1
	MOVLW HIGH(CompTempVar654+D'0')
	MOVWF ledPrint_00000_arg_s+D'1', 1
	MOVLW LOW(CompTempVar654+D'0')
	MOVWF ledPrint_00000_arg_s, 1
	CALL ledPrint_00000
	RETURN
label78
	MOVLW 0x01
	MOVWF ledPrint_00000_arg_iLine, 1
	MOVLW 0x50
	MOVWF CompTempVar656, 1
	MOVLW 0x68
	MOVWF CompTempVar656+D'1', 1
	MOVLW 0x6E
	MOVWF CompTempVar656+D'3', 1
	MOVLW 0x6F
	MOVWF CompTempVar656+D'2', 1
	MOVWF CompTempVar656+D'4', 1
	CLRF CompTempVar656+D'5', 1
	MOVLW HIGH(CompTempVar656+D'0')
	MOVWF ledPrint_00000_arg_s+D'1', 1
	MOVLW LOW(CompTempVar656+D'0')
	MOVWF ledPrint_00000_arg_s, 1
	CALL ledPrint_00000
	RETURN
label79
	MOVLW 0x01
	MOVWF ledPrint_00000_arg_iLine, 1
	MOVLW 0x41
	MOVWF CompTempVar658, 1
	MOVLW 0x4C
	MOVWF CompTempVar658+D'1', 1
	MOVLW 0x74
	MOVWF CompTempVar658+D'2', 1
	CLRF CompTempVar658+D'3', 1
	MOVLW HIGH(CompTempVar658+D'0')
	MOVWF ledPrint_00000_arg_s+D'1', 1
	MOVLW LOW(CompTempVar658+D'0')
	MOVWF ledPrint_00000_arg_s, 1
	CALL ledPrint_00000
	RETURN
; } showInput function end

	ORG 0x0000074E
showFault_00000
; { showFault ; function begin
	MOVLW 0x01
	MOVLB 0x00
	MOVWF ledPrint_00000_arg_iLine, 1
	MOVLW 0x46
	MOVWF CompTempVar666, 1
	MOVLW 0x41
	MOVWF CompTempVar666+D'1', 1
	MOVLW 0x55
	MOVWF CompTempVar666+D'2', 1
	MOVLW 0x4C
	MOVWF CompTempVar666+D'3', 1
	MOVLW 0x74
	MOVWF CompTempVar666+D'4', 1
	CLRF CompTempVar666+D'5', 1
	MOVLW HIGH(CompTempVar666+D'0')
	MOVWF ledPrint_00000_arg_s+D'1', 1
	MOVLW LOW(CompTempVar666+D'0')
	MOVWF ledPrint_00000_arg_s, 1
	CALL ledPrint_00000
	CALL printMute_00000
	BSF gbl_porta,3
	BCF gbl_porta,5
	RETURN
; } showFault function end

	ORG 0x00000780
ledOn_00000
; { ledOn ; function begin
	BCF gbl_portb,3
	BCF gbl_portb,4
	BSF gbl_portb,5
	BCF gbl_portd,7
	MOVLW 0xFA
	MOVLB 0x00
	MOVWF delay_ms_00000_arg_del, 1
	CALL delay_ms_00000
	CALL ledSetup_00000
	CALL ledLatchDo_0001C
	MOVLW 0x0C
	MOVWF ledSendCha_0001D_arg_iData, 1
	CALL ledSendCha_0001D
	MOVLW 0x01
	MOVWF ledSendCha_0001D_arg_iData, 1
	CALL ledSendCha_0001D
	MOVLW 0x0C
	MOVWF ledSendCha_0001D_arg_iData, 1
	CALL ledSendCha_0001D
	MOVLW 0x01
	MOVWF ledSendCha_0001D_arg_iData, 1
	CALL ledSendCha_0001D
	CALL ledLatchUp_00000
	MOVLW 0xFA
	MOVWF delay_us_00000_arg_del, 1
	CALL delay_us_00000
	RETURN
; } ledOn function end

	ORG 0x000007C8
ledOff_00000
; { ledOff ; function begin
	CALL ledLatchDo_0001C
	MOVLW 0x0C
	MOVLB 0x00
	MOVWF ledSendCha_0001D_arg_iData, 1
	CALL ledSendCha_0001D
	CLRF ledSendCha_0001D_arg_iData, 1
	CALL ledSendCha_0001D
	MOVLW 0x0C
	MOVWF ledSendCha_0001D_arg_iData, 1
	CALL ledSendCha_0001D
	CLRF ledSendCha_0001D_arg_iData, 1
	CALL ledSendCha_0001D
	CALL ledLatchUp_00000
	BSF gbl_portd,7
	MOVLW 0x64
	MOVWF delay_ms_00000_arg_del, 1
	CALL delay_ms_00000
	RETURN
; } ledOff function end

	ORG 0x000007FA
functionVa_00027
; { functionValueLower ; function begin
	MOVF functionVa_00027_arg_iValue, W, 1
	BCF STATUS,C
	BTFSC functionVa_00027_arg_iValue,7, 1
	SUBLW 0xE0
	BTFSS STATUS,C
	DECF functionVa_00027_arg_iValue, F, 1
	MOVF functionVa_00027_arg_iValue, W, 1
	MOVWF CompTempVarRet710, 1
	RETURN
; } functionValueLower function end

	ORG 0x0000080C
functionVa_00025
; { functionValueRaise ; function begin
	MOVLW 0x20
	CPFSLT functionVa_00025_arg_iValue, 1
	BRA	label80
	BRA	label81
label80
	BTFSC functionVa_00025_arg_iValue,7, 1
label81
	INCF functionVa_00025_arg_iValue, F, 1
	MOVF functionVa_00025_arg_iValue, W, 1
	MOVWF CompTempVarRet709, 1
	RETURN
; } functionValueRaise function end

	ORG 0x0000081E
functionDi_00022
; { functionDisplay ; function begin
	MOVLB 0x00
	DECF gbl_iFunctionMode, W, 1
	BZ	label89
	MOVLW 0x02
	CPFSEQ gbl_iFunctionMode, 1
	BRA	label82
	BRA	label90
label82
	MOVLW 0x03
	CPFSEQ gbl_iFunctionMode, 1
	BRA	label83
	BRA	label91
label83
	MOVLW 0x04
	CPFSEQ gbl_iFunctionMode, 1
	BRA	label84
	BRA	label92
label84
	MOVLW 0x05
	CPFSEQ gbl_iFunctionMode, 1
	BRA	label85
	BRA	label93
label85
	MOVLW 0x06
	CPFSEQ gbl_iFunctionMode, 1
	BRA	label86
	BRA	label94
label86
	MOVLW 0x07
	CPFSEQ gbl_iFunctionMode, 1
	BRA	label87
	BRA	label96
label87
	MOVLW 0x08
	CPFSEQ gbl_iFunctionMode, 1
	BRA	label88
	BRA	label98
label88
	MOVLW 0x09
	CPFSEQ gbl_iFunctionMode, 1
	BRA	label102
	BRA	label100
label89
	MOVLW 0x01
	MOVWF ledPrint_00000_arg_iLine, 1
	MOVLW 0x43
	MOVWF CompTempVar670, 1
	MOVLW 0x65
	MOVWF CompTempVar670+D'1', 1
	MOVWF CompTempVar670+D'5', 1
	MOVLW 0x6E
	MOVWF CompTempVar670+D'2', 1
	MOVLW 0x72
	MOVWF CompTempVar670+D'4', 1
	MOVLW 0x74
	MOVWF CompTempVar670+D'3', 1
	CLRF CompTempVar670+D'6', 1
	MOVLW HIGH(CompTempVar670+D'0')
	MOVWF ledPrint_00000_arg_s+D'1', 1
	MOVLW LOW(CompTempVar670+D'0')
	MOVWF ledPrint_00000_arg_s, 1
	CALL ledPrint_00000
	MOVF gbl_iCentreAdjust, W, 1
	MOVWF functionVa_00023_arg_iValue, 1
	CLRF functionVa_00023_arg_isBal, 1
	CALL functionVa_00023
	BRA	label102
label90
	MOVLW 0x01
	MOVWF ledPrint_00000_arg_iLine, 1
	MOVLW 0x61
	MOVWF CompTempVar672+D'2', 1
	MOVLW 0x65
	MOVWF CompTempVar672+D'1', 1
	MOVLW 0x72
	MOVWF CompTempVar672, 1
	MOVWF CompTempVar672+D'3', 1
	CLRF CompTempVar672+D'4', 1
	MOVLW HIGH(CompTempVar672+D'0')
	MOVWF ledPrint_00000_arg_s+D'1', 1
	MOVLW LOW(CompTempVar672+D'0')
	MOVWF ledPrint_00000_arg_s, 1
	CALL ledPrint_00000
	MOVF gbl_iRearAdjust, W, 1
	MOVWF functionVa_00023_arg_iValue, 1
	CLRF functionVa_00023_arg_isBal, 1
	CALL functionVa_00023
	BRA	label102
label91
	MOVLW 0x01
	MOVWF ledPrint_00000_arg_iLine, 1
	MOVLW 0x61
	MOVWF CompTempVar674+D'1', 1
	MOVWF CompTempVar674+D'3', 1
	MOVLW 0x62
	MOVWF CompTempVar674, 1
	MOVLW 0x63
	MOVWF CompTempVar674+D'5', 1
	MOVLW 0x65
	MOVWF CompTempVar674+D'6', 1
	MOVLW 0x6C
	MOVWF CompTempVar674+D'2', 1
	MOVLW 0x6E
	MOVWF CompTempVar674+D'4', 1
	CLRF CompTempVar674+D'7', 1
	MOVLW HIGH(CompTempVar674+D'0')
	MOVWF ledPrint_00000_arg_s+D'1', 1
	MOVLW LOW(CompTempVar674+D'0')
	MOVWF ledPrint_00000_arg_s, 1
	CALL ledPrint_00000
	MOVF gbl_iFrontBalance, W, 1
	MOVWF functionVa_00023_arg_iValue, 1
	MOVLW 0x01
	MOVWF functionVa_00023_arg_isBal, 1
	CALL functionVa_00023
	BRA	label102
label92
	MOVLW 0x01
	MOVWF ledPrint_00000_arg_iLine, 1
	MOVLW 0x20
	MOVWF CompTempVar676+D'4', 1
	MOVLW 0x61
	MOVWF CompTempVar676+D'2', 1
	MOVWF CompTempVar676+D'6', 1
	MOVLW 0x62
	MOVWF CompTempVar676+D'5', 1
	MOVLW 0x65
	MOVWF CompTempVar676+D'1', 1
	MOVLW 0x6C
	MOVWF CompTempVar676+D'7', 1
	MOVLW 0x72
	MOVWF CompTempVar676, 1
	MOVWF CompTempVar676+D'3', 1
	CLRF CompTempVar676+D'8', 1
	MOVLW HIGH(CompTempVar676+D'0')
	MOVWF ledPrint_00000_arg_s+D'1', 1
	MOVLW LOW(CompTempVar676+D'0')
	MOVWF ledPrint_00000_arg_s, 1
	CALL ledPrint_00000
	MOVF gbl_iRearBalance, W, 1
	MOVWF functionVa_00023_arg_iValue, 1
	MOVLW 0x01
	MOVWF functionVa_00023_arg_isBal, 1
	CALL functionVa_00023
	BRA	label102
label93
	MOVLW 0x01
	MOVWF ledPrint_00000_arg_iLine, 1
	MOVLW 0x53
	MOVWF CompTempVar678, 1
	MOVLW 0x75
	MOVWF CompTempVar678+D'1', 1
	MOVLW 0x62
	MOVWF CompTempVar678+D'2', 1
	CLRF CompTempVar678+D'3', 1
	MOVLW HIGH(CompTempVar678+D'0')
	MOVWF ledPrint_00000_arg_s+D'1', 1
	MOVLW LOW(CompTempVar678+D'0')
	MOVWF ledPrint_00000_arg_s, 1
	CALL ledPrint_00000
	MOVF gbl_iSubAdjust, W, 1
	MOVWF functionVa_00023_arg_iValue, 1
	CLRF functionVa_00023_arg_isBal, 1
	CALL functionVa_00023
	BRA	label102
label94
	MOVLW 0x01
	MOVWF ledPrint_00000_arg_iLine, 1
	MOVLW 0x54
	MOVWF CompTempVar680, 1
	MOVLW 0x72
	MOVWF CompTempVar680+D'1', 1
	MOVLW 0x69
	MOVWF CompTempVar680+D'2', 1
	MOVLW 0x67
	MOVWF CompTempVar680+D'3', 1
	MOVLW 0x20
	MOVWF CompTempVar680+D'4', 1
	MOVLW 0x31
	MOVWF CompTempVar680+D'5', 1
	CLRF CompTempVar680+D'6', 1
	MOVLW HIGH(CompTempVar680+D'0')
	MOVWF ledPrint_00000_arg_s+D'1', 1
	MOVLW LOW(CompTempVar680+D'0')
	MOVWF ledPrint_00000_arg_s, 1
	CALL ledPrint_00000
	BTFSS gbl_iTrigger,0, 1
	BRA	label95
	MOVLW 0x02
	MOVWF ledPrint_00000_arg_iLine, 1
	MOVLW 0x4F
	MOVWF CompTempVar682, 1
	MOVLW 0x6E
	MOVWF CompTempVar682+D'1', 1
	CLRF CompTempVar682+D'2', 1
	MOVLW HIGH(CompTempVar682+D'0')
	MOVWF ledPrint_00000_arg_s+D'1', 1
	MOVLW LOW(CompTempVar682+D'0')
	MOVWF ledPrint_00000_arg_s, 1
	CALL ledPrint_00000
	BRA	label102
label95
	MOVLW 0x02
	MOVWF ledPrint_00000_arg_iLine, 1
	MOVLW 0x4F
	MOVWF CompTempVar684, 1
	MOVLW 0x66
	MOVWF CompTempVar684+D'1', 1
	MOVWF CompTempVar684+D'2', 1
	CLRF CompTempVar684+D'3', 1
	MOVLW HIGH(CompTempVar684+D'0')
	MOVWF ledPrint_00000_arg_s+D'1', 1
	MOVLW LOW(CompTempVar684+D'0')
	MOVWF ledPrint_00000_arg_s, 1
	CALL ledPrint_00000
	BRA	label102
label96
	MOVLW 0x01
	MOVWF ledPrint_00000_arg_iLine, 1
	MOVLW 0x54
	MOVWF CompTempVar686, 1
	MOVLW 0x72
	MOVWF CompTempVar686+D'1', 1
	MOVLW 0x69
	MOVWF CompTempVar686+D'2', 1
	MOVLW 0x67
	MOVWF CompTempVar686+D'3', 1
	MOVLW 0x20
	MOVWF CompTempVar686+D'4', 1
	MOVLW 0x32
	MOVWF CompTempVar686+D'5', 1
	CLRF CompTempVar686+D'6', 1
	MOVLW HIGH(CompTempVar686+D'0')
	MOVWF ledPrint_00000_arg_s+D'1', 1
	MOVLW LOW(CompTempVar686+D'0')
	MOVWF ledPrint_00000_arg_s, 1
	CALL ledPrint_00000
	BTFSS gbl_iTrigger,1, 1
	BRA	label97
	MOVLW 0x02
	MOVWF ledPrint_00000_arg_iLine, 1
	MOVLW 0x4F
	MOVWF CompTempVar688, 1
	MOVLW 0x6E
	MOVWF CompTempVar688+D'1', 1
	CLRF CompTempVar688+D'2', 1
	MOVLW HIGH(CompTempVar688+D'0')
	MOVWF ledPrint_00000_arg_s+D'1', 1
	MOVLW LOW(CompTempVar688+D'0')
	MOVWF ledPrint_00000_arg_s, 1
	CALL ledPrint_00000
	BRA	label102
label97
	MOVLW 0x02
	MOVWF ledPrint_00000_arg_iLine, 1
	MOVLW 0x4F
	MOVWF CompTempVar690, 1
	MOVLW 0x66
	MOVWF CompTempVar690+D'1', 1
	MOVWF CompTempVar690+D'2', 1
	CLRF CompTempVar690+D'3', 1
	MOVLW HIGH(CompTempVar690+D'0')
	MOVWF ledPrint_00000_arg_s+D'1', 1
	MOVLW LOW(CompTempVar690+D'0')
	MOVWF ledPrint_00000_arg_s, 1
	CALL ledPrint_00000
	BRA	label102
label98
	MOVLW 0x01
	MOVWF ledPrint_00000_arg_iLine, 1
	MOVLW 0x35
	MOVWF CompTempVar692, 1
	MOVLW 0x31
	MOVWF CompTempVar692+D'1', 1
	MOVLW 0x20
	MOVWF CompTempVar692+D'2', 1
	MOVLW 0x53
	MOVWF CompTempVar692+D'3', 1
	MOVLW 0x6F
	MOVWF CompTempVar692+D'4', 1
	MOVLW 0x75
	MOVWF CompTempVar692+D'5', 1
	MOVLW 0x6E
	MOVWF CompTempVar692+D'6', 1
	MOVLW 0x64
	MOVWF CompTempVar692+D'7', 1
	CLRF CompTempVar692+D'8', 1
	MOVLW HIGH(CompTempVar692+D'0')
	MOVWF ledPrint_00000_arg_s+D'1', 1
	MOVLW LOW(CompTempVar692+D'0')
	MOVWF ledPrint_00000_arg_s, 1
	CALL ledPrint_00000
	MOVLW 0xDB
	MOVWF gbl_ledData1, 1
	MOVF gbl_iExtSurroundMode, F, 1
	BZ	label99
	MOVLW 0x02
	MOVWF ledPrint_00000_arg_iLine, 1
	MOVLW 0x4F
	MOVWF CompTempVar695, 1
	MOVLW 0x6E
	MOVWF CompTempVar695+D'1', 1
	CLRF CompTempVar695+D'2', 1
	MOVLW HIGH(CompTempVar695+D'0')
	MOVWF ledPrint_00000_arg_s+D'1', 1
	MOVLW LOW(CompTempVar695+D'0')
	MOVWF ledPrint_00000_arg_s, 1
	CALL ledPrint_00000
	BRA	label102
label99
	MOVLW 0x02
	MOVWF ledPrint_00000_arg_iLine, 1
	MOVLW 0x4F
	MOVWF CompTempVar697, 1
	MOVLW 0x66
	MOVWF CompTempVar697+D'1', 1
	MOVWF CompTempVar697+D'2', 1
	CLRF CompTempVar697+D'3', 1
	MOVLW HIGH(CompTempVar697+D'0')
	MOVWF ledPrint_00000_arg_s+D'1', 1
	MOVLW LOW(CompTempVar697+D'0')
	MOVWF ledPrint_00000_arg_s, 1
	CALL ledPrint_00000
	BRA	label102
label100
	MOVLW 0x01
	MOVWF ledPrint_00000_arg_iLine, 1
	MOVLW 0x48
	MOVWF CompTempVar699, 1
	MOVLW 0x61
	MOVWF CompTempVar699+D'1', 1
	MOVLW 0x66
	MOVWF CompTempVar699+D'2', 1
	MOVLW 0x6C
	MOVWF CompTempVar699+D'3', 1
	MOVLW 0x65
	MOVWF CompTempVar699+D'4', 1
	MOVLW 0x72
	MOVWF CompTempVar699+D'5', 1
	CLRF CompTempVar699+D'6', 1
	MOVLW HIGH(CompTempVar699+D'0')
	MOVWF ledPrint_00000_arg_s+D'1', 1
	MOVLW LOW(CompTempVar699+D'0')
	MOVWF ledPrint_00000_arg_s, 1
	CALL ledPrint_00000
	MOVF gbl_iSurroundMode, F, 1
	BZ	label101
	MOVLW 0x02
	MOVWF ledPrint_00000_arg_iLine, 1
	MOVLW 0x4F
	MOVWF CompTempVar701, 1
	MOVLW 0x6E
	MOVWF CompTempVar701+D'1', 1
	CLRF CompTempVar701+D'2', 1
	MOVLW HIGH(CompTempVar701+D'0')
	MOVWF ledPrint_00000_arg_s+D'1', 1
	MOVLW LOW(CompTempVar701+D'0')
	MOVWF ledPrint_00000_arg_s, 1
	CALL ledPrint_00000
	BRA	label102
label101
	MOVLW 0x02
	MOVWF ledPrint_00000_arg_iLine, 1
	MOVLW 0x4F
	MOVWF CompTempVar703, 1
	MOVLW 0x66
	MOVWF CompTempVar703+D'1', 1
	MOVWF CompTempVar703+D'2', 1
	CLRF CompTempVar703+D'3', 1
	MOVLW HIGH(CompTempVar703+D'0')
	MOVWF ledPrint_00000_arg_s+D'1', 1
	MOVLW LOW(CompTempVar703+D'0')
	MOVWF ledPrint_00000_arg_s, 1
	CALL ledPrint_00000
label102
	CALL ledWrite_00000
	RETURN
; } functionDisplay function end

	ORG 0x00000B14
eepromRead_00000
; { eepromRead ; function begin
	MOVF eepromRead_00000_arg_address, W, 1
	MOVWF gbl_eeadr
	BCF gbl_eecon1,7
	BCF gbl_eecon1,6
	BSF gbl_eecon1,0
	MOVF gbl_eedata, W
	MOVWF CompTempVarRet582, 1
	RETURN
; } eepromRead function end

	ORG 0x00000B24
timer1Rese_0001A
; { timer1Reset ; function begin
	MOVLB 0x00
	CLRF gbl_iMuteWasPressed, 1
	MOVLW 0x0C
	MOVWF gbl_tmr1h
	CLRF gbl_tmr1l
	RETURN
; } timer1Reset function end

	ORG 0x00000B30
readData_00000
; { readData ; function begin
	MOVLB 0x00
	CLRF eepromRead_00000_arg_address, 1
	CALL eepromRead_00000
	MOVLW 0x0A
	CPFSEQ CompTempVarRet582, 1
	RETURN
	MOVLW 0x01
	MOVWF eepromRead_00000_arg_address, 1
	CALL eepromRead_00000
	MOVF CompTempVarRet582, W, 1
	MOVWF gbl_iVolume, 1
	MOVLW 0x02
	MOVWF eepromRead_00000_arg_address, 1
	CALL eepromRead_00000
	MOVF CompTempVarRet582, W, 1
	MOVWF gbl_iFrontBalance, 1
	MOVLW 0x03
	MOVWF eepromRead_00000_arg_address, 1
	CALL eepromRead_00000
	MOVF CompTempVarRet582, W, 1
	MOVWF gbl_iRearBalance, 1
	MOVLW 0x04
	MOVWF eepromRead_00000_arg_address, 1
	CALL eepromRead_00000
	MOVF CompTempVarRet582, W, 1
	MOVWF gbl_iRearAdjust, 1
	MOVLW 0x05
	MOVWF eepromRead_00000_arg_address, 1
	CALL eepromRead_00000
	MOVF CompTempVarRet582, W, 1
	MOVWF gbl_iCentreAdjust, 1
	MOVLW 0x06
	MOVWF eepromRead_00000_arg_address, 1
	CALL eepromRead_00000
	MOVF CompTempVarRet582, W, 1
	MOVWF gbl_iSubAdjust, 1
	MOVLW 0x07
	MOVWF eepromRead_00000_arg_address, 1
	CALL eepromRead_00000
	MOVF CompTempVarRet582, W, 1
	MOVWF gbl_iActiveInput, 1
	MOVLW 0x08
	MOVWF eepromRead_00000_arg_address, 1
	CALL eepromRead_00000
	MOVF CompTempVarRet582, W, 1
	MOVWF gbl_iSurroundMode, 1
	MOVLW 0x09
	MOVWF eepromRead_00000_arg_address, 1
	CALL eepromRead_00000
	MOVF CompTempVarRet582, W, 1
	MOVWF gbl_iExtSurroundMode, 1
	MOVLW 0x0A
	MOVWF eepromRead_00000_arg_address, 1
	CALL eepromRead_00000
	MOVF CompTempVarRet582, W, 1
	MOVWF gbl_iTrigger, 1
	RETURN
; } readData function end

	ORG 0x00000BB8
ledTest_00000
; { ledTest ; function begin
	MOVLW 0x01
	MOVLB 0x00
	MOVWF ledPrint_00000_arg_iLine, 1
	MOVLW 0x20
	MOVWF CompTempVar600+D'4', 1
	MOVLW 0x49
	MOVWF CompTempVar600, 1
	MOVLW 0x69
	MOVWF CompTempVar600+D'2', 1
	MOVLW 0x6E
	MOVWF CompTempVar600+D'1', 1
	MOVWF CompTempVar600+D'6', 1
	MOVLW 0x6F
	MOVWF CompTempVar600+D'5', 1
	MOVLW 0x74
	MOVWF CompTempVar600+D'3', 1
	CLRF CompTempVar600+D'7', 1
	MOVLW HIGH(CompTempVar600+D'0')
	MOVWF ledPrint_00000_arg_s+D'1', 1
	MOVLW LOW(CompTempVar600+D'0')
	MOVWF ledPrint_00000_arg_s, 1
	CALL ledPrint_00000
	MOVLW 0x02
	MOVWF ledPrint_00000_arg_iLine, 1
	MOVLW 0x54
	MOVWF CompTempVar602, 1
	MOVLW 0x65
	MOVWF CompTempVar602+D'1', 1
	MOVLW 0x73
	MOVWF CompTempVar602+D'2', 1
	MOVLW 0x74
	MOVWF CompTempVar602+D'3', 1
	MOVLW 0x69
	MOVWF CompTempVar602+D'4', 1
	MOVLW 0x6E
	MOVWF CompTempVar602+D'5', 1
	MOVLW 0x67
	MOVWF CompTempVar602+D'6', 1
	CLRF CompTempVar602+D'7', 1
	MOVLW HIGH(CompTempVar602+D'0')
	MOVWF ledPrint_00000_arg_s+D'1', 1
	MOVLW LOW(CompTempVar602+D'0')
	MOVWF ledPrint_00000_arg_s, 1
	CALL ledPrint_00000
	CALL ledWrite_00000
	RETURN
; } ledTest function end

	ORG 0x00000C1A
functionUp_00000
; { functionUp ; function begin
	MOVLB 0x00
	INCF gbl_iFunctionMode, F, 1
	MOVLW 0x09
	CPFSGT gbl_iFunctionMode, 1
	BRA	label103
	MOVLW 0x01
	MOVWF gbl_iFunctionMode, 1
label103
	CALL functionDi_00022
	RETURN
; } functionUp function end

	ORG 0x00000C2E
functionRa_00024
; { functionRaise ; function begin
	MOVLB 0x00
	DECF gbl_iFunctionMode, W, 1
	BZ	label111
	MOVLW 0x02
	CPFSEQ gbl_iFunctionMode, 1
	BRA	label104
	BRA	label112
label104
	MOVLW 0x03
	CPFSEQ gbl_iFunctionMode, 1
	BRA	label105
	BRA	label113
label105
	MOVLW 0x04
	CPFSEQ gbl_iFunctionMode, 1
	BRA	label106
	BRA	label114
label106
	MOVLW 0x05
	CPFSEQ gbl_iFunctionMode, 1
	BRA	label107
	BRA	label115
label107
	MOVLW 0x06
	CPFSEQ gbl_iFunctionMode, 1
	BRA	label108
	BRA	label116
label108
	MOVLW 0x07
	CPFSEQ gbl_iFunctionMode, 1
	BRA	label109
	BRA	label117
label109
	MOVLW 0x08
	CPFSEQ gbl_iFunctionMode, 1
	BRA	label110
	BRA	label118
label110
	MOVLW 0x09
	CPFSEQ gbl_iFunctionMode, 1
	BRA	label124
	BRA	label121
label111
	MOVF gbl_iCentreAdjust, W, 1
	MOVWF functionVa_00025_arg_iValue, 1
	CALL functionVa_00025
	MOVF CompTempVarRet709, W, 1
	MOVWF gbl_iCentreAdjust, 1
	CALL writeVolum_0001E
	BRA	label124
label112
	MOVF gbl_iRearAdjust, W, 1
	MOVWF functionVa_00025_arg_iValue, 1
	CALL functionVa_00025
	MOVF CompTempVarRet709, W, 1
	MOVWF gbl_iRearAdjust, 1
	CALL writeVolum_0001E
	BRA	label124
label113
	MOVF gbl_iFrontBalance, W, 1
	MOVWF functionVa_00025_arg_iValue, 1
	CALL functionVa_00025
	MOVF CompTempVarRet709, W, 1
	MOVWF gbl_iFrontBalance, 1
	CALL writeVolum_0001E
	BRA	label124
label114
	MOVF gbl_iRearBalance, W, 1
	MOVWF functionVa_00025_arg_iValue, 1
	CALL functionVa_00025
	MOVF CompTempVarRet709, W, 1
	MOVWF gbl_iRearBalance, 1
	CALL writeVolum_0001E
	BRA	label124
label115
	MOVF gbl_iSubAdjust, W, 1
	MOVWF functionVa_00025_arg_iValue, 1
	CALL functionVa_00025
	MOVF CompTempVarRet709, W, 1
	MOVWF gbl_iSubAdjust, 1
	CALL writeVolum_0001E
	BRA	label124
label116
	BSF gbl_iTrigger,0, 1
	CALL writeRelay_00000
	BRA	label124
label117
	BSF gbl_iTrigger,1, 1
	CALL writeRelay_00000
	BRA	label124
label118
	MOVF gbl_iExtSurroundMode, F, 1
	BZ	label119
	CLRF gbl_iExtSurroundMode, 1
	BRA	label120
label119
	MOVLW 0x01
	MOVWF gbl_iExtSurroundMode, 1
label120
	CALL writeRelay_00000
	BRA	label124
label121
	MOVF gbl_iSurroundMode, F, 1
	BZ	label122
	CLRF gbl_iSurroundMode, 1
	BRA	label123
label122
	MOVLW 0x01
	MOVWF gbl_iSurroundMode, 1
label123
	CALL writeVolum_0001E
label124
	CALL functionDi_00022
	RETURN
; } functionRaise function end

	ORG 0x00000D06
functionLo_00026
; { functionLower ; function begin
	MOVLB 0x00
	DECF gbl_iFunctionMode, W, 1
	BZ	label132
	MOVLW 0x02
	CPFSEQ gbl_iFunctionMode, 1
	BRA	label125
	BRA	label133
label125
	MOVLW 0x03
	CPFSEQ gbl_iFunctionMode, 1
	BRA	label126
	BRA	label134
label126
	MOVLW 0x04
	CPFSEQ gbl_iFunctionMode, 1
	BRA	label127
	BRA	label135
label127
	MOVLW 0x05
	CPFSEQ gbl_iFunctionMode, 1
	BRA	label128
	BRA	label136
label128
	MOVLW 0x06
	CPFSEQ gbl_iFunctionMode, 1
	BRA	label129
	BRA	label137
label129
	MOVLW 0x07
	CPFSEQ gbl_iFunctionMode, 1
	BRA	label130
	BRA	label138
label130
	MOVLW 0x08
	CPFSEQ gbl_iFunctionMode, 1
	BRA	label131
	BRA	label139
label131
	MOVLW 0x09
	CPFSEQ gbl_iFunctionMode, 1
	BRA	label145
	BRA	label142
label132
	MOVF gbl_iCentreAdjust, W, 1
	MOVWF functionVa_00027_arg_iValue, 1
	CALL functionVa_00027
	MOVF CompTempVarRet710, W, 1
	MOVWF gbl_iCentreAdjust, 1
	CALL writeVolum_0001E
	BRA	label145
label133
	MOVF gbl_iRearAdjust, W, 1
	MOVWF functionVa_00027_arg_iValue, 1
	CALL functionVa_00027
	MOVF CompTempVarRet710, W, 1
	MOVWF gbl_iRearAdjust, 1
	CALL writeVolum_0001E
	BRA	label145
label134
	MOVF gbl_iFrontBalance, W, 1
	MOVWF functionVa_00027_arg_iValue, 1
	CALL functionVa_00027
	MOVF CompTempVarRet710, W, 1
	MOVWF gbl_iFrontBalance, 1
	CALL writeVolum_0001E
	BRA	label145
label135
	MOVF gbl_iRearBalance, W, 1
	MOVWF functionVa_00027_arg_iValue, 1
	CALL functionVa_00027
	MOVF CompTempVarRet710, W, 1
	MOVWF gbl_iRearBalance, 1
	CALL writeVolum_0001E
	BRA	label145
label136
	MOVF gbl_iSubAdjust, W, 1
	MOVWF functionVa_00027_arg_iValue, 1
	CALL functionVa_00027
	MOVF CompTempVarRet710, W, 1
	MOVWF gbl_iSubAdjust, 1
	CALL writeVolum_0001E
	BRA	label145
label137
	BCF gbl_iTrigger,0, 1
	CALL writeRelay_00000
	BRA	label145
label138
	BCF gbl_iTrigger,1, 1
	CALL writeRelay_00000
	BRA	label145
label139
	MOVF gbl_iExtSurroundMode, F, 1
	BZ	label140
	CLRF gbl_iExtSurroundMode, 1
	BRA	label141
label140
	MOVLW 0x01
	MOVWF gbl_iExtSurroundMode, 1
label141
	CALL writeRelay_00000
	BRA	label145
label142
	MOVF gbl_iSurroundMode, F, 1
	BZ	label143
	CLRF gbl_iSurroundMode, 1
	BRA	label144
label143
	MOVLW 0x01
	MOVWF gbl_iSurroundMode, 1
label144
	CALL writeVolum_0001E
label145
	CALL functionDi_00022
	RETURN
; } functionLower function end

	ORG 0x00000DDE
functionDo_00028
; { functionDown ; function begin
	MOVLB 0x00
	DECF gbl_iFunctionMode, F, 1
	MOVLW 0x01
	CPFSLT gbl_iFunctionMode, 1
	BRA	label146
	MOVLW 0x09
	MOVWF gbl_iFunctionMode, 1
label146
	CALL functionDi_00022
	RETURN
; } functionDown function end

	ORG 0x00000DF2
eepromWrit_0001B
; { eepromWrite ; function begin
	MOVF gbl_intcon, W
	MOVWF eepromWrit_0001B_1_intconsave, 1
	MOVF eepromWrit_0001B_arg_address, W, 1
	MOVWF gbl_eeadr
	MOVF eepromWrit_0001B_arg_data, W, 1
	MOVWF gbl_eedata
	BCF gbl_eecon1,7
	BCF gbl_eecon1,6
	BSF gbl_eecon1,2
	CLRF gbl_intcon
	MOVLW 0x55
	MOVWF gbl_eecon2
	MOVLW 0xAA
	MOVWF gbl_eecon2
	BSF gbl_eecon1,1
	MOVF eepromWrit_0001B_1_intconsave, W, 1
	MOVWF gbl_intcon
	BCF gbl_eecon1,2
label147
	BTFSS gbl_pir2,4
	BRA	label147
	BCF gbl_pir2,4
	RETURN
; } eepromWrite function end

	ORG 0x00000E1E
doVolumeUp_00000
; { doVolumeUp ; function begin
	MOVLW 0xFF
	MOVLB 0x00
	CPFSLT gbl_iVolume, 1
	RETURN
	MOVLW 0x02
	ADDWF gbl_iVolume, W, 1
	MOVWF doVolumeUp_00000_2_iNewVol, 1
	MOVF gbl_iVolume, W, 1
	CPFSLT doVolumeUp_00000_2_iNewVol, 1
	BRA	label148
	SETF doVolumeUp_00000_2_iNewVol, 1
label148
	MOVF doVolumeUp_00000_2_iNewVol, W, 1
	MOVWF gbl_iVolume, 1
	CALL writeVolum_0001E
	RETURN
; } doVolumeUp function end

	ORG 0x00000E3E
doVolumeDo_00029
; { doVolumeDown ; function begin
	MOVLW 0x00
	MOVLB 0x00
	CPFSGT gbl_iVolume, 1
	RETURN
	MOVLW 0x02
	SUBWF gbl_iVolume, W, 1
	MOVWF doVolumeDo_00029_2_iNewVol, 1
	MOVF doVolumeDo_00029_2_iNewVol, W, 1
	CPFSLT gbl_iVolume, 1
	BRA	label149
	CLRF doVolumeDo_00029_2_iNewVol, 1
label149
	MOVF doVolumeDo_00029_2_iNewVol, W, 1
	MOVWF gbl_iVolume, 1
	CALL writeVolum_0001E
	RETURN
; } doVolumeDown function end

	ORG 0x00000E5E
doPower_00000
; { doPower ; function begin
	MOVLB 0x00
	MOVF gbl_iPower, F, 1
	BZ	label150
	BCF gbl_porta,1
	BCF gbl_porta,5
	BSF gbl_porta,4
	BCF gbl_porta,3
	BCF gbl_t1con,0
	MOVLW 0x01
	MOVWF ledPrint_00000_arg_iLine, 1
	MOVLW 0x47
	MOVWF CompTempVar612, 1
	MOVLW 0x6F
	MOVWF CompTempVar612+D'1', 1
	MOVWF CompTempVar612+D'2', 1
	MOVLW 0x64
	MOVWF CompTempVar612+D'3', 1
	MOVLW 0x62
	MOVWF CompTempVar612+D'4', 1
	MOVLW 0x79
	MOVWF CompTempVar612+D'5', 1
	MOVLW 0x65
	MOVWF CompTempVar612+D'6', 1
	CLRF CompTempVar612+D'7', 1
	MOVLW HIGH(CompTempVar612+D'0')
	MOVWF ledPrint_00000_arg_s+D'1', 1
	MOVLW LOW(CompTempVar612+D'0')
	MOVWF ledPrint_00000_arg_s, 1
	CALL ledPrint_00000
	MOVLW 0x02
	MOVWF ledPrint_00000_arg_iLine, 1
	CLRF CompTempVar614, 1
	MOVLW HIGH(CompTempVar614+D'0')
	MOVWF ledPrint_00000_arg_s+D'1', 1
	MOVLW LOW(CompTempVar614+D'0')
	MOVWF ledPrint_00000_arg_s, 1
	CALL ledPrint_00000
	CALL ledWrite_00000
	CLRF gbl_iPower, 1
	MOVLW 0xFA
	MOVWF delay_ms_00000_arg_del, 1
	CALL delay_ms_00000
	MOVLW 0xFA
	MOVWF delay_ms_00000_arg_del, 1
	CALL delay_ms_00000
	CALL writeRelay_00000
	MOVLW 0xFA
	MOVWF delay_ms_00000_arg_del, 1
	CALL delay_ms_00000
	MOVLW 0xFA
	MOVWF delay_ms_00000_arg_del, 1
	CALL delay_ms_00000
	BCF gbl_porta,0
	MOVLW 0x06
	MOVWF delay_s_00000_arg_del, 1
	CALL delay_s_00000
	CALL ledOff_00000
	BCF gbl_porta,5
	BCF gbl_porta,4
	BSF gbl_porta,3
	RETURN
label150
	BTFSS gbl_portb,2
	RETURN
	BSF gbl_porta,0
	BCF gbl_porta,5
	BSF gbl_porta,4
	BCF gbl_porta,3
	CALL writeVolum_0001E
	CALL ledOn_00000
	MOVLW 0x01
	MOVWF ledPrint_00000_arg_iLine, 1
	MOVLW 0x48
	MOVWF CompTempVar616, 1
	MOVLW 0x45
	MOVWF CompTempVar616+D'1', 1
	MOVLW 0x4C
	MOVWF CompTempVar616+D'2', 1
	MOVWF CompTempVar616+D'3', 1
	MOVLW 0x4F
	MOVWF CompTempVar616+D'4', 1
	CLRF CompTempVar616+D'5', 1
	MOVLW HIGH(CompTempVar616+D'0')
	MOVWF ledPrint_00000_arg_s+D'1', 1
	MOVLW LOW(CompTempVar616+D'0')
	MOVWF ledPrint_00000_arg_s, 1
	CALL ledPrint_00000
	MOVLW 0x02
	MOVWF ledPrint_00000_arg_iLine, 1
	CLRF CompTempVar618, 1
	MOVLW HIGH(CompTempVar618+D'0')
	MOVWF ledPrint_00000_arg_s+D'1', 1
	MOVLW LOW(CompTempVar618+D'0')
	MOVWF ledPrint_00000_arg_s, 1
	CALL ledPrint_00000
	CALL ledWrite_00000
	MOVLW 0x01
	MOVWF gbl_iPower, 1
	CALL writeRelay_00000
	CLRF doPower_00000_51_l, 1
label151
	MOVLW 0x1B
	CPFSLT doPower_00000_51_l, 1
	BRA	label152
	BSF gbl_porta,5
	BCF gbl_porta,4
	MOVLW 0x64
	MOVWF delay_ms_00000_arg_del, 1
	CALL delay_ms_00000
	BCF gbl_porta,5
	BSF gbl_porta,4
	MOVLW 0x64
	MOVWF delay_ms_00000_arg_del, 1
	CALL delay_ms_00000
	INCF doPower_00000_51_l, F, 1
	BRA	label151
label152
	CALL writeVolum_0001E
	CALL showInput_00000
	CALL showVolume_00000
	CALL ledWrite_00000
	BTFSC gbl_portb,2
	BRA	label153
	CALL showFault_00000
	CLRF gbl_iPower, 1
	BRA	label154
label153
	BSF gbl_porta,1
label154
	BSF gbl_t1con,0
	RETURN
; } doPower function end

	ORG 0x00000F88
doInputUp_00000
; { doInputUp ; function begin
	MOVLB 0x00
	INCF gbl_iActiveInput, F, 1
	MOVLW 0x04
	CPFSLT gbl_iActiveInput, 1
	BRA	label155
	BRA	label156
label155
	CLRF gbl_iActiveInput, 1
label156
	CALL writeRelay_00000
	RETURN
; } doInputUp function end

	ORG 0x00000F9C
doInputDow_00020
; { doInputDown ; function begin
	MOVLB 0x00
	DECF gbl_iActiveInput, F, 1
	MOVLW 0x04
	CPFSGT gbl_iActiveInput, 1
	BRA	label157
	MOVLW 0x03
	MOVWF gbl_iActiveInput, 1
label157
	CALL writeRelay_00000
	RETURN
; } doInputDown function end

	ORG 0x00000FB0
saveData_00000
; { saveData ; function begin
	MOVLB 0x00
	CLRF eepromWrit_0001B_arg_address, 1
	MOVLW 0x0A
	MOVWF eepromWrit_0001B_arg_data, 1
	CALL eepromWrit_0001B
	MOVLW 0x01
	MOVWF eepromWrit_0001B_arg_address, 1
	MOVF gbl_iVolume, W, 1
	MOVWF eepromWrit_0001B_arg_data, 1
	CALL eepromWrit_0001B
	MOVLW 0x02
	MOVWF eepromWrit_0001B_arg_address, 1
	MOVF gbl_iFrontBalance, W, 1
	MOVWF eepromWrit_0001B_arg_data, 1
	CALL eepromWrit_0001B
	MOVLW 0x03
	MOVWF eepromWrit_0001B_arg_address, 1
	MOVF gbl_iRearBalance, W, 1
	MOVWF eepromWrit_0001B_arg_data, 1
	CALL eepromWrit_0001B
	MOVLW 0x04
	MOVWF eepromWrit_0001B_arg_address, 1
	MOVF gbl_iRearAdjust, W, 1
	MOVWF eepromWrit_0001B_arg_data, 1
	CALL eepromWrit_0001B
	MOVLW 0x05
	MOVWF eepromWrit_0001B_arg_address, 1
	MOVF gbl_iCentreAdjust, W, 1
	MOVWF eepromWrit_0001B_arg_data, 1
	CALL eepromWrit_0001B
	MOVLW 0x06
	MOVWF eepromWrit_0001B_arg_address, 1
	MOVF gbl_iSubAdjust, W, 1
	MOVWF eepromWrit_0001B_arg_data, 1
	CALL eepromWrit_0001B
	MOVLW 0x07
	MOVWF eepromWrit_0001B_arg_address, 1
	MOVF gbl_iActiveInput, W, 1
	MOVWF eepromWrit_0001B_arg_data, 1
	CALL eepromWrit_0001B
	MOVLW 0x08
	MOVWF eepromWrit_0001B_arg_address, 1
	MOVF gbl_iSurroundMode, W, 1
	MOVWF eepromWrit_0001B_arg_data, 1
	CALL eepromWrit_0001B
	MOVLW 0x09
	MOVWF eepromWrit_0001B_arg_address, 1
	MOVF gbl_iExtSurroundMode, W, 1
	MOVWF eepromWrit_0001B_arg_data, 1
	CALL eepromWrit_0001B
	MOVLW 0x0A
	MOVWF eepromWrit_0001B_arg_address, 1
	MOVF gbl_iTrigger, W, 1
	MOVWF eepromWrit_0001B_arg_data, 1
	CALL eepromWrit_0001B
	RETURN
; } saveData function end

	ORG 0x00001036
rc5Process_00000
; { rc5Process ; function begin
	BCF gbl_porta,2
	MOVLB 0x00
	CLRF rc5Process_00000_1_iGotCommand, 1
	MOVF gbl_rc5_address, F, 1
	BTFSS STATUS,Z
	RETURN
	MOVF gbl_iPower, F, 1
	BTFSC STATUS,Z
	BRA	label175
	MOVLW 0x0D
	CPFSEQ gbl_rc5_command, 1
	BRA	label158
	BRA	label162
label158
	MOVLW 0x10
	CPFSEQ gbl_rc5_command, 1
	BRA	label159
	BRA	label167
label159
	MOVLW 0x11
	CPFSEQ gbl_rc5_command, 1
	BRA	label160
	BRA	label169
label160
	MOVLW 0x20
	CPFSEQ gbl_rc5_command, 1
	BRA	label161
	BRA	label171
label161
	MOVLW 0x21
	CPFSEQ gbl_rc5_command, 1
	BRA	label175
	BRA	label173
label162
	MOVF gbl_rc5_flickBit, W, 1
	CPFSEQ gbl_rc5_flickBitOld, 1
	CPFSEQ gbl_rc5_flickBit, 1
	BRA	label164
	CLRF gbl_iMuteHeld, 1
	MOVF gbl_iFunctionMode, F, 1
	BNZ	label163
	CALL timer1Rese_0001A
	MOVLW 0x01
	MOVWF gbl_iMuteWasPressed, 1
	BRA	label175
label163
	CLRF gbl_iFunctionMode, 1
	MOVLW 0x01
	MOVWF rc5Process_00000_1_iGotCommand, 1
	CALL timer1Rese_0001A
	BRA	label175
label164
	INCF gbl_iMuteHeld, F, 1
	CALL timer1Rese_0001A
	MOVLW 0x09
	CPFSLT gbl_iMuteHeld, 1
	BRA	label165
	BRA	label166
label165
	CLRF gbl_iMuteWasPressed, 1
	BSF gbl_cTask,6, 1
	BRA	label175
label166
	BSF gbl_t1con,0
	BRA	label175
label167
	MOVF gbl_iFunctionMode, F, 1
	BNZ	label168
	MOVLW 0x01
	MOVWF rc5Process_00000_1_iGotCommand, 1
	CALL doVolumeUp_00000
	BRA	label175
label168
	CALL functionRa_00024
	BRA	label175
label169
	MOVF gbl_iFunctionMode, F, 1
	BNZ	label170
	MOVLW 0x01
	MOVWF rc5Process_00000_1_iGotCommand, 1
	CALL doVolumeDo_00029
	BRA	label175
label170
	CALL functionLo_00026
	BRA	label175
label171
	MOVF gbl_rc5_flickBit, W, 1
	CPFSEQ gbl_rc5_flickBitOld, 1
	CPFSEQ gbl_rc5_flickBit, 1
	BRA	label175
	MOVF gbl_iFunctionMode, F, 1
	BNZ	label172
	MOVLW 0x01
	MOVWF rc5Process_00000_1_iGotCommand, 1
	CALL doInputUp_00000
	BRA	label175
label172
	CALL functionUp_00000
	BRA	label175
label173
	MOVF gbl_rc5_flickBit, W, 1
	CPFSEQ gbl_rc5_flickBitOld, 1
	CPFSEQ gbl_rc5_flickBit, 1
	BRA	label175
	MOVF gbl_iFunctionMode, F, 1
	BNZ	label174
	MOVLW 0x01
	MOVWF rc5Process_00000_1_iGotCommand, 1
	CALL doInputDow_00020
	BRA	label175
label174
	CALL functionDo_00028
label175
	MOVLW 0x0C
	CPFSEQ gbl_rc5_command, 1
	BRA	label176
	MOVF gbl_rc5_flickBit, W, 1
	CPFSEQ gbl_rc5_flickBitOld, 1
	CPFSEQ gbl_rc5_flickBit, 1
	BRA	label176
	CLRF gbl_iFunctionMode, 1
	CALL doPower_00000
label176
	MOVF gbl_rc5_flickBit, W, 1
	MOVWF gbl_rc5_flickBitOld, 1
	MOVF gbl_iPower, F, 1
	BTFSC STATUS,Z
	RETURN
	MOVF rc5Process_00000_1_iGotCommand, F, 1
	BZ	label177
	CALL showInput_00000
	CALL showVolume_00000
	CALL ledWrite_00000
	RETURN
label177
	MOVF gbl_iFunctionMode, F, 1
	BTFSS STATUS,Z
	CLRF gbl_iTimer1SecCounts, 1
	RETURN
; } rc5Process function end

	ORG 0x00001142
onTimer1_00000
; { onTimer1 ; function begin
	MOVLB 0x00
	INCF gbl_iTimer1SecCounts, F, 1
	MOVLW 0x1E
	CPFSLT gbl_iTimer1SecCounts, 1
	BRA	label178
	BRA	label180
label178
	MOVF gbl_iPower, F, 1
	BZ	label179
	BTFSS gbl_portb,2
	BRA	label179
	BSF gbl_porta,1
	BCF gbl_porta,3
	BSF gbl_porta,5
	CLRF gbl_iFunctionMode, 1
	CALL showVolume_00000
	CALL showInput_00000
	CALL ledWrite_00000
label179
	CLRF gbl_iTimer1SecCounts, 1
label180
	BTFSS gbl_portd,6
	BRA	label182
	MOVF gbl_iPower, F, 1
	BZ	label182
	MOVF gbl_iPowerExternal, F, 1
	BZ	label182
	MOVF gbl_iTimer1OffCount, F, 1
	BNZ	label181
	MOVLW 0x0A
	MOVWF gbl_iTimer1OffCount, 1
	CALL doPower_00000
	RETURN
label181
	DECF gbl_iTimer1OffCount, F, 1
	MOVLW 0x01
	MOVWF ledPrint_00000_arg_iLine, 1
	MOVLW 0x20
	MOVWF CompTempVar713+D'3', 1
	MOVWF CompTempVar713+D'6', 1
	MOVLW 0x49
	MOVWF CompTempVar713+D'4', 1
	MOVLW 0x4F
	MOVWF CompTempVar713, 1
	MOVLW 0x66
	MOVWF CompTempVar713+D'1', 1
	MOVWF CompTempVar713+D'2', 1
	MOVLW 0x6E
	MOVWF CompTempVar713+D'5', 1
	CLRF CompTempVar713+D'7', 1
	MOVLW HIGH(CompTempVar713+D'0')
	MOVWF ledPrint_00000_arg_s+D'1', 1
	MOVLW LOW(CompTempVar713+D'0')
	MOVWF ledPrint_00000_arg_s, 1
	CALL ledPrint_00000
	MOVLW 0x01
	MOVWF gbl_ledCurrentLine, 1
	MOVLW 0x07
	MOVWF gbl_ledCurrentCol, 1
	MOVLW 0x30
	ADDWF gbl_iTimer1OffCount, W, 1
	MOVWF ledChar_00000_arg_iChar, 1
	CLRF ledChar_00000_arg_iHasDot, 1
	CALL ledChar_00000
	CALL ledWrite_00000
	RETURN
label182
	MOVLW 0x0A
	CPFSLT gbl_iTimer1OffCount, 1
	RETURN
	MOVLW 0x0A
	MOVWF gbl_iTimer1OffCount, 1
	CLRF gbl_iFunctionMode, 1
	CALL showVolume_00000
	CALL showInput_00000
	CALL ledWrite_00000
	RETURN
; } onTimer1 function end

	ORG 0x000011E6
initialise_00000
; { initialise ; function begin
	CLRF gbl_trisa
	CLRF gbl_porta
	MOVLW 0x07
	MOVWF gbl_trisb
	MOVLW 0x20
	MOVWF gbl_portb
	MOVLW 0xC0
	MOVWF gbl_trisc
	MOVLW 0x04
	MOVWF gbl_portc
	MOVLW 0x40
	MOVWF gbl_trisd
	MOVLW 0x80
	MOVWF gbl_portd
	CLRF gbl_trise
	CLRF gbl_porte
	BSF gbl_osccon,7
	BSF gbl_osccon,6
	BSF gbl_osccon,5
	BCF gbl_osccon,4
	CLRF gbl_adcon0
	MOVLW 0x0F
	MOVWF gbl_adcon1
	CALL readData_00000
	CALL writeRelay_00000
	MOVLW 0x30
	MOVWF gbl_t1con
	CLRF gbl_iTimer1Count, 1
	MOVLW 0x0C
	MOVWF gbl_tmr1h
	BSF gbl_pie1,0
	BCF gbl_pir1,0
	MOVLW 0x29
	MOVWF gbl_t2con
	MOVLW 0x5C
	MOVWF gbl_pr2
	BSF gbl_pie1,1
	BCF gbl_pir2,1
	BSF gbl_intcon,4
	BSF gbl_intcon2,6
	BCF gbl_intcon,1
	BSF gbl_intcon3,3
	BCF gbl_intcon2,5
	BCF gbl_intcon3,0
	BSF gbl_intcon3,4
	BCF gbl_intcon2,4
	BCF gbl_intcon3,1
	BSF gbl_intcon2,7
	BSF gbl_intcon,6
	BSF gbl_porta,3
	MOVLW 0x02
	MOVWF delay_s_00000_arg_del, 1
	CALL delay_s_00000
	CALL ledOn_00000
	CALL ledTest_00000
	MOVLW 0x02
	MOVWF delay_s_00000_arg_del, 1
	CALL delay_s_00000
	CALL ledOff_00000
	BSF gbl_intcon,7
	RETURN
; } initialise function end

	ORG 0x0000126E
doMute_00000
; { doMute ; function begin
	MOVLB 0x00
	CLRF CompTempVar668, 1
	MOVF gbl_iMute, F, 1
	BTFSC STATUS,Z
	INCF CompTempVar668, F, 1
	MOVF CompTempVar668, W, 1
	MOVWF gbl_iMute, 1
	CALL writeVolum_0001E
	RETURN
; } doMute function end

	ORG 0x00001282
main
; { main ; function begin
	CALL initialise_00000
label183
	MOVLW 0x00
	CPFSGT gbl_cTask, 1
	BRA	label189
	BTFSS gbl_cTask,4, 1
	BRA	label184
	CALL showFault_00000
	BSF gbl_t1con,0
	BCF gbl_cTask,4, 1
	BRA	label183
label184
	BTFSS gbl_cTask,0, 1
	BRA	label185
	CALL saveData_00000
	BCF gbl_cTask,0, 1
	BRA	label183
label185
	BTFSS gbl_cTask,5, 1
	BRA	label186
	CALL doMute_00000
	CALL showVolume_00000
	CALL ledWrite_00000
	CALL timer1Rese_0001A
	BCF gbl_cTask,5, 1
	BRA	label183
label186
	BTFSS gbl_cTask,6, 1
	BRA	label187
	MOVLW 0x01
	MOVWF gbl_iFunctionMode, 1
	CALL functionDi_00022
	CALL timer1Rese_0001A
	BCF gbl_cTask,6, 1
	BRA	label183
label187
	BTFSS gbl_cTask,7, 1
	BRA	label188
	CALL onTimer1_00000
	BCF gbl_cTask,7, 1
	BRA	label183
label188
	BTFSS gbl_cTask,3, 1
	BRA	label183
	CALL rc5Process_00000
	BCF gbl_porta,2
	BCF gbl_cTask,3, 1
	BRA	label183
label189
	BTFSC gbl_portd,6
	BRA	label190
	TSTFSZ gbl_iPower, 1
	BRA	label190
	TSTFSZ gbl_iPowerExternal, 1
	BRA	label190
	MOVLW 0x01
	MOVWF gbl_iPowerExternal, 1
	CLRF gbl_iActiveInput, 1
	CALL doPower_00000
label190
	BTFSS gbl_portd,6
	BRA	label183
	TSTFSZ gbl_iPower, 1
	BRA	label183
	CLRF gbl_iPowerExternal, 1
	BRA	label183
; } main function end

	ORG 0x0000130E
_startup
	MOVLB 0x00
	CLRF gbl_cTask, 1
	CLRF gbl_iVolume, 1
	CLRF gbl_iMute, 1
	CLRF gbl_iMuteHeld, 1
	CLRF gbl_iMuteWasPressed, 1
	CLRF gbl_iFrontBalance, 1
	CLRF gbl_iRearBalance, 1
	CLRF gbl_iRearAdjust, 1
	CLRF gbl_iCentreAdjust, 1
	CLRF gbl_iSubAdjust, 1
	CLRF gbl_iPower, 1
	CLRF gbl_iPowerExternal, 1
	CLRF gbl_iActiveInput, 1
	MOVLW 0x01
	MOVWF gbl_iTrigger, 1
	MOVLW 0x01
	MOVWF gbl_iSurroundMode, 1
	MOVLW 0x01
	MOVWF gbl_iExtSurroundMode, 1
	CLRF gbl_iFunctionMode, 1
	CLRF gbl_iTimer1Count, 1
	CLRF gbl_iTimer1SecCounts, 1
	MOVLW 0x0A
	MOVWF gbl_iTimer1OffCount, 1
	CLRF gbl_displayASCIItoSeg
	CLRF gbl_displayASCIItoSeg+D'1'
	MOVLW 0x22
	MOVWF gbl_displayASCIItoSeg+D'2'
	CLRF gbl_displayASCIItoSeg+D'3'
	CLRF gbl_displayASCIItoSeg+D'4'
	CLRF gbl_displayASCIItoSeg+D'5'
	CLRF gbl_displayASCIItoSeg+D'6'
	MOVLW 0x20
	MOVWF gbl_displayASCIItoSeg+D'7'
	MOVLW 0x4E
	MOVWF gbl_displayASCIItoSeg+D'8'
	MOVLW 0x78
	MOVWF gbl_displayASCIItoSeg+D'9'
	CLRF gbl_displayASCIItoSeg+D'10'
	CLRF gbl_displayASCIItoSeg+D'11'
	CLRF gbl_displayASCIItoSeg+D'12'
	MOVLW 0x01
	MOVWF gbl_displayASCIItoSeg+D'13'
	CLRF gbl_displayASCIItoSeg+D'14'
	CLRF gbl_displayASCIItoSeg+D'15'
	MOVLW 0x7E
	MOVWF gbl_displayASCIItoSeg+D'16'
	MOVLW 0x30
	MOVWF gbl_displayASCIItoSeg+D'17'
	MOVLW 0x6D
	MOVWF gbl_displayASCIItoSeg+D'18'
	MOVLW 0x79
	MOVWF gbl_displayASCIItoSeg+D'19'
	MOVLW 0x33
	MOVWF gbl_displayASCIItoSeg+D'20'
	MOVLW 0x5B
	MOVWF gbl_displayASCIItoSeg+D'21'
	MOVLW 0x5F
	MOVWF gbl_displayASCIItoSeg+D'22'
	MOVLW 0x70
	MOVWF gbl_displayASCIItoSeg+D'23'
	MOVLW 0x7F
	MOVWF gbl_displayASCIItoSeg+D'24'
	MOVLW 0x7B
	MOVWF gbl_displayASCIItoSeg+D'25'
	CLRF gbl_displayASCIItoSeg+D'26'
	CLRF gbl_displayASCIItoSeg+D'27'
	CLRF gbl_displayASCIItoSeg+D'28'
	MOVLW 0x09
	MOVWF gbl_displayASCIItoSeg+D'29'
	CLRF gbl_displayASCIItoSeg+D'30'
	MOVLW 0x65
	MOVWF gbl_displayASCIItoSeg+D'31'
	CLRF gbl_displayASCIItoSeg+D'32'
	MOVLW 0x77
	MOVWF gbl_displayASCIItoSeg+D'33'
	MOVLW 0x1F
	MOVWF gbl_displayASCIItoSeg+D'34'
	MOVLW 0x4E
	MOVWF gbl_displayASCIItoSeg+D'35'
	MOVLW 0x3D
	MOVWF gbl_displayASCIItoSeg+D'36'
	MOVLW 0x4F
	MOVWF gbl_displayASCIItoSeg+D'37'
	MOVLW 0x47
	MOVWF gbl_displayASCIItoSeg+D'38'
	MOVLW 0x5E
	MOVWF gbl_displayASCIItoSeg+D'39'
	MOVLW 0x37
	MOVWF gbl_displayASCIItoSeg+D'40'
	MOVLW 0x30
	MOVWF gbl_displayASCIItoSeg+D'41'
	MOVLW 0x3C
	MOVWF gbl_displayASCIItoSeg+D'42'
	CLRF gbl_displayASCIItoSeg+D'43'
	MOVLW 0x0E
	MOVWF gbl_displayASCIItoSeg+D'44'
	CLRF gbl_displayASCIItoSeg+D'45'
	MOVLW 0x15
	MOVWF gbl_displayASCIItoSeg+D'46'
	MOVLW 0x7E
	MOVWF gbl_displayASCIItoSeg+D'47'
	MOVLW 0x67
	MOVWF gbl_displayASCIItoSeg+D'48'
	CLRF gbl_displayASCIItoSeg+D'49'
	MOVLW 0x05
	MOVWF gbl_displayASCIItoSeg+D'50'
	MOVLW 0x5B
	MOVWF gbl_displayASCIItoSeg+D'51'
	MOVLW 0x70
	MOVWF gbl_displayASCIItoSeg+D'52'
	MOVLW 0x3E
	MOVWF gbl_displayASCIItoSeg+D'53'
	CLRF gbl_displayASCIItoSeg+D'54'
	CLRF gbl_displayASCIItoSeg+D'55'
	CLRF gbl_displayASCIItoSeg+D'56'
	MOVLW 0x3B
	MOVWF gbl_displayASCIItoSeg+D'57'
	CLRF gbl_displayASCIItoSeg+D'58'
	CLRF gbl_displayASCIItoSeg+D'59'
	CLRF gbl_displayASCIItoSeg+D'60'
	CLRF gbl_displayASCIItoSeg+D'61'
	CLRF gbl_displayASCIItoSeg+D'62'
	CLRF gbl_displayASCIItoSeg+D'63'
	CLRF gbl_displayASCIItoSeg+D'64'
	MOVLW 0x7D
	MOVWF gbl_displayASCIItoSeg+D'65'
	MOVLW 0x1F
	MOVWF gbl_displayASCIItoSeg+D'66'
	MOVLW 0x0D
	MOVWF gbl_displayASCIItoSeg+D'67'
	MOVLW 0x3D
	MOVWF gbl_displayASCIItoSeg+D'68'
	MOVLW 0x6F
	MOVWF gbl_displayASCIItoSeg+D'69'
	MOVLW 0x47
	MOVWF gbl_displayASCIItoSeg+D'70'
	MOVLW 0x5E
	MOVWF gbl_displayASCIItoSeg+D'71'
	MOVLW 0x17
	MOVWF gbl_displayASCIItoSeg+D'72'
	MOVLW 0x10
	MOVWF gbl_displayASCIItoSeg+D'73'
	MOVLW 0x3C
	MOVWF gbl_displayASCIItoSeg+D'74'
	CLRF gbl_displayASCIItoSeg+D'75'
	MOVLW 0x0E
	MOVWF gbl_displayASCIItoSeg+D'76'
	CLRF gbl_displayASCIItoSeg+D'77'
	MOVLW 0x15
	MOVWF gbl_displayASCIItoSeg+D'78'
	MOVLW 0x1D
	MOVWF gbl_displayASCIItoSeg+D'79'
	MOVLW 0x67
	MOVWF gbl_displayASCIItoSeg+D'80'
	CLRF gbl_displayASCIItoSeg+D'81'
	MOVLW 0x05
	MOVWF gbl_displayASCIItoSeg+D'82'
	MOVLW 0x5B
	MOVWF gbl_displayASCIItoSeg+D'83'
	MOVLW 0x0F
	MOVWF gbl_displayASCIItoSeg+D'84'
	MOVLW 0x1C
	MOVWF gbl_displayASCIItoSeg+D'85'
	CLRF gbl_displayASCIItoSeg+D'86'
	CLRF gbl_displayASCIItoSeg+D'87'
	CLRF gbl_displayASCIItoSeg+D'88'
	MOVLW 0x3B
	MOVWF gbl_displayASCIItoSeg+D'89'
	CLRF gbl_displayASCIItoSeg+D'90'
	MOVLW 0x01
	MOVWF gbl_ledCurrentLine, 1
	CLRF gbl_ledCurrentCol, 1
	CLRF gbl_intfCounter, 1
	CLRF gbl_rc5_Held, 1
	CLRF gbl_rc5_currentState, 1
	MOVLW 0x01
	MOVWF gbl_rc5_pinState, 1
	CLRF gbl_rc5_flickBit, 1
	CLRF gbl_rc5_flickBitOld, 1
	CLRF gbl_rc5_address, 1
	CLRF gbl_rc5_command, 1
	GOTO	main
	ORG 0x00001480
interrupt
; { interrupt ; function begin
	MOVFF FSR0H,  Int1Context
	MOVFF FSR0L,  Int1Context+D'1'
	MOVFF PRODH,  Int1Context+D'2'
	MOVFF PRODL,  Int1Context+D'3'
	BTFSS gbl_intcon3,1
	BRA	label193
	BTFSS gbl_intcon3,4
	BRA	label193
	BTFSC gbl_portb,2
	BRA	label192
	BCF gbl_porta,1
	MOVLB 0x00
	BSF gbl_cTask,4, 1
label192
	BCF gbl_intcon3,1
	BRA	label217
label193
	BTFSS gbl_intcon,1
	BRA	label194
	BTFSS gbl_intcon,4
	BRA	label194
	BCF gbl_porta,1
	MOVLB 0x00
	BSF gbl_cTask,0, 1
	BCF gbl_intcon,1
	BRA	label217
label194
	BTFSS gbl_intcon3,0
	BRA	label196
	BTFSS gbl_intcon3,3
	BRA	label196
	MOVLB 0x00
	BTFSC gbl_intfCounter,0, 1
	BSF gbl_intcon2,5
	BTFSS gbl_intfCounter,0, 1
	BCF gbl_intcon2,5
	INCF gbl_intfCounter, F, 1
	INCF gbl_rc5_logicChange, F, 1
	MOVF gbl_rc5_currentState, F, 1
	BNZ	label195
	CLRF gbl_rc5_logicInterval, 1
	CLRF gbl_rc5_logicChange, 1
	CLRF gbl_tmr2
	MOVLW 0x15
	MOVWF gbl_pr2
	BCF gbl_pir1,1
	BSF gbl_t2con,2
	MOVLW 0x01
	MOVWF gbl_rc5_currentState, 1
label195
	BCF gbl_intcon3,0
label196
	BTFSS gbl_pir1,1
	BRA	label213
	MOVLB 0x00
	CLRF gbl_rc5_pinState, 1
	BTFSS gbl_portb,1
	BRA	label197
	INCF gbl_rc5_pinState, F, 1
label197
	DECF gbl_rc5_currentState, W, 1
	BZ	label198
	INCF gbl_rc5_logicInterval, F, 1
	BTFSC gbl_rc5_logicInterval,0, 1
	BSF gbl_porta,2
	BTFSS gbl_rc5_logicInterval,0, 1
	BCF gbl_porta,2
label198
	CLRF interrupt_27_iReset, 1
	DECF gbl_rc5_currentState, W, 1
	BZ	label200
	MOVLW 0x02
	CPFSEQ gbl_rc5_currentState, 1
	BRA	label199
	BRA	label201
label199
	MOVLW 0x03
	CPFSEQ gbl_rc5_currentState, 1
	BRA	label210
	BRA	label203
label200
	CLRF gbl_tmr2
	MOVLW 0x5C
	MOVWF gbl_pr2
	MOVLW 0x02
	MOVWF gbl_rc5_currentState, 1
	BRA	label211
label201
	DECF gbl_rc5_logicInterval, W, 1
	BNZ	label202
	DECF gbl_rc5_logicChange, W, 1
	BNZ	label202
	CLRF gbl_rc5_logicInterval, 1
	CLRF gbl_rc5_logicChange, 1
	CLRF gbl_rc5_bitCount, 1
	CLRF gbl_rc5_inputData, 1
	CLRF gbl_rc5_inputData+D'1', 1
	MOVLW 0x03
	MOVWF gbl_rc5_currentState, 1
	BRA	label211
label202
	MOVLW 0x01
	MOVWF interrupt_27_iReset, 1
	BRA	label211
label203
	MOVLW 0x02
	CPFSEQ gbl_rc5_logicInterval, 1
	BRA	label211
	MOVF gbl_rc5_logicChange, W, 1
	SUBLW 0x02
	BNC	label209
	CLRF gbl_rc5_logicInterval, 1
	CLRF gbl_rc5_logicChange, 1
	MOVLW 0x0C
	CPFSLT gbl_rc5_bitCount, 1
	BRA	label204
	INCF gbl_rc5_bitCount, F, 1
	BCF STATUS,C
	RLCF gbl_rc5_inputData, F, 1
	RLCF gbl_rc5_inputData+D'1', F, 1
	DECF gbl_rc5_pinState, W, 1
	BTFSC STATUS,Z
	BSF gbl_rc5_inputData,0, 1
	BRA	label211
label204
	MOVLW 0x3F
	ANDWF gbl_rc5_inputData, W, 1
	MOVWF gbl_rc5_command, 1
	MOVLW 0x06
	MOVWF CompTempVar711, 1
	MOVF CompTempVar711, F, 1
label205
	BZ	label206
	BCF STATUS,C
	RRCF gbl_rc5_inputData+D'1', F, 1
	RRCF gbl_rc5_inputData, F, 1
	DECF CompTempVar711, F, 1
	BRA	label205
label206
	MOVLW 0x1F
	ANDWF gbl_rc5_inputData, W, 1
	MOVWF gbl_rc5_address, 1
	MOVLW 0x05
	MOVWF CompTempVar712, 1
	MOVF CompTempVar712, F, 1
label207
	BZ	label208
	BCF STATUS,C
	RRCF gbl_rc5_inputData+D'1', F, 1
	RRCF gbl_rc5_inputData, F, 1
	DECF CompTempVar712, F, 1
	BRA	label207
label208
	MOVF gbl_rc5_inputData, W, 1
	MOVWF gbl_rc5_flickBit, 1
	BSF gbl_cTask,3, 1
	MOVLW 0x01
	MOVWF interrupt_27_iReset, 1
	BRA	label211
label209
	MOVLW 0x01
	MOVWF interrupt_27_iReset, 1
	BRA	label211
label210
	MOVLW 0x01
	MOVWF interrupt_27_iReset, 1
label211
	MOVF interrupt_27_iReset, F, 1
	BZ	label212
	CLRF gbl_rc5_currentState, 1
	BCF gbl_t2con,2
	BCF gbl_intcon2,5
	BCF gbl_porta,2
label212
	BCF gbl_pir1,1
label213
	BTFSS gbl_pir1,0
	BRA	label217
	BTFSS gbl_pie1,0
	BRA	label217
	MOVLW 0x09
	MOVLB 0x00
	CPFSLT gbl_iMuteHeld, 1
	BRA	label214
	MOVF gbl_iMuteWasPressed, F, 1
	BTFSS STATUS,Z
	BSF gbl_cTask,5, 1
label214
	INCF gbl_iTimer1Count, F, 1
	MOVLW 0x05
	CPFSLT gbl_iTimer1Count, 1
	BRA	label215
	BRA	label216
label215
	CLRF gbl_iTimer1Count, 1
	BSF gbl_cTask,7, 1
label216
	BCF gbl_pir1,0
label217
	MOVFF Int1Context+D'3',  PRODL
	MOVFF Int1Context+D'2',  PRODH
	MOVFF Int1Context+D'1',  FSR0L
	MOVFF Int1Context,  FSR0H
	RETFIE 1
; } interrupt function end

	ORG 0x00300000
	DW 0x8D08
	DW 0x1E1F
	ORG 0x00300004
	DW 0x80FF
	DW 0xFF80
	ORG 0x00300008
	DW 0xC00F
	DW 0xE00F
	DW 0x400F
	END
