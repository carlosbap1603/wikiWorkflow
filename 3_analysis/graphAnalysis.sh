SRC_DIR=Wikipedia
DATE=20200401
k=$1
LANGUAGES=$2


echo ""
echo "-------------------------------------------------------------------------------------------------"
echo ""	

DUMP_PATH=$SRC_DIR/$DATE

echo ""
echo "-------------------------------------------------------------------------------------------------"
echo "GraphAnalyser --dumpPath $DUMP_PATH -languages $LANGUAGES"
echo "-------------------------------------------------------------------------------------------------"
echo ""

time spark-submit --class fr.lri.wikipedia.GraphAnalyser --master 'yarn' --num-executors 28 --executor-cores 3 --executor-memory 6g --driver-memory 6g --packages org.rogach:scallop_2.11:3.1.5 ~/Code/Scala/sparkwikiGraph/target/scala-2.11/sparwikigraph_2.11-0.1.jar --filesPath $DUMP_PATH --titleSearch Richard_Gerstl --langSearch en --k $k --languages $LANGUAGES
 
