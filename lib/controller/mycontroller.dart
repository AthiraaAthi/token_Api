import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:tokens_api/model/my_model.dart';
import 'package:tokens_api/model/token_model.dart';

class MyController with ChangeNotifier {
  Map<String, dynamic> decodedData = {};

  ResponseModel responseModelobj = ResponseModel();

  Future loginApi({required String username, required String password}) async {
    notifyListeners();
    final url = Uri.parse("https://dummyjson.com/auth/login");
    var response = await http.post(
      url,
      body: jsonEncode(
        {
          "username": username,
          "password": password,
        },
      ),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      final decodedData2 = jsonDecode(response.body);
      responseModelobj = ResponseModel.fromJson(decodedData2);

      //////Obtain shared preferences.
      /////TO STORE IN SHARED PREF WE NEED CREATE ANOTHER MODEL OF TOKEN FROM CONSOLE
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString("token", responseModelobj.token!);
      print(response.body);
      print("Your token is: $decodedData2");
    } else {
      print("Api Failed");
    }
  }
}
