// ignore_for_file: prefer_const_constructors, file_names, prefer_const_literals_to_create_immutables, sort_child_properties_last, body_might_complete_normally_nullable, avoid_print, prefer_typing_uninitialized_variables, prefer_interpolation_to_compose_strings

import 'dart:convert';
import 'dart:math';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notmeet/apictrl/api.dart';
import 'package:notmeet/apictrl/api_model.dart';
import 'package:http/http.dart' as http;
import 'package:notmeet/navbar.dart';

class EditActivity extends StatefulWidget {
  final APIModel apimodel;
  final id;
  const EditActivity({Key? key, required this.apimodel, required this.id}) : super(key: key);

  @override
  State<EditActivity> createState() => _EditActivityState();
}

class _EditActivityState extends State<EditActivity> {
  final List<String> meetorcall = [
    'Meeting',
    'Phone Call',
  ];

  final List<String> whyy = [
    'New Order',
    'Invoice',
    'New Leads',
  ];

  String selectedValue = "";
  String selectedValuewhy = "";
  bool textFieldError = false;
  bool textFieldErrors = false;
  final _formKey = GlobalKey<FormState>();
  final ctrlDate = TextEditingController();
  final ctrlText1 = TextEditingController();
  final ctrlText2 = TextEditingController();

  @override
  void initState() {
    selectedValue = widget.apimodel.activityType;
    ctrlText1.text = widget.apimodel.institution;
    ctrlDate.text = widget.apimodel.when;
    selectedValuewhy = widget.apimodel.objective;
    ctrlText2.text = widget.apimodel.remarks;
    super.initState();
  }

  @override
  void dispose() {
    ctrlDate.dispose();
    ctrlText1.dispose();
    ctrlText2.dispose();
    super.dispose();
  }

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
          title: Text("Edit Activity"),
          backgroundColor: Color.fromARGB(255, 0, 77, 141),
        ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            width: size.width,
            padding: EdgeInsets.only(left: 20, right: 20),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Text(
                  "What do you want to do ?",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                DropdownButtonHideUnderline(
                  child: DropdownButtonFormField2(
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                      border: InputBorder.none,
                    ),
                    isExpanded: true,
                    hint: Text(
                      'Meeting or Phone Call',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    icon: Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.black45,
                    ),
                    value: selectedValue,
                    iconSize: 20,
                    buttonHeight: 45,
                    buttonPadding: EdgeInsets.only(left: 20, right: 15),
                    buttonDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.grey[200],
                    ),
                    dropdownDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    items: meetorcall
                        .map((item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                                style: TextStyle(
                                  fontSize: 13,
                                ),
                              ),
                            ))
                        .toList(),
                    validator: (value) {
                      if (value == null) {
                        return 'Please select Meeting or Phone Call.';
                      }
                    },
                    onChanged: (value) {
                      selectedValue = value.toString();
                    },
                    onSaved: (value) {
                      selectedValue = value.toString();
                    },
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  "Who do you want to meet/call ?",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                TextFormField(
                  validator: (String? text) {
                    setState(() {
                      textFieldError = text == null || text.isEmpty;
                    });
                    return null;
                  },
                  controller: ctrlText1,
                  textAlignVertical: TextAlignVertical(y: -0.8),
                  style: TextStyle(fontSize: 12),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                    isDense: true,
                    alignLabelWithHint: true,
                    hintText: "CV Anugrah Jaya",
                    hintStyle: TextStyle(fontSize: 12, color: Colors.grey),
                    contentPadding: EdgeInsets.fromLTRB(20, 15, 15, 15),
                    filled: true,
                    fillColor: Colors.grey[200],
                    suffixIcon: Align(
                      widthFactor: 1.0,
                      heightFactor: 1.0,
                      child: Icon(
                        Icons.search,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
                textFieldError
                    ? Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Text(
                          'Please fill this textfield',
                          style: TextStyle(color: Colors.red[700], fontSize: 12),
                        ),
                      )
                    : SizedBox(),
                SizedBox(height: 20),
                Text(
                  "When do you want to meet/call CV Anugrah Jaya ?",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                DateTimePicker(
                  type: DateTimePickerType.dateTime,
                  initialValue: ctrlDate.text,
                  dateMask: 'd MMMM, yyyy - H:m',
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2024),
                  style: TextStyle(fontSize: 12, color: Colors.black),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                      borderSide: BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                    suffixIcon: Icon(Icons.calendar_month, color: Colors.grey),
                    contentPadding: EdgeInsets.only(left: 16, top: 15),
                    filled: true,
                    hintText: "d MMMM, yyyy - H:m",
                    hintStyle: TextStyle(
                      fontSize: 12,
                      color: Color(0xFFA7A7A7),
                    ),
                    fillColor: Colors.grey[200],
                  ),
                  onSaved: (val) {
                    setState(() {
                      ctrlDate.text = val!;
                    });
                  },
                  onChanged: (val) {
                    setState(() {
                      ctrlDate.text = val;
                    });
                  },
                ),
                ctrlDate.text.isEmpty
                    ? Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Text(
                          'Please fill this date',
                          style: TextStyle(color: Colors.red[700], fontSize: 12),
                        ),
                      )
                    : SizedBox(),
                SizedBox(height: 20),
                Text(
                  "Why do you want to meet/call CV Anugrah Jaya ?",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                DropdownButtonHideUnderline(
                  child: DropdownButtonFormField2(
                    validator: (value) {
                      if (value == null) {
                        return 'Please select New Order, Invoice or New Leads';
                      }
                    },
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                      border: InputBorder.none,
                    ),
                    isExpanded: true,
                    hint: Text(
                      'New Order, Invoice, New Leads',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    icon: Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.black45,
                    ),
                    value: selectedValuewhy,
                    iconSize: 20,
                    buttonHeight: 45,
                    buttonPadding: EdgeInsets.only(left: 20, right: 15),
                    buttonDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.grey[200],
                    ),
                    dropdownDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    items: whyy
                        .map((item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                                style: TextStyle(
                                  fontSize: 13,
                                ),
                              ),
                            ))
                        .toList(),
                    onChanged: (value) {
                      selectedValuewhy = value.toString();
                    },
                    onSaved: (value) {
                      selectedValuewhy = value.toString();
                    },
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  "Could you describe it more details ?",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                SizedBox(
                  height: 100,
                  child: TextFormField(
                    textAlignVertical: TextAlignVertical(y: -0.8),
                    validator: (String? text) {
                      setState(() {
                        textFieldErrors = text == null || text.isEmpty;
                      });
                      return null;
                    },
                    controller: ctrlText2,
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    style: TextStyle(fontSize: 12),
                    expands: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        ),
                      ),
                      isDense: true,
                      alignLabelWithHint: true,
                      hintText: "Placeholder",
                      hintStyle: TextStyle(fontSize: 12, color: Colors.grey),
                      contentPadding: EdgeInsets.fromLTRB(20, 15, 15, 15),
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                  ),
                ),
                textFieldErrors
                    ? Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Text(
                          'Please fill this textfield',
                          style: TextStyle(color: Colors.red[700], fontSize: 12),
                        ),
                      )
                    : SizedBox(),
                GestureDetector(
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      if (textFieldError == false && textFieldErrors == false && ctrlDate.text.isNotEmpty) {
                        Random ranNum = Random();
                        int id = 0;
                        for (var i = 0; i < 10; i++) {
                          setState(() {
                            id = ranNum.nextInt(1000);
                          });
                        }

                        APIModel apimodel = APIModel(id: id, activityType: selectedValue, institution: ctrlText1.text, when: ctrlDate.text, objective: selectedValuewhy, remarks: ctrlText2.text);
                        Map<String, dynamic> map = apimodel.toJson();
                        String postJson = jsonEncode(map);

                        //Status Code 2XX Success
                        //Status Code 404 Error
                        http
                            .put(Uri.parse(ApiActivity.baseUrl + ApiActivity.usersEndpoint + "/" + widget.id.toString()),
                                headers: <String, String>{
                                  'Content-Type': 'application/json',
                                },
                                body: postJson)
                            .then((response) {
                          print("Response status: ${response.statusCode}");
                          print("Response body: ${response.body}");
                          Get.offAll(() => Navbar());
                        });
                      }
                    }
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 20, bottom: 20),
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Center(
                      child: Text(
                        "Submit",
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
