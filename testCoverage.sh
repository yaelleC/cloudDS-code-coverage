#!/bin/bash
set -euxo

PLUGINS=~/Documents/Projects/plugins/
GRAFANA=~/Documents/Projects/grafana
COV_FILE=~/Documents/Projects/cloudDS-code-covrage/testcoverage.md
COV_FILE_TMP=~/Documents/Projects/cloudDS-code-covrage/coverage.txt

write_to_cov()
{
    TO_WRITE=$1
    echo $1 >> "${COV_FILE}"
}

write_be_coverage()
{
    REPO=$1
    go test ./... -coverprofile cover.out 
    COVERAGE=$(go tool cover -func cover.out | grep total: | awk '{print $NF}')
    write_to_cov "${REPO} = ${COVERAGE}" 
}

write_fe_coverage()
{
    REPO=$1
    COVERAGE=$(yarn test:coverage | grep 'All files' | awk '{print $10}')
    write_to_cov "${REPO} = ${COVERAGE}%" 
}
write_fe_core_coverage()
{
    REPO=$1
    CODE_PATH=$2
    COVERAGE=$(grep ${CODE_PATH} "${COV_FILE_TMP}" | head -1 | awk '{print $9}')
    write_to_cov "${REPO} = ${COVERAGE}%"
}

write_to_cov "## $(date)" 
write_to_cov "### Frontend" 

cd "${GRAFANA}"
# git checkout main
# git pull
yarn test:coverage .> "${COV_FILE_TMP}"

write_fe_core_coverage 'CloudWatch' public/app/plugins/datasource/cloudwatch
write_fe_core_coverage 'Cloud Monitoring' public/app/plugins/datasource/cloud-monitoring
write_fe_core_coverage 'Azure Monitor' public/app/plugins/datasource/grafana-azure-monitor-datasource

cd $PLUGINS;
for d in */ ; do
    cd $d
    # git checkout main
    # git pull
    write_fe_coverage $d
    cd $PLUGINS
done

write_to_cov "### Backend" 

cd ${GRAFANA}/pkg/tsdb/cloudwatch/
    write_be_coverage 'CloudWatch'
cd ${GRAFANA}/pkg/tsdb/cloudmonitoring/
    write_be_coverage 'Cloud Monitoring'  
cd ${GRAFANA}/pkg/tsdb/azuremonitor/
    write_be_coverage 'Azure Monitor' 


cd $PLUGINS;
for d in */ ; do
    cd $d
    write_be_coverage $d
    cd $PLUGINS
done


