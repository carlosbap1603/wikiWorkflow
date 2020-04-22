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

        OTHER_LANG=${LANGUAGES/$LANG/$EMPTY}

        echo ""
        echo "----------------------------------------------------------------------------------------------------------------"
        echo "DumpParser --dumpPath $DUMP_PATH --outputPath $OUT_PATH/langlinks/dumps --languages $OTHER_LANG"
        echo "----------------------------------------------------------------------------------------------------------------"
        echo ""

        spark-submit --class ch.epfl.lts2.wikipedia.DumpParser --master 'yarn' --deploy-mode cluster --num-executors 28 --executor-cores 3 --executor-memory 7g --driver-memory 7g --packages org.rogach:scallop_2.11:3.1.5,com.datastax.spark:spark-cassandra-connector_2.11:2.4.0 ~/Code/Scala/sparkwiki/target/scala-2.11/sparkwiki_2.11-0.11.0.jar --dumpFilePaths $DUMP_PATH/$PREFIX-langlinks.sql.bz2 --dumpType langlinks --outputPath $OUT_PATH/langlinks/dumps --languages $OTHER_LANG &

done
