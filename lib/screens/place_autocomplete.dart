import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:full_map_uses/models/suggestion.dart';
import 'package:full_map_uses/provider/place_api_provider.dart';
import 'package:full_map_uses/widget/address_search.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uuid/uuid.dart';

class PlaceAutocompletePage extends StatefulWidget {
  const PlaceAutocompletePage({required this.title, Key? key})
      : super(key: key);

  final String title;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _PlaceAutocompletePageState();
  }
}

class _PlaceAutocompletePageState extends State<PlaceAutocompletePage> {
  final Completer<GoogleMapController> _mapController = Completer();
  final _controller = TextEditingController();
  String _streetNumber = '';
  String _street = '';
  String _city = '';
  String _zipCode = '';
  static final CameraPosition _kGooglePlex = CameraPosition(
      target: LatLng(37.42796133580664, -122.085749655962), zoom: 14.4746);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(

      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
          TextField(
          controller: _controller,
          readOnly: true,
          onTap: () async {
            // generate a new token here
            final sessionToken = Uuid().v4();
            final Suggestion? result = await showSearch(
              context: context,
              delegate: AddressSearch(sessionToken),
            );
            // This will change the text displayed in the TextField
            final placeDetails = await PlaceApiProvider(sessionToken)
                .getPlaceDetailFromId(result!.placeId);
            setState(() {
              _controller.text = result.description;
              _streetNumber = placeDetails.streetNumber;
              _street = placeDetails.street;
              _city = placeDetails.city;
              _zipCode = placeDetails.zipCode;
            });
          },
          decoration: InputDecoration(
            icon: Container(
              width: 10,
              height: 10,
              child: Icon(
                Icons.home,
                color: Colors.black,
              ),
            ),
            hintText: "Enter your shipping address",
            border: InputBorder.none,
            contentPadding: EdgeInsets.only(left: 8.0, top: 16.0),
          ),
        ),

            GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: _kGooglePlex,
              onMapCreated: (controller) => _mapController.complete(controller),
              myLocationEnabled: true,
              myLocationButtonEnabled: false,
              zoomControlsEnabled: false,
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text(widget.title),
      ),
    );
  }
}
