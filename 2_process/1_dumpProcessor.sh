SRC_DIR=$1
TGT_DIR=$2
DATE=$3
LANGUAGES=$4

for LANG in $LANGUAGES
do

	echo ""
	echo "-------------------------------------------------------------------------------------------------"
	echo ""	

	DUMP_PATH=$SRC_DIR/$DATE/$LANG
	OUT_PATH=$TGT_DIR/$DATE/$LANG
	PREFIX=${LANG}wiki-${DATE}

	hdfs dfs -rm -r $OUT_PATH
	
	echo ""
	echo "-------------------------------------------------------------------------------------------------"
	echo "DumpProcessor --dumpPath $DUMP_PATH --outputPath $OUT_PATH --namePrefix $PREFIX"	
	echo "-------------------------------------------------------------------------------------------------"
	echo ""

	time spark-submit --class ch.epfl.lts2.wikipedia.DumpProcessor --master 'yarn' --deploy-mode cluster --packages org.rogach:scallop_2.11:3.1.5 ~/Code/Scala/sparkwiki/target/scala-2.11/sparkwiki_2.11-0.11.0.jar --dumpPath $DUMP_PATH --outputPath $OUT_PATH --namePrefix $PREFIX &


	OTHER_LANG=${LANGUAGES/$LANG/$EMPTY}

        echo ""
        echo "----------------------------------------------------------------------------------------------------------------"
        echo "DumpParser --dumpPath $DUMP_PATH --outputPath $OUT_PATH/langlinks/dumps --languages $OTHER_LANG"
        echo "----------------------------------------------------------------------------------------------------------------"
        echo ""

        spark-submit --class ch.epfl.lts2.wikipedia.DumpParser --master 'yarn' --deploy-mode cluster --packages org.rogach:scallop_2.11:3.1.5 ~/Code/Scala/sparkwiki/target/scala-2.11/sparkwiki_2.11-0.11.0.jar --dumpFilePaths $DUMP_PATH/$PREFIX-langlinks.sql.bz2 --dumpType langlinks --outputPath $OUT_PATH/langlinks/dumps --languages $OTHER_LANG &


done
