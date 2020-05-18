DUMP_PATH=$1
OUT_PATH=$2
LANGUAGES=$3



echo ""
echo "----------------------------------------------------------------------------------------------------------------"
echo "HashCodeParser --dumpPath $DUMP_PATH --outPath $OUT_PATH --languages $LANGUAGES"
echo "----------------------------------------------------------------------------------------------------------------"
echo ""


spark-submit --class fr.lri.wikipedia.parser.HashCodeParser --master 'yarn' --deploy-mode cluster --packages org.rogach:scallop_2.11:3.1.5,org.apache.spark:spark-avro_2.11:2.4.5 ~/Code/Scala/sparkwikiGraph/target/scala-2.11/sparwikigraph_2.11-0.1.jar --dumpPath $DUMP_PATH --outputPath $OUT_PATH --languages $LANGUAGES & 
