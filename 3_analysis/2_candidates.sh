SRC_DIR=Wikipedia
DATE=20200401
STEP=$1
LANGUAGES=$2
#"az en es fr de it pl pt"


echo ""
echo "-------------------------------------------------------------------------------------------------"
echo ""	

DUMP_PATH=$SRC_DIR/$DATE/HashCoded

echo ""
echo "-------------------------------------------------------------------------------------------------"
echo "GraphCandidates --dumpPath $DUMP_PATH -languages $LANGUAGES"
echo "-------------------------------------------------------------------------------------------------"
echo ""

time spark-submit --class fr.lri.wikipedia.graph.GraphCandidates --master 'yarn' --deploy-mode client --packages org.rogach:scallop_2.11:3.1.5,org.apache.spark:spark-avro_2.11:2.4.5 ~/Code/Scala/sparkwikiGraph/target/scala-2.11/sparwikigraph_2.11-0.1.jar --dumpPath $DUMP_PATH --step $STEP --titleSearch Richard_Gerstl --langSearch en --languages $LANGUAGES
 
