import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uber/AllWidgets/Divider.dart';
import 'package:uber/Assistants/requestAssistant.dart';
import 'package:uber/Datahandaler/appData.dart';
import 'package:uber/configMaps.dart';
import 'package:uber/models/placePrediction.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController pickUpTextEditingController = TextEditingController();
  TextEditingController dropoffTextEditingController = TextEditingController();
  List<PlacePrediction> placePredictionList = [];
  @override
  Widget build(BuildContext context) {
    String placeAddress =
        Provider.of<AppData>(context).pickUpLocation!.placeName ?? " ";
    pickUpTextEditingController.text = placeAddress;
    return Scaffold(
      body: Column(children: [
        Container(
          height: 250.0,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black,
                blurRadius: 6.0,
                spreadRadius: 0.5,
                offset: Offset(0.7, 0.7),
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.fromLTRB(25.0, 30, 25.0, 20),
            child: Column(
              children: [
                SizedBox(
                  height: 5.0,
                ),
                Stack(
                  children: [
                    GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(Icons.arrow_back)),
                    Center(
                        child: Text(
                      "Set drop off",
                      style: TextStyle(
                        fontFamily: "Brand Bold",
                        fontSize: 18.0,
                      ),
                    ))
                  ],
                ),
                SizedBox(
                  height: 16.0,
                ),
                Row(
                  children: [
                    Image.asset(
                      "images/pickicon.png",
                      height: 16,
                      width: 16,
                    ),
                    SizedBox(
                      width: 18.0,
                    ),
                    Expanded(
                        child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[400],
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(3.0),
                        child: TextField(
                          controller: pickUpTextEditingController,
                          decoration: InputDecoration(
                            hintText: "Pick up location",
                            fillColor: Colors.grey[400],
                            filled: true,
                            border: InputBorder.none,
                            isDense: true,
                            contentPadding: EdgeInsets.fromLTRB(11.0, 8, 0, 8),
                          ),
                        ),
                      ),
                    ))
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  children: [
                    Image.asset(
                      "images/desticon.png",
                      height: 16,
                      width: 16,
                    ),
                    SizedBox(
                      width: 18.0,
                    ),
                    Expanded(
                        child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[400],
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(3.0),
                        child: TextField(
                          onChanged: (value) {
                            findPlace(value);
                          },
                          controller: dropoffTextEditingController,
                          decoration: InputDecoration(
                            hintText: "Where to?",
                            fillColor: Colors.grey[400],
                            filled: true,
                            border: InputBorder.none,
                            isDense: true,
                            contentPadding: EdgeInsets.fromLTRB(11.0, 8, 0, 8),
                          ),
                        ),
                      ),
                    ))
                  ],
                )
              ],
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        (placePredictionList.length > 0)
            ? Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: ListView.separated(
                  itemCount: placePredictionList.length,
                  padding: EdgeInsets.all(0),
                  itemBuilder: (BuildContext context, int index) {
                    return PredictionTile(
                      placePrediction: placePredictionList[index],
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      DividerWidget(),
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                ),
              )
            : Container(),
      ]),
    );
  }

  void findPlace(String placeName) async {
    if (placeName.length > 1) {
      String autoCom =
          'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$placeName&key=$mapKey&sessiontoken=1234567890&component=country:bd';
      var res;
      res = await RequestAssistant.getRequest(autoCom);
      if (res == "failed") {
        return;
      }
      if (res["status"] == "OK") {
        var predictions = res["predictions"];
        var placelist = (predictions as List)
            .map((e) => PlacePrediction.fromJson(e))
            .toList();
        setState(() {
          placePredictionList = placelist;
        });
      }
    }
  }
}

class PredictionTile extends StatelessWidget {
  final PlacePrediction? placePrediction;
  const PredictionTile({Key? key, this.placePrediction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(
            width: 10,
          ),
          Row(
            children: [
              Icon(Icons.add_location),
              SizedBox(
                width: 14,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 8.0,
                    ),
                    Text(
                      placePrediction!.main_text,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(
                      height: 2.0,
                    ),
                    Text(
                      placePrediction!.secondary_text,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Colors.grey[400],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
          SizedBox(
            width: 10,
          ),
        ],
      ),
    );
  }
}
