import 'package:flutter/material.dart';
import 'package:mvvm_demo/model/picsum_model.dart';
import 'package:mvvm_demo/services/services.dart';
import 'package:stacked/stacked.dart';

class ListPictureViewModel extends BaseViewModel{
  List<PicSumModel>? pictures;
  String? message;
  Future<void> fetchPictures()async{
    setBusy(true);
    final apiResult = await Services().fetchPicturesApi();
    if(apiResult['success']){
      pictures = apiResult['data'].map<PicSumModel>((e)=>PicSumModel.fromJson(e)).toList();
      // pictures = apiResult['data'].map((e)=>PicSumModel.fromJson(e)).toList() as List<PicSumModel>;
    }else{
      message = apiResult['message'];
    }
    setBusy(false);
    // notifyListeners();
    // this.pictures = apiResult.map((e) => PicSumModel.fromJson(e)).toList();
  }
}