(
cd "$(dirname "$(readlink -f "$0")")/"

SOURCE=$(<"Tweak.xm")
INTEGRATIONS=$(cat integrations/*.xm)
echo "${SOURCE//\/\/__CTPIOS_PREPROCESSOR_SED_HERE/$INTEGRATIONS}" > "Tweak_processed.xm"
)
