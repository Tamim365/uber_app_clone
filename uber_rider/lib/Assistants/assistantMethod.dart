import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:uber/Assistants/requestAssistant.dart';
import 'package:uber/Datahandaler/appData.dart';
import 'package:uber/configMaps.dart';
import 'package:uber/models/address.dart';

class AssistantMethods {
  static Future<String> searchCoordinateAddress(
      Position position, context) async {
    // assert(position != null);
    // assert(context != null);
    String placeAddress = "";
    String st1, st2, st3, st4;
    String url =
        "https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=AIzaSyAyR-Xlsd-8dsb29_GZkmid83Nj5YJYosQ";

    var response = await RequestAssistant.getRequest(url);
    if (response != "failed") {
      st1 = response["results"][0]["address_components"][3]["long_name"];
      st2 = response["results"][0]["address_components"][4]["long_name"];
      st3 = response["results"][0]["address_components"][5]["long_name"];
      st4 = response["results"][0]["address_components"][6]["long_name"];
      placeAddress = st1 + " ," + st2 + "," + st3 + "," + st4;
      Address userPickUpAddress = new Address();

      userPickUpAddress.longitude = position.longitude;
      userPickUpAddress.latitude = position.latitude;
      userPickUpAddress.placeName = placeAddress;

      Provider.of<AppData>(context, listen: false)
          .updatePickUpLocationAddress(userPickUpAddress);
    }

    return placeAddress;
  }
}
