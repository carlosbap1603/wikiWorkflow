DUMP_PATH=$1
LANGUAGES=$2

echo ""
echo "----------------------------------------------------------------------------------------------------------------"
echo "LangLinkParser --dumpPath $DUMP_PATH --languages $LANGUAGES"
echo "----------------------------------------------------------------------------------------------------------------"
echo ""

spark-submit --class fr.lri.wikipedia.parser.LangLinkParser --master 'yarn' --num-executors 28 --executor-cores 3 --executor-memory 7g --driver-memory 7g --packages org.rogach:scallop_2.11:3.1.5 ~/Code/Scala/sparkwikiGraph/target/scala-2.11/sparwikigraph_2.11-0.1.jar --dumpPath $DUMP_PATH --languages $LANGUAGES &

echo ""
