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
  --metadata=ApexClass,Layout,Flexipage,CustomObject,LightningComponentBundle,StaticResource,CustomTab,PermissionSet,ApexPage,AuraDefinitionBundle
echo ""

echo "Deploying Experience site metadata..."
sfdx force:source:deploy \
  --targetusername="${ORG_ALIAS}" \
  --metadata=CustomSite,ExperienceBundle,NavigationMenu,Network,Profile
echo ""

echo "Publishing Experience site..."
sfdx force:community:publish \
  --targetusername="${ORG_ALIAS}" \
  --name=Home
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
