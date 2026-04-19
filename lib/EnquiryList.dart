import 'package:adbhut/CustomDrawer.dart';
import 'package:adbhut/EnquiryForm.dart';
import 'package:adbhut/Utils/CommonFun.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EnquiryList extends StatelessWidget {
  String? get selectedItem => null;

  final controller = Get.put(DropdownController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(""), actions: [notificationUI()]),
      drawer: CustomDrawer(),
      body: Center(
        child: Stack(
          children: [
            GridView.builder(
              itemCount: 50,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 6,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                return Card(
                  elevation: 4,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(children: [Text(' Name:'), Text(' Aman')]),
                      // SizedBox(height: 10),
                      Row(
                        children: [
                          Text(' Mobile Number:'),
                          Text(' 9644434342'),
                        ],
                      ),

                      Row(
                        children: [
                          Text(' Address:'),
                          Expanded(
                            child: Text(
                              ' Bargdawa Gorakhpur',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      Row(children: [Text(' Reference:'), Text(' Aman')]),
                      Row(children: [Text(' Description:'), Text('Aman')]),
                      Row(children: [Text(' Created At:'), Text('2-20-2026')]),
                      Row(children: [Text(' Status :'), Text(' Pending')]),

                      SizedBox(height: 20),
                      SizedBox(
                        width: 200,
                        child: ElevatedButton(
                          onPressed: () => {_showModelBottomSheet(context)},
                          child: Text("Share"),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),

            Positioned(
              bottom: 16,
              right: 16,
              child: FloatingActionButton(
                onPressed: () => {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => Enquiryform()),
                    (route) => false,
                  ),
                },
                child: Icon(Icons.add),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: bottomUI(),
    );
  }

  void _showModelBottomSheet(BuildContext context) {
    List<String> items = ["Aman", "Ravi", "Raju", "Bob"];

    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Stack(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Select Users"),
                    SizedBox(height: 30),
                    Obx(() {
                      return DropdownSearch<String>(
                        items: controller.countryList,
                        selectedItem: controller.selectedCountry.value,
                        popupProps: PopupProps.menu(
                          showSearchBox: true, // 🔍 enable search
                        ),
                        dropdownDecoratorProps: DropDownDecoratorProps(
                          dropdownSearchDecoration: InputDecoration(
                            labelText: "Select User",
                            border: OutlineInputBorder(),
                          ),
                        ),
                        onChanged: (value) => controller.setCountry(value),
                      );
                    }),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () => {
                        if (controller.selectedCountry.value != null)
                          {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Shared successfully!")),
                            ),
                            Navigator.pop(context),
                          }
                        else
                          {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Please select a user!")),
                            ),
                          },
                      },
                      child: Text("Submit"),
                    ),
                  ],
                ),
                Positioned(
                  top: 1,
                  right: 16,
                  child: IconButton(
                    onPressed: () {
                      controller.setCountry(null);
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.close),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class DropdownController extends GetxController {
  // Selected value
  var selectedCountry = RxnString();

  // List of items
  var countryList = <String>["Aman", "Ravi", "Raju", "Bob"].obs;

  // Set value
  void setCountry(String? value) {
    selectedCountry.value = value;
  }
}
