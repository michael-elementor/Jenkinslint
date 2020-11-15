#
JENKINS_URL=http://localhost:8081

# # The following parameters are supported:
# # JENKINS_SERVER= # Server name
# # JENKINS_SSH_PORT=8022 # When set, use SSH validation
# # JENKINS_UNSAFE_SSL=TRUE # Disable certificate validation
# # JENKINS_URL= http://localhost:8081
#
# # These are defaults and can easily be overwritten by using the INIFILE
# JENKINS_SERVER=ci-jenkins.control.elementor.link
# JENKINS_URL=https://${JENKINS_SERVER}
#
# # Search in the git root for the INIFILE, if it's a git repository
# FULLPATH=$(git rev-parse --show-toplevel 2>/dev/null)
# if [[ -n "${FULLPATH}" ]]; then
#     INIFILE="${FULLPATH}/${INIFILE}"
#     # Ensure that this file can be executed from anywhere in the git repository
#     pushd "${FULLPATH}" &>/dev/null || true
# fi
#

JENKINS_FILE=${1}
if [ ! -f "${JENKINS_FILE}" ]; then
  echo "Could not find file [${JENKINS_FILE}]"
  exit 1
else
echo "Validating ${JENKINS_FILE}"
fi

show_settings(){
    # Show currently used settings
    echo
    echo "Current values: JENKINS_SERVER=${JENKINS_SERVER}"
    echo
}
#
web_validation(){
  JENKINS_CRUMB=$(curl -s -m 5 "$JENKINS_URL/crumbIssuer/api/xml?xpath=concat(//crumbRequestField,\":\",//crumb)")
  return=$?
  if [ $return -ne 0 ]; then
    echo "Could not connect to $JENKINS_URL"
    # # 28 = timeout exceeded
    show_settings
    exit 1
  fi
  if [[ $JENKINS_CRUMB =~ "login" ]]; then
    echo "Access denied - The web validator at ${JENKINS_URL} requires anonymous read access"
    show_settings
    exit 1
  fi
  result=$(curl -sX POST -H "${JENKINS_CRUMB}" -F "jenkinsfile=<${JENKINS_FILE}" "${JENKINS_URL}/pipeline-model-converter/validate")
}
#
validate(){
  if [[ $result =~ Errors ]]; then
    echo "$result"
    exit 1
  else
    echo "$result"
    exit 0
  fi
}

web_validation
validate


# curl (REST API)
# Assuming "anonymous read access" has been enabled on your Jenkins instance.
# JENKINS_CRUMB is needed if your Jenkins controller has CRSF protection enabled as it should
# JENKINS_CRUMB=`curl "$JENKINS_URL/crumbIssuer/api/xml?xpath=concat(//crumbRequestField,\":\",//crumb)"`
# curl -X POST -H $JENKINS_CRUMB -F "jenkinsfile=<Jenkinsfile" $JENKINS_URL/pipeline-model-converter/validate
