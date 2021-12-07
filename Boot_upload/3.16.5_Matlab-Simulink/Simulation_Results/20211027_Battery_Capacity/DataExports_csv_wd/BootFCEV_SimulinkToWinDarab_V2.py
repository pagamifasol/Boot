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
Front_Mot_Trq[Nm] Rear_Mot_Trq[Nm] TRSM_Trq[Nm] \
FC_reqPwr[kW] FC_actPwr[kW]'

print('Loading file: ',DLFile)

DL = np.genfromtxt(DLFile,delimiter=',',skip_header=0,names=True)

print('File loaded. Extracting columns...')

wd = np.vstack((DL['time'],DL['VLD_lActVhcl_km'],DL['TRSM_nMtrFrt_rpm'],DL['TRSM_nMtrRr_rpm'],
                DL['FRst_N'],DL['INV_PwrOut_kW'],DL['FC_P']/1000,DL['HVB_P']/1000,DL['TRSM_PwrWhl_W']/1000,
                DL['BTR_HR_pack_kW'],DL['MTR_Fr_HR_kW'],DL['MTR_Rr_HR_kW'],DL['INV_Fr_HR_kW'],DL['INV_Rr_HR_kW'],DL['HVB_SOC'], 
                DL['MTR_TFrtMtr_Nm'],DL['MTR_TRrMtr_Nm'],DL['TRSM_TrqWhl_Nm'],
                DL['FC_reqPower_W']/1000,DL['FC_actPower_W']/1000))

wd = wd.transpose()

print('Done.')
print('Exporting to: ',wdFile)

np.savetxt(wdFile,wd,fmt='%.3f',header=wd_header,delimiter=' ',comments='')

print('Completed.')
