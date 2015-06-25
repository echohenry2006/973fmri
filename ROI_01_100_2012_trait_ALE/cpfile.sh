mkdir temp
site="PKU6 HLG ZMD XIAN XX_GE XX_SE WUHAN"
for file in $site
do
echo $file
mkdir temp/$file
cp $file/*.csv temp/$file
done
