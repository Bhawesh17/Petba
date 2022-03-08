import 'package:geocoder/geocoder.dart';
import 'package:google_maps_webservice/places.dart';

import '../constants.dart';

class Places {
  Places({
    this.id,
    this.placeId,
    this.name,
    this.lat,
    this.lng,
    this.photo,
    this.address,
    this.formattedAddress,
    this.timings,
    this.phone,
  });

  String id, placeId, name, photo, address, formattedAddress, phone, timings;
  double lat, lng;

  fromResults(PlacesSearchResult result, Address location, PlacesDetailsResponse placeDetails) {
    String baseUrl = 'https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=';
    return Places(
      id: result.id,
      placeId: result.placeId,
      name: result.name == null ? 'Un Named' : result.name,
      lat: result.geometry.location.lat,
      lng: result.geometry.location.lng,
      photo: result.photos == null
          ? 'https://i.stack.imgur.com/y9DpT.jpg'
          : baseUrl + result.photos[0].photoReference + '&key=' + googleMapsApiKey,
      address: location.locality,
      formattedAddress: placeDetails.result.formattedAddress,
      phone: placeDetails.result.internationalPhoneNumber == null
          ? placeDetails.result.formattedPhoneNumber == null
              ? ' '
              : placeDetails.result.formattedPhoneNumber
          : placeDetails.result.internationalPhoneNumber,
      timings: placeDetails.result.openingHours == null
          ? 'Timings Unavailable'
          : placeDetails.result.openingHours.openNow
              ? 'Open'
              : 'Closed',
    );
  }
}
