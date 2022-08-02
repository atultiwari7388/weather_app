import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../controllers/global_controller.controller.dart';

class HeaderWidget extends StatefulWidget {
  const HeaderWidget({Key? key}) : super(key: key);

  @override
  State<HeaderWidget> createState() => _HeaderWidgetState();
}

class _HeaderWidgetState extends State<HeaderWidget> {
  final GlobalController globalController =
      Get.put(GlobalController(), permanent: true);

  String city = "";
  String street = "";
  String subLocality = "";

  String date = DateFormat("yMMMMd").format(DateTime.now());

  @override
  void initState() {
    super.initState();
    getAddress(globalController.getLatitude().value,
        globalController.getLongitude().value);
  }

  getAddress(lat, long) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(lat, long);
    Placemark place = placemarks[0];
    setState(() {
      street = place.street!.substring(6, 19).toUpperCase();
      city = place.locality!;
      subLocality = place.subLocality!;
    });
    if (kDebugMode) {
      print(place);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(left: 20, right: 20),
          alignment: Alignment.topLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                city,
                style: const TextStyle(fontSize: 35, height: 1.5),
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  Text(
                    "$subLocality,",
                    style:
                        const TextStyle(fontSize: 20, color: Colors.blueGrey),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    street.toLowerCase(),
                    style:
                        const TextStyle(fontSize: 20, color: Colors.blueGrey),
                  ),
                ],
              ),
            ],
          ),
        ),
        //current date
        Container(
          margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
          alignment: Alignment.topLeft,
          child: Text(
            date,
            style:
                TextStyle(fontSize: 14, height: 1.5, color: Colors.grey[700]),
          ),
        ),
      ],
    );
  }
}
