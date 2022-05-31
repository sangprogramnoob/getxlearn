// ignore_for_file: prefer_const_constructors, file_names, prefer_const_literals_to_create_immutables, sort_child_properties_last, body_might_complete_normally_nullable, avoid_print, sized_box_for_whitespace, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notmeet/apictrl/api_model.dart';
import 'package:notmeet/page/editActivity.dart';

class ActivityInfo extends StatelessWidget {
  final APIModel apimodel;
  const ActivityInfo({Key? key, required this.apimodel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.keyboard_arrow_left,
              size: 35,
            ),
            onPressed: () => Get.back(),
          ),
          centerTitle: true,
          title: Text("Activity Info"),
          backgroundColor: Color.fromARGB(255, 0, 77, 141),
        ),
      ),
      body: Container(
        height: size.height,
        width: size.width,
        child: Column(
          children: [
            Container(
              height: 150,
              width: size.width,
              margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Colors.grey.shade400,
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Details",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20),
                    Text(
                      apimodel.activityType + " with " + apimodel.institution + " at " + apimodel.when + " to discuss about " + apimodel.objective,
                    ),
                    GestureDetector(
                      onTap: () => Get.to(() => EditActivity(apimodel: apimodel, id: apimodel.id)),
                      child: Container(
                        margin: EdgeInsets.only(top: 20),
                        height: 40,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 0, 77, 141),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Center(
                          child: Text(
                            "Edit Activity",
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
