System.debug('Starting run.apex');
String subject = 'foo;bar';
List<String> result = subject.split(';');
System.debug(result);
System.debug('Done');
