/**
 * Handles incoming REST requests to the prize-winner endpoint.
 */
@RestResource(UrlMapping='/prize-winner/')
global with sharing class PrizeWinnerRestResource {
  @HttpPost
  global static void writePrizeRecord() {
    // Alternatively we could: global static void writePrizeRecord(String body)
    // PrizeWinner prizeWinner = (PrizeWinner) JSON.deserialize(body, PrizeWinner.class);
    // Or even global static void writePrizeRecord(PrizeWinner prizeWinner)

    // This is an example of using RestContext instead
    RestRequest request = RestContext.request;
    PrizeWinnerWrapper prizeWinnerWrapper = (PrizeWinnerWrapper) JSON.deserialize(
      request.requestBody.toString(),
      PrizeWinnerWrapper.class
    );

    PrizeWinner prizeWinner = prizeWinnerWrapper.body;
    Prize_Winner__c prizeWinnerRecord = new Prize_Winner__c(
      Name = prizeWinner.prize.prize_type.name,
      First_Name__c = prizeWinner.user.first_name,
      Last_Name__c = prizeWinner.user.last_name
    );
    insert prizeWinnerRecord;

    RestResponse response = RestContext.response;
    response.statusCode = 201;
    response.responseBody = Blob.valueOf(prizeWinnerRecord.Id);
  }

  @TestVisible
  private class PrizeWinnerWrapper {
    @TestVisible
    private PrizeWinner body;
  }

  @TestVisible
  private class PrizeWinner {
    @TestVisible
    private PrizeWinnerParticipant participant;
    @TestVisible
    private PrizeWinnerUser user;
    @TestVisible
    private PrizeWinnerPrize prize;
  }

  @TestVisible
  private class PrizeWinnerParticipant {
    @TestVisible
    private String id;
  }

  @TestVisible
  private class PrizeWinnerUser {
    @TestVisible
    private String first_name;
    @TestVisible
    private String last_name;
  }

  @TestVisible
  private class PrizeWinnerPrize {
    @TestVisible
    private PrizeWinnerPrizeType prize_type;
  }

  @TestVisible
  private class PrizeWinnerPrizeType {
    @TestVisible
    private String name;
  }
}
