# Cryd Network Backup Tool for Cloud-Tech

#echo "#####################"
echo " #Backup tool started#"
#echo "#####################"

# Settings

Network=True
Local=False
ConfigFoler=True
ConfigFile=True


# variables

PRINTER_CFG=$HOME/klipper_config/printer.cfg
klipper_cfg_loc=$HOME/klipper_config/
BACKUP_DIR_HOME=$HOME/backup/Vyper/
Cloud_Remote=nextcloud

#check_for_backup_dir_home
  if [ ! -d $BACKUP_DIR_HOME ]; then
    echo "Create backup_home directory ..."
    mkdir -p $BACKUP_DIR_HOME && echo -e "Directory created!"
  fi

# Network Backups
if [ "$Network" = "True" ]; 
  then
    if [ "$ConfigFile" = "True" ];
      then
        echo "Timestamp: "$(date)""
        echo "--------------"
        echo "Create Network Backup of printer.cfg ..."
        #rsync -avH $PRINTER_CFG $BACKUP_CFG_NET/printer.cfg.$(date +'%Y-%m-%d-%H-%M') && echo -e "Network Backup of printer.cfg complete!"
        rclone copy lokal:$PRINTER_CFG nextcloud:backup_vyper/Printer_CFG -v --no-check-certificate
        echo -e "Network Backup of printer.cfg complete!"
      else
        echo  "No printer.cfg found! Skipping backup ..."
    fi
    if [ "$ConfigFoler" = "True" ];
      then
        echo "Timestamp: "$(date)""
        echo "--------------"
        echo "Create Network Backup of Config Folder ..."
        #rclone mkdir nextcloud:backup_vyper/$(date +'%d-%m-%Y-%H-%M') -vv --no-check-certificate
        rclone copy lokal:$klipper_cfg_loc nextcloud:backup_vyper/$(date +'%d-%m-%Y-%H-%M')/ -v --no-check-certificate
        #rsync -vr $klipper_cfg_loc $BACKUP_DIR_NET/klipper_config_$(date +'%Y-%m-%d-%H-%M')/ && echo -e "Network Backup of CFG Folder complete!"
        echo -e "Network Backup of CFG Folder complete!"
        else
        echo "No config directory found! Skipping backup ..."
      fi
  else
    echo "No Network Backup Selected! Skipping backup ..."
fi
# Local Backup
if [ "$Local" = "True" ]; 
  then
    if [ "$ConfigFile" = "True" ];
      then
        echo "Timestamp: "$(date)""
        echo "--------------"
        echo "Create Local Backup of printer.cfg ..."
        rsync -avH $PRINTER_CFG $BACKUP_DIR_HOME/printer.cfg.$(date +'%Y-%m-%d-%H-%M').backup && echo -e "Local Backup of printer.cfg complete!"
      else
        echo  "No printer.cfg found! Skipping backup ..."
    fi
    if [ "$ConfigFoler" = "True" ];
      then
        echo "Timestamp: "$(date)""
        echo "--------------"
        echo "Create Local Backup of Config Folder ..."
        rsync -vr $klipper_cfg_loc $BACKUP_DIR_HOME/klipper_config_$(date +'%Y-%m-%d-%H-%M')/ && echo -e "Local Backup of CFG Folder complete!"
        else
        echo "No config directory found! Skipping backup ..."
    fi
  else
    echo "No Local Backup Selected! Skipping backup ..."
fi


echo "######################"
echo "#Backup tool finished#"
echo "######################"

