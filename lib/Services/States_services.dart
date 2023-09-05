import 'dart:convert';

import 'package:covidapp/Model/World_State_Model.dart';
import 'package:covidapp/Services/Utililty/app_url.dart';
import 'package:covidapp/view/World_States.dart';
import 'package:covidapp/view/countries.dart';
import 'package:http/http.dart'as http;
class StatesServices{
  Future<WorldStatesModel> fetchWorkedStatesRecords  () async {
final response =await  http.get(Uri.parse(appUrl.worldStatesApi));
if (response.statusCode ==200){

  var data =jsonDecode(response.body) ;
  return WorldStatesModel.fromJson(data);

}else{
throw Exception('error');

}

  }
  Future<List<dynamic>> countriesListApi () async {
    var data;
    final response =await  http.get(Uri.parse(appUrl.countriesList));
    print(response.statusCode.toString());
    print(data);

    if (response.statusCode ==200){

       data =jsonDecode(response.body) ;
      return data;

    }else{
      throw Exception('error');

    }

  }
}
