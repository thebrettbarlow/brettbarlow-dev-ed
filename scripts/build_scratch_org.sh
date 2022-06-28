#!/bin/bash
SCRIPT_PATH=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
cd $SCRIPT_PATH/..

EXPERIENCE_CLOUD_SITE="Home"
TARGET_USERNAME="brettbarlow-scratch"

echo ""
echo "Building Scratch Org ($TARGET_USERNAME)"
echo ""

echo "Cleaning previous Scratch Org..."
sfdx force:org:delete \
  --noprompt \
  --targetusername="${TARGET_USERNAME}" &> /dev/null
echo ""

echo "Creating Scratch Org..."
sfdx force:org:create \
  --definitionfile=config/project-scratch-def.json \
  --setalias="${TARGET_USERNAME}" \
  --setdefaultusername
echo ""

echo "Creating Experience Cloud Site..."
sfdx force:community:create \
  --name="${EXPERIENCE_CLOUD_SITE}" \
  --urlpathprefix="" \
  --templatename="Build Your Own (LWR)" \
  templateParams.AuthenticationType=UNAUTHENTICATED
echo ""

echo "Sleeping 30s for Experience Cloud Site deployment"
sleep 30
echo ""

echo "Deploying Base Metadata..."
sfdx force:source:deploy \
  --metadata=AuraDefinitionBundle,ApexClass,ApexTrigger,Flexipage,Layout,LightningComponentBundle,CustomObject,PermissionSet,StaticResource,CustomTab,SharingRules
echo ""

echo "Deploying Experience Cloud Site Metadata..."
sfdx force:source:deploy \
  --metadata=ExperienceBundle,NavigationMenu,Network,ApexPage,Profile,CustomSite
echo ""

echo "Assigning Permission Sets..."
sfdx force:user:permset:assign \
  --permsetname=Projects_User
sfdx force:user:permset:assign \
  --permsetname=Resume_User
echo ""

echo "Importing sample data..."
sfdx force:data:tree:import \
  --plan=data/Project__c-plan.json
echo ""

echo "Opening org..." && \
sfdx force:org:open
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
