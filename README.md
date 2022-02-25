# Code coverage

## Prerequisites

1. Clone Grafana and update `testCoverage.sh` the `GRAFANA` variable with the correct path
2. Clone external plugins to monitor (to date: Athena, ADX, Redshift, Timestream, X-Ray) and update `testCoverage.sh` the `PLUGINS` variable with the correct path


## Running the script

_Note: To make sure you generate the latest cverage, either manually pull the latest mains or uncomment the commands that do so in the script file (you should not have uncommitted changes)_

Run `./testCoverage.sh` in a terminal

## Update test coverage for the Grafana Dashboard to pick up

1. Copy the values of test coverage percentages into: 
    * Frontend: https://docs.google.com/spreadsheets/d/1cHwmD8A1Z69QExNlHlJHiydHT9B6LzhJ_jGbC3Fur2k/edit#gid=1828109158
    * Backend: https://docs.google.com/spreadsheets/d/1cHwmD8A1Z69QExNlHlJHiydHT9B6LzhJ_jGbC3Fur2k/edit#gid=197179070

2. Check the dashboard [https://ops.grafana.net/d/3kxjo4fnz/cloud-datasource-unit-test-coverage](https://ops.grafana.net/d/3kxjo4fnz/cloud-datasource-unit-test-coverage) to see if values are updated. 