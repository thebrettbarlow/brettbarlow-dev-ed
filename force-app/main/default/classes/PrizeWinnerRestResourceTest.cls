/**
 * Tests for {@link PrizeWinnerRestResource}.
 */
@IsTest
private class PrizeWinnerRestResourceTest {
  @IsTest
  private static void writePrizeRecord() {
    String name = 'prize-name';
    String firstName = 'first-name';
    String lastName = 'last-name';
    RestContext.request = new RestRequest();
    RestContext.request.requestBody = Blob.valueOf(
      JSON.serialize(buildPrizeWinnerWrapper(name, firstName, lastName))
    );
    RestContext.response = new RestResponse();

    PrizeWinnerRestResource.writePrizeRecord();
    RestResponse response = RestContext.response;

    List<Prize_Winner__c> prizeWinners = [
      SELECT Id, Name, First_Name__c, Last_Name__c
      FROM Prize_Winner__c
    ];
    System.assertEquals(1, prizeWinners.size());
    Prize_Winner__c prizeWinner = prizeWinners[0];
    Id prizeWinnerRecordId = response.responseBody.toString();
    System.assertEquals(prizeWinnerRecordId, prizeWinner.Id);
    System.assertEquals(name, prizeWinner.Name);
    System.assertEquals(firstName, prizeWinner.First_Name__c);
    System.assertEquals(lastName, prizeWinner.Last_Name__c);
  }

  private static PrizeWinnerRestResource.PrizeWinnerWrapper buildPrizeWinnerWrapper(
    String name,
    String firstName,
    String lastName
  ) {
    PrizeWinnerRestResource.PrizeWinnerWrapper prizeWinnerWrapper = new PrizeWinnerRestResource.PrizeWinnerWrapper();
    prizeWinnerWrapper.body = new PrizeWinnerRestResource.PrizeWinner();
    prizeWinnerWrapper.body.user = new PrizeWinnerRestResource.PrizeWinnerUser();
    prizeWinnerWrapper.body.user.first_name = firstName;
    prizeWinnerWrapper.body.user.last_name = lastName;
    prizeWinnerWrapper.body.prize = new PrizeWinnerRestResource.PrizeWinnerPrize();
    prizeWinnerWrapper.body.prize.prize_type = new PrizeWinnerRestResource.PrizeWinnerPrizeType();
    prizeWinnerWrapper.body.prize.prize_type.name = name;
    prizeWinnerWrapper.body.participant = new PrizeWinnerRestResource.PrizeWinnerParticipant();
    prizeWinnerWrapper.body.participant.id = 'participant-id';

    return prizeWinnerWrapper;
  }
}
