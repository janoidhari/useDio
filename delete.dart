import 'package:apiapp/API/api.dart';
import 'package:apiapp/modal/usermodal.dart';
import 'package:flutter/material.dart';

class Delete extends StatefulWidget {
  const Delete({Key? key}) : super(key: key);

  @override
  _DeleteState createState() => _DeleteState();
}

class _DeleteState extends State<Delete> {
  final TextEditingController id = TextEditingController();
  final DioClient dioClient = DioClient();

  bool isDeleting = false;
  bool isFetching = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Delete User'),
      ),
      body: Center(
        child: Container(
          color: Colors.blue.shade50,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Flexible(
                  child: TextField(
                    controller: id,
                    decoration: InputDecoration(hintText: 'Enter ID'),
                  ),
                ),
                SizedBox(width: 16.0),
                isFetching
                    ? CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: () async {
                          setState(() {
                            isFetching = true;
                          });

                          User? user = await dioClient.getUser(
                            UserId: id.text,
                          );

                          if (user != null) {
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
                                        Text('ID: ${user.data.id}'),
                                        Text('Name: ${user.data.name}'),
                                        Text('Email: ${user.data.email}'),
                                        Text('Email: ${user.data.gender}'),
                                        Text('Email: ${user.data.status}'),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }

                          setState(() {
                            isFetching = false;
                            id.text = '';
                          });
                        },
                        child: Text('Fetch'),
                      ),
                SizedBox(width: 16.0),
                isDeleting
                    ? CircularProgressIndicator(
                        color: Colors.red,
                      )
                    : ElevatedButton(
                        onPressed: () async {
                          setState(() {
                            isDeleting = true;
                          });
                          await dioClient.deleteUser(id: id.text);
                          final snackBar = SnackBar(
                            content: Text(
                              'User at id ${id.text} deleted!',
                              style: TextStyle(fontSize: 20.0),
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);

                          setState(() {
                            isDeleting = false;
                            id.text = '';
                          });
                        },
                        child: Text('Delete'),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
