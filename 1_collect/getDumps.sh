TEMP=~/NoSave/Dumps
HDFS_DIR=Dumps
LANGUAGES="az de en es fr it ja pl pt zh"
DATE=20200401
for LANG in $LANGUAGES
do
	
	./downloadDump.sh $TEMP	$HDFS_DIR $LANG $DATE

done
