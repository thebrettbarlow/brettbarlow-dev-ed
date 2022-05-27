@IsTest(SeeAllData = true)
public with sharing class LightningLoginFormControllerTest {

 @IsTest
 static void LightningLoginFormControllerInstantiation() {
  LightningLoginFormController controller = new LightningLoginFormController();
  System.assertNotEquals(controller, null);
 }

 @IsTest
 static void testIsUsernamePasswordEnabled() {
  List<Organization> organizations = [SELECT IsSandbox FROM Organization];
  if (organizations.size() != 1) {
    throw new UnexpectedException('Expected 1 Organization record. Found ' + organizations.size());
  }
  // Username / Password login is enabled in sandboxes and scratch orgs
  Boolean enabled = organizations[0].IsSandbox;
  
  System.assertEquals(enabled, LightningLoginFormController.getIsUsernamePasswordEnabled());
 }

 @IsTest
 static void testIsSelfRegistrationEnabled() {
  System.assertEquals(false, LightningLoginFormController.getIsSelfRegistrationEnabled());
 }

 @IsTest
 static void testGetSelfRegistrationURL() {
  System.assertEquals(null, LightningLoginFormController.getSelfRegistrationUrl());
 }
    
 @IsTest
 static void testGetForgotPasswordURL() {
  System.assertEquals(null, LightningLoginFormController.getForgotPasswordUrl());
 }

 @IsTest
 static void testAuthConfig() {
  Auth.AuthConfiguration authConfig = LightningLoginFormController.getAuthConfig();
  System.assertNotEquals(null, authConfig);
 }
}