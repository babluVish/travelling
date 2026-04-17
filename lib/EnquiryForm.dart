import 'package:adbhut/CustomDrawer.dart';
import 'package:adbhut/Utils/CommonFun.dart';
import 'package:flutter/material.dart';

class Enquiryform extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController referenceController = TextEditingController();
  TextEditingController statusController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  void login(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Form submitted successfully!")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(""),
        actions: [notificationUI()],
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
      ),
      drawer: CustomDrawer(),
      body: Center(
        child: Container(
          width: 350,
          padding: EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Enquiry Form",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),

                // Username
                TextFormField(
                  controller: usernameController,
                  decoration: InputDecoration(
                    labelText: "Guest Name",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) =>
                      value!.isEmpty ? "Enter guest name" : null,
                ),
                TextFormField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    labelText: "Mobile Number",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) =>
                      value!.isEmpty ? "Enter mobile number" : null,
                ),
                TextFormField(
                  minLines: 1,
                  maxLines: null, // grows automatically
                  keyboardType: TextInputType.multiline,
                  controller: addressController,
                  decoration: InputDecoration(
                    labelText: "Address",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) => value!.isEmpty ? "Enter address" : null,
                ),
                TextFormField(
                  minLines: 1,
                  maxLines: null, // grows automatically
                  keyboardType: TextInputType.multiline,
                  controller: referenceController,
                  decoration: InputDecoration(
                    labelText: "Reference",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) =>
                      value!.isEmpty ? "Enter reference" : null,
                ),
                TextFormField(
                  minLines: 1,
                  maxLines: null, // grows automatically
                  keyboardType: TextInputType.multiline,
                  controller: descriptionController,
                  decoration: InputDecoration(
                    labelText: "Description",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) =>
                      value!.isEmpty ? "Enter description" : null,
                ),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: "Select Status",
                    border: OutlineInputBorder(),
                  ),
                  items: ['Pending', 'In Progress', 'Resolved', 'Closed']
                      .map(
                        (item) =>
                            DropdownMenuItem(value: item, child: Text(item)),
                      )
                      .toList(),
                  onChanged: (value) {},
                  validator: (value) =>
                      value == null ? "select a Status" : null,
                ),

                SizedBox(height: 20),

                // Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => login(context),
                    child: Text("Submit"),
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
