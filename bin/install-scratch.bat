@echo OFF

rem Set parameters
set ORG_ALIAS=brettbarlow-scratch

@echo:
echo Installing scratch org (%ORG_ALIAS%)
@echo:

rem Install script
echo Cleaning previous scratch org...
cmd.exe /c sfdx force:org:delete ^
  --noprompt ^
  --targetusername=%ORG_ALIAS% 2>NUL
@echo:

echo Creating scratch org...
cmd.exe /c sfdx force:org:create ^
  --definitionfile=config/project-scratch-def.json ^
  --setalias=%ORG_ALIAS% ^
  --setdefaultusername
call :checkForError
@echo:

echo Creating Experience site...
cmd.exe /c sfdx force:community:create ^
  --targetusername=%ORG_ALIAS% ^
  --name=Home ^
  --urlpathprefix="" ^
  --templatename="Build Your Own (LWR)" ^
  templateParams.AuthenticationType=UNAUTHENTICATED
call :checkForError
@echo:

echo Sleeping 30s for Experience site deployment
timeout 30 > NUL
@echo:

echo Deploying base metadata...
cmd.exe /c sfdx force:source:deploy ^
  --targetusername=%ORG_ALIAS% ^
  --metadata=AuraDefinitionBundle,ApexClass,ApexTrigger,Flexipage,Layout,LightningComponentBundle,CustomObject,PermissionSet,StaticResource,CustomTab,SharingRules
call :checkForError
@echo:

echo Deploying Experience site metadata...
cmd.exe /c sfdx force:source:deploy ^
  --targetusername=%ORG_ALIAS% ^
  --metadata=ExperienceBundle,NavigationMenu,Network,ApexPage,Profile,CustomSite
call :checkForError
@echo:

echo Publishing Experience site...
cmd.exe /c sfdx force:community:publish ^
  --targetusername=%ORG_ALIAS% ^
  --name=Home
call :checkForError
@echo:

echo Assigning Permission Set...
cmd.exe /c sfdx force:user:permset:assign ^
  --targetusername=%ORG_ALIAS% ^
  --permsetname=Projects_User
call :checkForError
@echo:
cd %CD%/..

echo Importing sample data...
cmd.exe /c sfdx force:data:tree:import ^
  --targetusername=%ORG_ALIAS% ^
  --plan=data/Project__c-plan.json
call :checkForError
@echo:

echo Opening org...
cmd.exe /c sfdx force:org:open ^
  --targetusername=%ORG_ALIAS%
call :checkForError
@echo:

rem Report install success if no error
@echo:
if ["%errorlevel%"]==["0"] (
  echo Installation completed.
  @echo:
)

:: ======== FN ======
GOTO :EOF

rem Display error if the install has failed
:checkForError
if NOT ["%errorlevel%"]==["0"] (
    echo Installation failed.
    exit /b %errorlevel%
)