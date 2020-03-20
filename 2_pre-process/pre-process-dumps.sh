DATE=$1
LANGUAGES="az en es fr"

for LANG in $LANGUAGES
do

	#if [ $LANG == "fr" ]
	#then

	hdfs dfs -rm -r WikiSpark/$LANG
        hdfs dfs -mkdir -p WikiSpark/$LANG/langlinks

	echo "-------------------------------------------------------------------------------------------------"
	echo "wikipedia.DumpProcessor --dumpPath WikiDumps/$LANG/ --outputPath WikiSpark/$LANG/ --namePrefix ${LANG}wiki-${DATE}"	
	echo "-------------------------------------------------------------------------------------------------"
	echo ""
	spark-submit --class ch.epfl.lts2.wikipedia.DumpProcessor --master 'yarn' --num-executors 4 --executor-memory 2g --driver-memory 2g --packages org.rogach:scallop_2.11:3.1.5,com.datastax.spark:spark-cassandra-connector_2.11:2.4.0 ~/Code/2_pre-process/sparkwiki/target/scala-2.11/sparkwiki_2.11-0.10.2.jar --dumpPath WikiDumps/$LANG/ --outputPath WikiSpark/$LANG/ --namePrefix ${LANG}wiki-${DATE}

	for toLang in $LANGUAGES
	do 
		
		if [ $toLang != $LANG ]
		then

			echo "----------------------------------------------------------------------------------------------------------------"
			echo "    wikipedia.DumpLangProcessor --dumpPath WikiDumps/$LANG/ --outputPath WikiSpark/$LANG/langlinks --namePrefix ${LANG}wiki-${DATE} --toLang $toLang"
			
			echo "----------------------------------------------------------------------------------------------------------------"
			spark-submit --class ch.epfl.lts2.wikipedia.DumpLangProcessor --master 'yarn' --num-executors 4 --executor-memory 2g --driver-memory 2g --packages org.rogach:scallop_2.11:3.1.5,com.datastax.spark:spark-cassandra-connector_2.11:2.4.0 ~/Code/2_pre-process/sparkwiki/target/scala-2.11/sparkwiki_2.11-0.10.2.jar --dumpPath WikiDumps/$LANG/ --outputPath WikiSpark/$LANG/langlinks/ --namePrefix ${LANG}wiki-${DATE} --toLang $toLang


		fi
	done
	#fi
done

	echo "----------------------------------------------------------------------------------------------------------------"
        echo "wikipedia.GraphParser --dumpPath WikiSpark --fromLang en --toLang az,es,fr"
        echo "----------------------------------------------------------------------------------------------------------------"

	spark-submit --class fr.lri.wikipedia.GraphParser --master 'yarn' --num-executors 4 --executor-memory 2g --driver-memory 2g --packages org.rogach:scallop_2.11:3.1.5 ~/Code/2_pre-process/sparkWikiGraph/target/scala-2.11/sparwikigraph_2.11-0.1.jar --dumpPath WikiSpark --fromLang en --toLangList az,es,fr

	echo ""
