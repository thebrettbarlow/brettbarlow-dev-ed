global class ResumePicklist extends VisualEditor.DynamicPickList {
  global override VisualEditor.DataRow getDefaultValue() {
    return new VisualEditor.DataRow(null, null);
  }

  global override VisualEditor.DynamicPickListRows getValues() {
    VisualEditor.DynamicPickListRows picklistValues = new VisualEditor.DynamicPickListRows();
    List<Resume__c> resumes = [
      SELECT Id, Name
      FROM Resume__c
      ORDER BY Name ASC
    ];
    for (Resume__c resume : resumes) {
      VisualEditor.DataRow value = new VisualEditor.DataRow(
        resume.Name,
        resume.Name
      );
      picklistValues.addRow(value);
    }
    return picklistValues;
  }
}
