TEMP=~/NoSave/Dumps
HDFS_DIR=Dumps
LANGUAGES="az en es fr de it pl pt"
DATE=20200401
for LANG in $LANGUAGES
do
	
	./downloadDump.sh $TEMP	$HDFS_DIR $LANG $DATE

done
