public with sharing class ResumeSelector {
  @AuraEnabled(cacheable=true)
  public static Id getResumeIdByName(String resumeName) {
    List<Resume__c> resumes = [
      SELECT Id
      FROM Resume__c
      WHERE Name = :resumeName
    ];
    if (resumes.size() > 1) {
      throw new UnexpectedException(
        'Multiple resumes found with the same name (' +
        resumeName +
        '). This confuses the c-resume-container because it does not know which resume to show.'
      );
    }

    return resumes.size() == 1 ? resumes[0].Id : null;
  }

  @AuraEnabled(cacheable=true)
  public static List<Id> getResumeEntryIds(Id resumeId, String type) {
    List<Id> resumeEntryIds = new List<Id>();
    for (Resume_Entry__c resumeEntry : [
      SELECT Id
      FROM Resume_Entry__c
      WHERE Resume__c = :resumeId AND Type__c = :type
      ORDER BY From__c DESC
    ]) {
      resumeEntryIds.add(resumeEntry.Id);
    }

    return resumeEntryIds;
  }

  @AuraEnabled(cacheable=true)
  public static String getUniqueSkillsFromResumeEntries(Id resumeId) {
    Set<String> skills = new Set<String>();
    for (Resume_Entry__c resumeEntry : [
      SELECT Skills__c
      FROM Resume_Entry__c
      WHERE Resume__c = :resumeId
    ]) {
      if (String.isEmpty(resumeEntry.Skills__c)) {
        continue;
      }

      for (String skill : resumeEntry.Skills__c.split(';')) {
        if (skills.contains(skill)) {
          continue;
        }

        skills.add(skill);
      }
    }

    // .sort() is a void method so we can't just return the constructed list
    List<String> result = new List<String>(skills);
    result.sort();

    // The UI expects this to look like a Multi-Select Picklist, so joining on semicolon
    return String.join(result, ';');
  }
}
