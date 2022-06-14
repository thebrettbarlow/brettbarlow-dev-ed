global class ResumePicklist extends VisualEditor.DynamicPickList {
  global override VisualEditor.DataRow getDefaultValue() {
    return new VisualEditor.DataRow(null, null);
  }

  global override VisualEditor.DynamicPickListRows getValues() {
    VisualEditor.DynamicPickListRows picklistValues = new VisualEditor.DynamicPickListRows();
    List<Resume__c> resumes = [SELECT Id, Name FROM Resume__c];
    for (Resume__c resume : resumes) {
      VisualEditor.DataRow value = new VisualEditor.DataRow(
        resume.Name,
        String.valueOf(resume.Id) // https://salesforce.stackexchange.com/a/255411/54914
      );
      picklistValues.addRow(value);
    }
    return picklistValues;
  }
}
