SRC_DIR="Dumps"
TGT_DIR="Wikipedia"
DATE="20200401"
#LANGUAGES="az en es fr de it pl pt"
LANGUAGES="az"

./1_dumpProcessor.sh $SRC_DIR $TGT_DIR $DATE "$LANGUAGES"
#./2_langLinkExtractor.sh $SRC_DIR $TGT_DIR $DATE "$LANGUAGES"
#./3_hashCodeParser.sh $TGT_DIR/$DATE $TGT_DIR/$DATE/HashCoded "$LANGUAGES"
#./4_langLinkParser.sh $TGT_DIR/$DATE/HashCoded "$LANGUAGES"
