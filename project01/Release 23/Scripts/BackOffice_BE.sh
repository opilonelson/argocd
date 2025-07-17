
#!/bin/bash
#clear console
clear

#VARIABLES
LOG_FILE="BackOffice_BE.log"
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

#Load script variables
source $SCRIPT_DIR/"conf.ini"
source $SCRIPT_DIR/"declares.sh"

## SET Files to deploy
declare -A DeployFiles

DeployFiles[D_MGW]=$D_MGW
DeployFiles[D_SDK]=$D_SDK
DeployFiles[D_MCS]=$D_MCS

echo ""
echo "Check logs at $LOG_PATH/$LOG_FILE"
echo ""
echo "For rollback check Backups files at $BACKUP_PATH or run BackOffice_BE-Rollback.sh script"
echo ""

echo "Starting deploying backend end files"  | tee $LOG_PATH/$LOG_FILE
echo ""
######################### BEGIN OF INSTRUCTIONS ##############################
# Mobile Gateway
if  [ ${DeployFiles[D_MGW]} -eq 1 ]; then
  echo $(date '+%d/%m/%Y %H:%M:%S')" > \cp $RELEASE_PATH/BackOfficeBE/$V_MOBILE_GATEWAY $TOMCAT_PATH/webapps/$F_MOBILE_GATEWAY" | tee -a $LOG_PATH/$LOG_FILE >/dev/null
  RESULT=$(\cp $RELEASE_PATH/BackOfficeBE/$V_MOBILE_GATEWAY $TOMCAT_PATH/webapps/$F_MOBILE_GATEWAY 2>&1)


  component_result  $? $V_MOBILE_GATEWAY "$TOMCAT_PATH/webapps/$F_MOBILE_GATEWAY";
fi

# SDK
if  [ ${DeployFiles[D_SDK]} -eq 1 ]; then
  echo $(date '+%d/%m/%Y %H:%M:%S')" > \cp $RELEASE_PATH/BackOfficeBE/$V_SDK $TOMCAT_PATH/webapps/$F_SDK" | tee -a $LOG_PATH/$LOG_FILE >/dev/null
  RESULT=$(\cp $RELEASE_PATH/BackOfficeBE/$V_SDK $TOMCAT_PATH/webapps/$F_SDK 2>&1)


  component_result  $? $V_SDK "$TOMCAT_PATH/webapps/$F_SDK";
fi

# Mpesa Configuration
if  [ ${DeployFiles[D_MCS]} -eq 1 ]; then
  echo $(date '+%d/%m/%Y %H:%M:%S')" > \cp $RELEASE_PATH/BackOfficeBE/$V_MPESACONFIGURATIONSERVER $TOMCAT_PATH/webapps/$F_MPESACONFIGURATIONSERVER" | tee -a $LOG_PATH/$LOG_FILE >/dev/null
  RESULT=$(\cp $RELEASE_PATH/BackOfficeBE/$V_MPESACONFIGURATIONSERVER $TOMCAT_PATH/webapps/$F_MPESACONFIGURATIONSERVER 2>&1)


  component_result  $? $V_MPESACONFIGURATIONSERVER "$TOMCAT_PATH/webapps/$F_MPESACONFIGURATIONSERVER";
fi

echo -e "${RESET_COLOR}"
echo "Deploy Completed" | tee -a $LOG_PATH/$LOG_FILE
echo ""You have mail in /var/spool/mail/root
