import 'package:flutter/material.dart';
import "package:google_maps_webservice/places.dart";
import 'package:geocoder/geocoder.dart';
import 'package:petba/model/places.dart';
import '../../constants.dart';

class VetSearchProvider extends ChangeNotifier {
  VetSearchProvider() {
    // fetchVetData();
  }
  List<PlacesSearchResult> result = [];
  List<Places> vets = [];
  List<Address> address = [];
  List<String> phone = [];
  bool isLoading = true;

  fetchVetData() async {
    isLoading = true;
    notifyListeners();
    vets = [];
    address = [];
    phone = [];

    //Getting the data from the Google Places Api
    final places = new GoogleMapsPlaces(apiKey: googleMapsApiKey);
    final response = await places.searchNearbyWithRadius(
      Location(15.2832, 73.9862),
      2000,
      type: 'Hospital',
      keyword: 'Veterinarian',
    );

    //Saving the results of the google search to result list
    response.results.forEach((element) async {
      //To get the address from Latitude and longitude
      Address location = await getLocation(element.geometry.location.lat, element.geometry.location.lng);
      //To get the place phone number and the timings
      PlacesDetailsResponse placeDetails = await places.getDetailsByPlaceId(element.placeId);
      vets.add(Places().fromResults(element, location, placeDetails));
      if (vets.length == response.results.length) {
        isLoading = false;
        notifyListeners();
      }
    });
  }

  Future<Address> getLocation(lat, long) async {
    //Function to get address from the geo coordinates
    final coordinates = new Coordinates(lat, long);
    var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
    return addresses.first;
  }

  loadNextVetData() {
    //Function to load the next 6 set of Vet Data
  }
}
