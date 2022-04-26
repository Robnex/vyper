# Cryd Network Backup Tool Version 3

#echo "#####################"
echo "#Backup tool started#"
#echo "#####################"

# Settings

Network=True
Local=True
ConfigFoler=True
ConfigFile=True


# variables

BACKUP_DIR_NET=/mnt/backup/Vyper/
PRINTER_CFG=$HOME/klipper_config/printer.cfg
klipper_cfg_loc=$HOME/klipper_config/
BACKUP_DIR_HOME=$HOME/backup/Vyper/
BACKUP_CFG_NET=/mnt/backup/Vyper/


#check_for_backup_dir
  if [ ! -d $BACKUP_DIR_NET ]; then
    echo "Create backup directory ..."
    sudo mkdir -p $BACKUP_DIR_NET && sudo chown pi:pi $BACKUP_DIR_NET && echo -e "Directory created!"
  fi

#check_for_backup_dir_home
  if [ ! -d $BACKUP_DIR_HOME ]; then
    echo "Create backup_home directory ..."
    mkdir -p $BACKUP_DIR_HOME && echo -e "Directory created!"
  fi

#check_for_backup_dir_home
  if [ ! -d $BACKUP_DIR_CFG ]; then
    echo "Create backup_home directory ..."
    mkdir -p $BACKUP_DIR_CFG && echo -e "Directory created!"
  fi

# Network Backups
if [ "$Network" = "True" ]; 
  then
    if [ "$ConfigFile" = "True" ];
      then
        echo "Timestamp: "$(date)""
        echo "--------------"
        echo "Create Network Backup of printer.cfg ..."
        rsync -avH $PRINTER_CFG $BACKUP_CFG_NET/printer.cfg.$(date +'%Y-%m-%d-%H-%M') && echo -e "Network Backup of printer.cfg complete!"
      else
        echo  "No printer.cfg found! Skipping backup ..."
    fi
    if [ "$ConfigFoler" = "True" ];
      then
        echo "Timestamp: "$(date)""
        echo "--------------"
        echo "Create Network Backup of Config Folder ..."
        rsync -vr $klipper_cfg_loc $BACKUP_DIR_NET/klipper_config_$(date +'%Y-%m-%d-%H-%M')/ && echo -e "Network Backup of CFG Folder complete!"
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


#backup_printer_cfg
#  if [ -f $PRINTER_CFG ]; then
#    echo "Timestamp: "$(date)""
#    echo "--------------"
#    echo "Create backup of printer.cfg ..."
#    rsync -avH $PRINTER_CFG $BACKUP_DIR_HOME/printer.cfg.$(date +'%Y-%m-%d-%H-%M').backup
#    rsync -avH $PRINTER_CFG $BACKUP_DIR_NET/printer.cfg.$(date +'%Y-%m-%d-%H-%M') && echo -e "Backup complete!"
#  else
#    echo  "No printer.cfg found! Skipping backup ..."
#  fi


#backup_klipper_config_folder
#  if [ -d "$klipper_cfg_loc" ]; then
#    #echo "Timestamp:"$(date)""
#    echo "-------------------------"
#    echo "Create backup of the Klipper config directory ..."
#    mkdir -p $BACKUP_DIR_HOME/klipper_config/$(date +'%Y-%m-%d-%H-%M')/
#    cp -r $klipper_cfg_loc $BACKUP_DIR_HOME/klipper_config/$(date +'%Y-%m-%d-%H-%M')/ 
#    rsync -vr $klipper_cfg_loc $BACKUP_DIR_NET/klipper_config_$(date +'%Y-%m-%d-%H-%M')/
#    echo "Backup complete!"
#    echo
#  else
#    echo "No config directory found! Skipping backup ..."
#    echo
#  fi

echo "######################"
echo "#Backup tool finished#"
echo "######################"

