SRC_DIR=Wikipedia
DATE=20200401
STEP=$1
ARTICLE=$2
LANGUAGES=$3
DEPLOY=$4
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

time spark-submit --class fr.lri.wikipedia.graph.GraphCandidateNet --master 'yarn' --deploy-mode $DEPLOY --packages org.rogach:scallop_2.11:3.1.5,org.apache.spark:spark-avro_2.11:2.4.5,org.apache.commons:commons-math3:3.5 ~/Code/Scala/missingLinks/target/scala-2.11/missinglinks_2.11-0.1.jar --dumpPath $DUMP_PATH --step $STEP --centrality RPR --titleSearch $ARTICLE --languages $LANGUAGES  
