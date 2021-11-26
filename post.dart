import 'package:apiapp/API/api.dart';
import 'package:apiapp/modal/data.dart';
import 'package:flutter/material.dart';

class PostData extends StatefulWidget {
  const PostData({Key? key}) : super(key: key);

  @override
  _PostDataState createState() => _PostDataState();
}

class _PostDataState extends State<PostData> {
  ///create the object of DioClient = [client]
  final DioClient client = DioClient();
  bool isCreating = false;
  TextEditingController nameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();

  String genderDropdown = 'Male';
  String statusDropdown = 'Active';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Post Data'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 8,
              ),
              TextField(
                controller: nameController,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(hintText: 'Enter a Name'),
              ),
              SizedBox(
                height: 8,
              ),
              TextField(
                controller: emailController,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(hintText: 'Enter a Email'),
              ),
              SizedBox(
                height: 8,
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
              SizedBox(
                height: 10,
              ),
              isCreating
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: () async {
                        setState(() {
                          isCreating = true;
                        });
                        if (nameController.text != '' &&
                            emailController.text != '') {
                          Data data = Data(
                            name: nameController.text,
                            email: emailController.text,
                            gender: genderDropdown,
                            status: statusDropdown,
                          );

                          Data? reUser =
                              await client.createUser(userInfo: data);

                          if (reUser != null) {
                            print('True');
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text('ID: ${reUser.id}'),
                                        Text('Name: ${reUser.name}'),
                                        Text('Email: ${reUser.email}'),
                                        Text(
                                          'Gender: ${reUser.gender}',
                                        ),
                                        Text(
                                          'Status: ${reUser.status}',
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }
                        }

                        setState(() {
                          isCreating = false;
                          nameController.text = '';
                          emailController.text = '';
                        });
                      },
                      child: Text(
                        'Create user',
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ),
            ],
          ),
        ));
  }
}
