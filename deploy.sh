#!/usr/bin/env bash

# TODO: incorporate this into CICD and remove the file



# Stop on any errors
set -e


# Make a scratch org
sfdx force:org:create \
 --definitionfile=config/project-scratch-def.json \
 --setalias=brettbarlow-dev \
 --targetdevhubusername=brettbarlow

# Make the community
sfdx force:community:create \
  --targetusername=brettbarlow-dev \
  --name=Home \
  --urlpathprefix="" \
  --templatename="Build Your Own (LWR)" \
  templateParams.AuthenticationType=UNAUTHENTICATED

# Deploy base metadata
sfdx force:source:deploy \
  --targetusername=brettbarlow-dev \
  --metadata=ApexClass,Layout,Flexipage,CustomObject,LightningComponentBundle,StaticResource,CustomTab,PermissionSet,ApexPage,AuraDefinitionBundle

# Deploy experience cloud metadata
sfdx force:source:deploy \
  --targetusername=brettbarlow-dev \
  --metadata=CustomSite,ExperienceBundle,NavigationMenu,Network,Profile