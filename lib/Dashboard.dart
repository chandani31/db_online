import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:online_db_form/Login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  late SharedPreferences loginData;
  late String MobileNo;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initial();
  }

  void initial() async {
    loginData = await SharedPreferences.getInstance();

    setState(() {
      MobileNo = loginData.getString('MobileNo')!;
    });
  }

  late List list;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("DashBoard"),
        actions: [
          IconButton(
            onPressed: (){
              loginData.setBool('login', true);
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Login()));
            }, icon: Icon(Icons.logout),)
        ],
      ),
      body: Center(
        child: FutureBuilder<List>(
          future: getdetail(),
          builder: (ctx, ss){

            if(ss.hasData){
              return Items(list:ss.data!);
            }
            if(ss.hasError){
              print("Network not found");
            }

            return CircularProgressIndicator();
          },
        )
      ),
    );
  }

  Future<List>getdetail() async
  {
    var response = await http.get(Uri.parse("https://begrimed-executions.000webhostapp.com/digital_society/register/register_view.php"));
    return jsonDecode(response.body);
  }
}

class Items extends StatelessWidget {
  List list;
  Items({required this.list});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list.length,
        itemBuilder: (context, index){

        return Container(
          padding: EdgeInsets.all(8),
          child: ListTile(
            title: Text("${list[index]['FirstName'].toString()}" "  " "${list[index]['LastName'].toString()}"),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(list[index]['Gender'].toString()),
                Text(list[index]['Password'].toString()),
                Text(list[index]['Email'].toString()),
              ],
            ),
            trailing: Icon(Icons.add),
          ),
        );
    });
  }
}

