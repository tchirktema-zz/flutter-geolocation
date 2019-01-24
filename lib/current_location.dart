import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/services.dart';

class CurrentLocation extends StatefulWidget {
  @override
  _CurrentLocationState createState() => _CurrentLocationState();
}

class _CurrentLocationState extends State<CurrentLocation> {

  Position _position;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initPlatformState();
  }

  Future<void> _initPlatformState() async{
    Position position;

    try{
      final Geolocator geolocator = Geolocator()
          ..forceAndroidLocationManager = true;
      position = await geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation
      );
    } on PlatformException {
        position = null;
    }

    if(!mounted){
      return;
    }

    setState(() {
      _position = position;
    });
  }




  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Geolocator().checkGeolocationPermissionStatus(),
      builder: (BuildContext context, AsyncSnapshot<GeolocationStatus> snapshot){
        if(!snapshot.hasData){
          return const Center(child: CircularProgressIndicator());
        }

        if(snapshot.data == GeolocationStatus.disabled){
          return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text('Location services disabled',
                  style: const TextStyle(fontSize: 32.0, color: Colors.black54),
                  textAlign: TextAlign.center),
                  Text('Enable location services for this App using the device settings.',
                  style: const TextStyle(fontSize: 16.0, color: Colors.black54),
                  textAlign: TextAlign.center),
                ],
              )
          );
        }

        if(snapshot.data == GeolocationStatus.denied){
          return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text('Access to location denied',
                      style: const TextStyle(fontSize: 32.0, color: Colors.black54),
                      textAlign: TextAlign.center),
                  Text('Enable location services for this App using the device settings.',
                      style: const TextStyle(fontSize: 16.0, color: Colors.black54),
                      textAlign: TextAlign.center),
                ],
              )
          );
        }


        return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text('Current location:',
                    style: const TextStyle(fontSize: 32.0, color: Colors.black54),
                    textAlign: TextAlign.center),
                Text(_position.toString(),
                    style: const TextStyle(fontSize: 16.0, color: Colors.black54),
                    textAlign: TextAlign.center),
              ],
            )
        );
      }
    );
  }
}

