import 'dart:convert';

import '../model/picsum_model.dart';
import 'package:http/http.dart' as http;

class Services{
  fetchPicturesApi()async{
    String url = "https://line-kw.com/joko/en/api/used-market-categories";
    final response = await http.get(Uri.parse(url));
    if(response.statusCode==200){
      final json = jsonDecode(response.body);
      return json;
      if(json['success']){
        final listResult = json['data'].map((e)=>PicSumModel.fromJson(e)).toList();
        return listResult;
      }else{
        return json['message'];
      }
      // var listResult;
      // for(var item in json){
      //   print("This: "+jsonEncode(item));
      //   listResult.add(PicSumModel.fromJson(item));
      //   print(listResult);
      // }
    }else{
      throw Exception("Error fetching pictures");
    }
  }
}