import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

// const key = 'AIzaSyDDwQYI0CV0sUlhxTQ4NcpWCBvAJcpwSEA';

//const key = 'AIzaSyA2c8lb1XaLJKOVPFneOErpWLCyrp0kIkI';

class PlacesService {
  Future getAutocomplete(String search) async {
    // log(search);
    var googleApiKey = dotenv.env['GOOGLE_MAP_API_KEY'];

    var url =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$search&key=$googleApiKey&components=country:IE&sessiontoken=1234567890';
    var response = await http.get(Uri.parse(url));
    print(
        "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$search&key=$googleApiKey&components=country:IE&sessiontoken=1234567890");
    // notifyListeners();

    // print("......"+response.body);
    return response.body;
  }

  getPlace(String placeId) async {
    var googleApiKey = "AIzaSyDdTfKwZav5Qyg3ht88N76lDTFntOe30dQ";
    var url =
        'https://maps.googleapis.com/maps/api/place/details/json?parameters&key=$googleApiKey&components=country:IE&place_id=$placeId';
    var response = await http.get(Uri.parse(url));

    //notifyListeners();
    return response.body;
  }
}
