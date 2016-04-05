echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'$(date)'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo "backup started at '$(date)'"
cd /pliro
python backup_glacier.py
