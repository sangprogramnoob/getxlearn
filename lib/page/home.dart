// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sized_box_for_whitespace, sort_child_properties_last
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:notmeet/apictrl/api_model.dart';
import 'package:notmeet/apictrl/api_service.dart';
import 'package:get/get.dart';
import 'package:notmeet/page/activityInfo.dart';
import 'package:notmeet/page/addNewActivity.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late List<APIModel>? apiModels = [];

  @override
  void initState() {
    super.initState();
    _getDataAct();
    initializeDateFormatting().then((_) => setState(() {}));
  }

  void _getDataAct() async {
    apiModels = (await ApiService().getActivity())!;
    Future.delayed(const Duration(seconds: 1)).then(
      (value) => setState(() {}),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        child: Column(
          children: [
            Container(
              height: size.height / 5,
              width: size.width,
              color: Color.fromARGB(255, 0, 77, 141),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: Text(
                      "Activities",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {},
                          child: Container(
                            margin: EdgeInsets.fromLTRB(15, 15, 0, 0),
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Center(
                              child: Text(
                                "Open",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {},
                          child: Container(
                            margin: EdgeInsets.fromLTRB(10, 15, 15, 0),
                            height: 40,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Center(
                              child: Text(
                                "Complete",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.white,
                child: apiModels == null || apiModels!.isEmpty
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView.separated(
                        itemCount: apiModels!.length,
                        itemBuilder: (context, index) {
                          var apmod = apiModels![index];
                          return GestureDetector(
                            onTap: () => Get.to(() => ActivityInfo(apimodel: apmod)),
                            child: Container(
                              height: 61,
                              color: Colors.white,
                              margin: EdgeInsets.fromLTRB(20, 0, 20, 5),
                              width: size.width,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    DateFormat('EEEE, d MMM yyyy').format(
                                      DateTime.parse(apiModels![index].when),
                                    ),
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 5),
                                  Row(
                                    children: [
                                      Text(
                                        DateFormat('Hm').format(
                                          DateTime.parse(apiModels![index].when),
                                        ),
                                        style: TextStyle(fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(width: 30),
                                      Expanded(
                                        child: Container(
                                          height: 40,
                                          decoration: BoxDecoration(
                                            color: Colors.blue,
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.fromLTRB(10, 7, 10, 0),
                                            child: Text(
                                              apiModels![index].remarks.toString(),
                                              style: TextStyle(fontSize: 13, color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: Divider(),
                          );
                        },
                      ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => AddNewActivity()),
        child: Icon(
          Icons.add,
          size: 35,
        ),
        backgroundColor: Color.fromARGB(255, 0, 77, 141),
      ),
    );
  }
}
