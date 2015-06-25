import pandas as pd
import sys  
import savReaderWriter

reload(sys)  
sys.setdefaultencoding('utf8')
site=['pku6', 'hlg', 'xian', 'wuhan', 'zmd' ,'xinxiang_ge', 'xinxiang_se', 'xinxiang_all']
for s in site:
    data1 = pd.read_excel('C:/Users/thinkingfly/Desktop/new/multi_sites_final.xlsx', s, index_col=None, na_values=['NA'])
    data1.bh.apply(lambda x: x.replace('-','_')).to_csv('C:/Users/thinkingfly/Desktop/new/'+s+'_2.txt',index=False)

data2 = pd.read_excel('C:/Users/thinkingfly/Desktop/new/CRF_NCF_ALL_new.xlsx', 'Sheet1', index_col='bh', na_values=['NA'])

a=data2.loc[data1.bh.apply(lambda x: x.replace('-','_')[0:10])]
data3=pd.concat([data1,a])
data3=data3[list(data1.columns)+list(a.columns)]
data3.to_excel('C:/Users/thinkingfly/Desktop/new/output.xlsx',header=True,index=False)
f='C:/Users/thinkingfly/Desktop/new/crf_wh.sav'
r=  savReaderWriter.SavReader(f,ioUtf8=True,ioLocale='utf_8',rawMode=True,returnHeader=True)
r.close()
