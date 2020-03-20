LANG=$1
VERSION="20200220"

FILES="page.sql redirect.sql category.sql categorylinks.sql pagelinks.sql langlinks.sql"

for FILE_NAME in $FILES
do

	hdfs dfs -mkdir -p WikiDumps/$LANG

	WIKI_DUMP_NAME=${LANG}wiki-${VERSION}-${FILE_NAME}
	WIKI_DUMP_DOWNLOAD_URL=https://dumps.wikimedia.org/${LANG}wiki/${VERSION}/$WIKI_DUMP_NAME
	TEMP_FOLDER=~/NoSave/WikiDumps/$LANG

	# downad latest Wikipedia dump in chosen language
	echo "Downloading $WIKI_DUMP_NAME Wikipedia dump from $WIKI_DUMP_DOWNLOAD_URL.gz "
	wget -P $TEMP_FOLDER -c  $WIKI_DUMP_DOWNLOAD_URL.gz
	zcat $TEMP_FOLDER/$WIKI_DUMP_NAME.gz | bzip2 > $TEMP_FOLDER/$WIKI_DUMP_NAME.bz2
	
	hdfs dfs -put $TEMP_FOLDER/$WIKI_DUMP_NAME.bz2 WikiDumps/$LANG/
	
	rm $TEMP_FOLDER/$WIKI_DUMP_NAME*
	echo "Succesfully downloaded the latest $LG-language Wikipedia dump to $WIKI_DUMP_NAME"
done

