# Azure DevOps - DAtabricks Release sync tool

The pupose of the tool is to keep in sync the Release data from Azure DevOPs with the one in Azure Databircks.
When building a DataOps pipline Release artifacts from Azure DevOps (Build or release pipline) are deployed in Azure Databricks. 
Every 24 hours Azure DevOps remove release/build artifacts based on the defiled retention policies.
This tool checks the list of avaliable releases for a specific definition and then verifyies if they are present in Azure Databricks specific folder. If there are differences the obsilite artifacts are removed from Databricks. 

# Tools used
- Azure CLI
- Azure DevOps CLI
- Databricks CLI
- Databircks Workspace CLI

# Secrets and Auth
All configuration data is loaded from a properties file under __secrets/env.properties__
Used properties are:
- AZDO_PAT=<Azure DevOps PAT token>
- AZDO_ORG=<Azure DevOps Organization URL>
- AZDO_PRJ=<Azure DevOps project name>
- AZDO_RD_NAME=<Azure DevOps Release definition name>
- DBCK_TOKEN=<Databricks Auth token>
- DBCK_URL=<Azure DAtabricks URL>

# TIPs

## Azure DevOps authentication
If you do not want to use Azure DevOPs PAT token you can use Azue CLI login command
- az login
Once you have autneticated sucessfuly you can skip the Azure DevOps PAT authetnication.

## Runnin the tool
The tool is craeted as a bash so that it can be ran from any environemnt.
If you would like to runni it regularly, you can craete Azure DevOps Pipline with a BASH script task and scheduled trigger. In case you use this approach there is no need to use Azrue DevOPs authetnication in the pipline. 