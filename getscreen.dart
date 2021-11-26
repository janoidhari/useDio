import 'package:apiapp/API/api.dart';
import 'package:apiapp/modal/data.dart';
import 'package:apiapp/modal/usermodal.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  // final Future<List<User>> user;
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final DioClient client = DioClient();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Get Data'),
      ),
      body: Center(
        child: FutureBuilder<User?>(
          future: client.getUser(UserId: '1505'),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              User? userInfo = snapshot.data;
              if (userInfo != null) {
                Data userData = userInfo.data;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Name: ' + userData.name,
                      style: TextStyle(fontSize: 16.0),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'Email: ' + userData.email,
                      style: TextStyle(fontSize: 16.0),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'Gender: ' + userData.gender,
                      style: TextStyle(fontSize: 16.0),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'status: ' + userData.status,
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ],
                );
              }
            }
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}











// import 'package:apiapp/API/api.dart';
// import 'package:apiapp/modal/usermodal.dart';
// import 'package:flutter/material.dart';

// class MyHomePage extends StatelessWidget {
//   // final Future<List<User>>? user;
//   MyHomePage({
//     Key? key,
//   }) : super(key: key);

//   final DioClient client = DioClient();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('View API'),
//       ),
//       body: Column(
//         children: [
//           ElevatedButton(
//             onPressed: () {
//               Navigator.pop(context);
//             },
//             child: Text('View Data'),
//           ),
//           Center(
//             child: FutureBuilder<List<User>>(
//               future: client.getUser(),
//               builder: (context, snapshot) {
//                 if (snapshot.hasData) print(snapshot.hasData);
//                 List<User>? userInfo = snapshot.data;
//               if (userInfo != null) {
//                 List<User>? userData = userInfo.data;
//                   return snapshot.hasData
//                       ? ListView.builder(
//                           // itemCount: data.length,
//                           itemBuilder: (context, index) {
//                             return Card(
//                               elevation: 5,
//                               child: Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceEvenly,
//                                 children: <Widget>[
//                                   Expanded(
//                                     child: Container(
//                                       padding: EdgeInsets.all(5),
//                                       child: Column(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.spaceEvenly,
//                                         children: <Widget>[
//                                           Text("id:${}"),
//                                           // Text("name:${}"),
//                                           // Text("name:${}"),
//                                           // Text("name:${}"),
//                                           // Text("name:${}"),
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             );
//                           },
//                         )
//                       : CircularProgressIndicator();
//                 }
//                 return CircularProgressIndicator();
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
