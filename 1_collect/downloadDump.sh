TEMP=$1
HDFS_DIR=$2
LANG=$3
DATE=$4


FILES=#"page.sql redirect.sql category.sql categorylinks.sql pagelinks.sql langlinks.sql"
FILES="pagelinks.sql langlinks.sql"

hdfs dfs -mkdir -p $HDFS_DIR/$DATE/$LANG

for FILE_NAME in $FILES
do

	WIKI_DUMP_NAME=${LANG}wiki-$DATE-$FILE_NAME
	WIKI_DUMP_DOWNLOAD_URL=https://dumps.wikimedia.org/${LANG}wiki/$DATE/$WIKI_DUMP_NAME
	TEMP_FOLDER=$TEMP/$DATE/$LANG

	# downad latest Wikipedia dump in chosen language
	echo "Downloading $WIKI_DUMP_NAME Wikipedia dump from $WIKI_DUMP_DOWNLOAD_URL.gz "
	mkdir -p $TEMP_FOLDER
	wget -P $TEMP_FOLDER -c  $WIKI_DUMP_DOWNLOAD_URL.gz -o $TEMP_FOLDER/$WIKI_DUMP_NAME.out
	zcat $TEMP_FOLDER/$WIKI_DUMP_NAME.gz | bzip2 > $TEMP_FOLDER/$WIKI_DUMP_NAME.bz2
	
	hdfs dfs -put $TEMP_FOLDER/$WIKI_DUMP_NAME.bz2 $HDFS_DIR/$DATE/$LANG/
	
	rm $TEMP_FOLDER/$WIKI_DUMP_NAME.gz
	#rm $TEMP_FOLDER/$WIKI_DUMP_NAME.bz2
	echo "Succesfully downloaded the latest $LANG-language Wikipedia dump to $WIKI_DUMP_NAME"
done

