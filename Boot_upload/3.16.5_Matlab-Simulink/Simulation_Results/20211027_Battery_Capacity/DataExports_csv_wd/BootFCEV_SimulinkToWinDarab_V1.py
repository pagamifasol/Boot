import numpy as np
import tkinter as tk
from tkinter import filedialog

root = tk.Tk()
root.withdraw()

DLFile = filedialog.askopenfilename()
wdFile = DLFile.replace('.csv','_wd.txt')

wd_header = 'xtime[s] xdist[m] FrontMot[rpm] RearMot[rpm] \
DragForce[N] INV_PwrOut[kW] FC_PwrOut[kW] Battery_PwrOut[kW]  TRSM_PwrOut[kW] \
Battery_HR[kW] FrontMot_HR[kW] RearMot_HR[kW] INV_Front_HR[kW] INV_Rear_HR[kW] Battery_SoC[pct]  \
Front_Mot_Trq[Nm] Rear_Mot_Trq[Nm] TRSM_Trq[Nm] '

print('Loading file: ',DLFile)

DL = np.genfromtxt(DLFile,delimiter=',',skip_header=0,names=True)

print('File loaded. Extracting columns...')

wd = np.vstack((DL['time'],DL['Distance'],DL['FrontMotor'],DL['RearMotor'],
                DL['TotDragForce'],DL['InverterOutputPower'],DL['FuelCellPower'],DL['BatteryPackPower'],DL['TransmissionPower'],
                DL['BatteryPackHR'],DL['FrontMotorHR'],DL['RearMotorHR'],DL['FrontInverterHR'],DL['RearInverterHR'],DL['HVB_SOC'], 
                DL['FrontMotorTrq'],DL['RearMotorsTrq'],DL['TransmissionTorque']))

wd = wd.transpose()

print('Done.')
print('Exporting to: ',wdFile)

np.savetxt(wdFile,wd,fmt='%.3f',header=wd_header,delimiter=' ',comments='')

print('Completed.')
