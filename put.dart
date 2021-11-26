import 'package:apiapp/API/api.dart';
import 'package:apiapp/modal/data.dart';
import 'package:flutter/material.dart';

class UpdateScreen extends StatefulWidget {
  const UpdateScreen({Key? key}) : super(key: key);

  @override
  _UpdateScreenState createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  final DioClient client = DioClient();
  bool isUpdating = false;
  TextEditingController idController = new TextEditingController();
  TextEditingController nameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();

  String genderDropdown = 'Male';
  String statusDropdown = 'Active';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update API'),
      ),
      body: Column(
        children: [
          TextField(
            controller: idController,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(hintText: 'Enter ID'),
          ),
          TextField(
            controller: nameController,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(hintText: 'Enter name'),
          ),
          TextField(
            controller: emailController,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(hintText: 'Enter email'),
          ),
          Container(
            width: double.infinity,
            child: DropdownButton<String>(
              value: genderDropdown,
              elevation: 16,
              style: const TextStyle(color: Colors.deepPurple),
              underline: Container(
                height: 1,
                color: Colors.grey,
              ),
              onChanged: (String? newValue) {
                setState(() {
                  genderDropdown = newValue!;
                });
              },
              items: <String>['Male', 'Female']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            width: double.infinity,
            child: DropdownButton<String>(
              value: statusDropdown,
              elevation: 16,
              style: const TextStyle(color: Colors.deepPurple),
              underline: Container(
                height: 1,
                color: Colors.grey,
              ),
              onChanged: (String? newValue) {
                setState(() {
                  statusDropdown = newValue!;
                });
              },
              items: <String>['Active', 'Inactive']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
          SizedBox(height: 16.0),
          isUpdating
              ? CircularProgressIndicator()
              : ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      isUpdating = true;
                    });

                    if (nameController.text != '' &&
                        emailController.text != '') {
                      Data data = Data(
                        name: nameController.text,
                        email: emailController.text,
                        gender: genderDropdown,
                        status: statusDropdown,
                      );

                      Data? retrievedUser = await client.updateUser(
                          userInfo: data, id: idController.text);

                      if (retrievedUser != null) {
                        showDialog(
                          context: context,
                          builder: (context) => Dialog(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text('id: ${retrievedUser.id}'),
                                    Text('Name: ${retrievedUser.name}'),
                                    Text('email: ${retrievedUser.email}'),
                                    Text(
                                      'gender: ${retrievedUser.gender}',
                                    ),
                                    Text('status: ${retrievedUser.status}'),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }
                    }

                    setState(() {
                      isUpdating = false;
                      idController.text = '';
                      nameController.text = '';
                      emailController.text = '';
                    });
                  },
                  child: Text(
                    'Update user',
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
        ],
      ),
    );
  }
}
