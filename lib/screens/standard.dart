import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class StandardMapPage extends StatefulWidget {
  const StandardMapPage({required this.title, Key? key}) : super(key: key);

  final String title;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _StandardMapPageState();
  }
}

class _StandardMapPageState extends State<StandardMapPage> {
  final Completer<GoogleMapController> _mapController = Completer();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
    );
  }
}
