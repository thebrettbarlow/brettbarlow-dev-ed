#!/bin/bash
SCRIPT_PATH=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
cd $SCRIPT_PATH/..

# Set parameters
ORG_ALIAS="brettbarlow-scratch"

echo ""
echo "Installing scratch org ($ORG_ALIAS)"
echo ""

# Install script
echo "Cleaning previous scratch org..."
sfdx force:org:delete \
  --noprompt \
  --targetusername="${ORG_ALIAS}" &> /dev/null
echo ""

echo "Creating scratch org..."
sfdx force:org:create \
  --definitionfile=config/project-scratch-def.json \
  --setalias="${ORG_ALIAS}" \
  --setdefaultusername
echo ""

echo "Creating Experience site..."
sfdx force:community:create \
  --targetusername="${ORG_ALIAS}" \
  --name=Home \
  --urlpathprefix="" \
  --templatename="Build Your Own (LWR)" \
  templateParams.AuthenticationType=UNAUTHENTICATED
echo ""

echo "Sleeping 30s for Experience site deployment"
sleep 30
echo ""

echo "Deploying base metadata..."
sfdx force:source:deploy \
  --targetusername="${ORG_ALIAS}" \
  --metadata=AuraDefinitionBundle,ApexClass,Flexipage,Layout,LightningComponentBundle,CustomObject,PermissionSet,StaticResource,CustomTab
echo ""

echo "Deploying Experience site metadata..."
sfdx force:source:deploy \
  --targetusername="${ORG_ALIAS}" \
  --metadata=ExperienceBundle,NavigationMenu,Network,ApexPage,Profile,CustomSite
echo ""

echo "Publishing Experience site..."
sfdx force:community:publish \
  --targetusername="${ORG_ALIAS}" \
  --name=Home
echo ""

echo "Assigning Permission Set..."
sfdx force:user:permset:assign \
  --targetusername="${ORG_ALIAS}" \
  --permsetname=Projects_User
echo ""

echo "Importing sample data..."
sfdx force:data:tree:import \
  --targetusername="${ORG_ALIAS}" \
  --plan=data/Project__c-plan.json
echo ""

echo "Opening org..." && \
sfdx force:org:open \
  --targetusername="${ORG_ALIAS}"
echo ""

EXIT_CODE="$?"
echo ""

# Check exit code
echo ""
if [ "$EXIT_CODE" -eq 0 ]; then
  echo "Installation completed."
else
    echo "Installation failed."
fi
exit $EXIT_CODE
