import 'package:flutter/material.dart';

class Constantshere extends StatelessWidget {
  Constantshere(this.heading, this.description);
  late String heading;
  late String description;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 340,
      height: 70,
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        tileColor: Colors.white,
        leading: Container(
          width: 135,
          height: 50,
          child: Align(
            alignment: Alignment.centerRight,
            child: Text(
              heading,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 20,
              ),
            ),
          ),
        ),
        title: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.grey.shade300,
          ),
          alignment: Alignment.center,
          height: 40,
          width: 10,
          child: Text(
            description,
            textAlign: TextAlign.center,
            softWrap: true,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 15,
            ),
          ),
        ),
      ),
    );
  }
}
