eval "javac Demo/*.java"
read -rsp $'Press enter to continue...\n'

eval "java Demo.CreateStorageMain"
eval "java Demo.ScanDataAndPopulateRelation"
read -rsp $'Press enter to continue...\n'
eval "java Demo.PrintRelation1"
read -rsp $'Press enter to continue...\n'
eval "java Demo.ProcessRelation1"
read -rsp $'Press enter to continue...\n'
eval "java Demo.PrintRelation2"
read -rsp $'Press enter to continue...\n'