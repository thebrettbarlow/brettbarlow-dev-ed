List<Network> networks = [SELECT Id FROM Network WHERE Name = 'Home'];
if (networks.size() != 1) {
  throw new UnexpectedException(
    'Expected 1 Network named Home. Found ' + networks.size()
  );
}

System.debug(ConnectApi.Communities.getCommunity(networks[0].Id));
