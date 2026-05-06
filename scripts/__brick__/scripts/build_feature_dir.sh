# run this command from the root/scripts directory
cd ../lib/ || exit
echo "Name of the feature?"
read -r feature
mkdir "$feature"
cd "$feature" || exit
mkdir "abstracts"
mkdir "apis"
mkdir "constants"
mkdir "dtos"
mkdir "enums"
mkdir "extensions"
mkdir "forms"
mkdir "globals"
mkdir "mixins"
mkdir "models"
mkdir "services"
mkdir "views"
mkdir "widgets"
