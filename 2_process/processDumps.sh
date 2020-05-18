SRC_DIR="Dumps"
TGT_DIR="Wikipedia"
DATE="20200401"
LANGUAGES="az de en es fr it ja pl pt zh"

#./1_dumpProcessor.sh $SRC_DIR $TGT_DIR $DATE "$LANGUAGES" &
./2_hashCodeParser.sh $TGT_DIR/$DATE $TGT_DIR/$DATE/HashCoded "$LANGUAGES" &
#./3_opt_langLinkParser.sh $TGT_DIR/$DATE/HashCoded "$LANGUAGES"
