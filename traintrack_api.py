"""TrainTrack API implemented using Google Cloud Endpoints.

Defined here are the ProtoRPC messages needed to define Schemas for methods
as well as those methods defined in an API.
"""

import endpoints
from protorpc import messages
from protorpc import message_types
from protorpc import remote

package = 'TrainTrack'


class Journey(messages.Message):
    """Greeting that stores an origin."""
    origin = messages.StringField(1)
    destination = messages.StringField(2)


class JourneyCollection(messages.Message):
    """Collection of Journeys."""
    journeys = messages.MessageField(Journey, 1, repeated=True)


STORED_JOURNEYS = JourneyCollection(journeys=[
    Journey(origin='CGN', destination='CDF'),
    Journey(origin='CDF', destination='BRI'),
])


@endpoints.api(name='traintrack', version='v1')
class TrainTrackApi(remote.Service):
    """TrainTrack API v1."""

    @endpoints.method(message_types.VoidMessage, JourneyCollection,
                      path='journeys', http_method='GET',
                      name='journeys.listJourneys')
    def journeys_list(self, unused_request):
        return STORED_JOURNEYS

    MULTIPLY_METHOD_RESOURCE = endpoints.ResourceContainer(
            Journey,
            times=messages.IntegerField(2, variant=messages.Variant.INT32,
                                        required=True))

    @endpoints.method(MULTIPLY_METHOD_RESOURCE, Journey,
                      path='journeys/{times}', http_method='POST',
                      name='journeys.multiply')
    def journeys_multiply(self, request):
        return Journey(origin=request.origin * request.times, destination=request.destination * request.times)

    ID_RESOURCE = endpoints.ResourceContainer(
            message_types.VoidMessage,
            id=messages.IntegerField(1, variant=messages.Variant.INT32))

    @endpoints.method(ID_RESOURCE, Journey,
                      path='journeys/{id}', http_method='GET',
                      name='journeys.getJourney')
    def journey_get(self, request):
        try:
            return STORED_JOURNEYS.journeys[request.id]
        except (IndexError, TypeError):
            raise endpoints.NotFoundException('Journey %s not found.' %
                                              (request.id,))


APPLICATION = endpoints.api_server([TrainTrackApi])