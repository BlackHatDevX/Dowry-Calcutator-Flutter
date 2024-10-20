import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Result extends StatelessWidget {
  Result({super.key, required this.CalculatedDowry});
  final double CalculatedDowry;
  final formatter = NumberFormat('#,##,000');

  String getPath() {
    const path = "assets/images/cars/";
    const format = ".png";
    if (CalculatedDowry < 100000) {
      return (path + "6" + format);
    } else if (CalculatedDowry >= 100000 && CalculatedDowry < 200000) {
      return (path + "5" + format);
    } else if (CalculatedDowry >= 200000 && CalculatedDowry < 400000) {
      return (path + "4" + format);
    } else if (CalculatedDowry >= 400000 && CalculatedDowry < 600000) {
      return (path + "3" + format);
    } else if (CalculatedDowry >= 600000 && CalculatedDowry < 900000) {
      return (path + "2" + format);
    } else {
      return (path + "1" + format);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 50),
      child: Scaffold(
        appBar: AppBar(),
        body: Column(children: [
          Image.asset(getPath()),
          Text("Calculated Dowry amount:", style: TextStyle(fontSize: 24)),
          SizedBox(
            height: 12,
          ),
          Text(
            "₹${formatter.format(CalculatedDowry.toInt())}",
            style: TextStyle(
                fontSize: 30, color: const Color.fromARGB(255, 40, 19, 17)),
          )
        ]),
      ),
    );
    ;
  }
}
