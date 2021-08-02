import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvvm_demo/model/picsum_model.dart';
import 'package:mvvm_demo/view_model/list_picture_viewmodel.dart';
import 'package:stacked/stacked.dart';
import 'package:transparent_image/transparent_image.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String clickMe = "Click Me!";
  List<PicSumModel>? data;
  ListPictureViewModel _listPictureViewModel = new ListPictureViewModel();
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ListPictureViewModel>.reactive(
        viewModelBuilder: ()=>ListPictureViewModel(),onModelReady: (vm)=>vm.fetchPictures(),
        builder: (context,vm,child){
      return Scaffold(body:
      vm.isBusy?LinearProgressIndicator()
      :Column(
        children: [
          TextButton(onPressed: (){
            setState(() {
              clickMe = "Clicked !";
            });
          }, child: Text(clickMe)),
          GridView.count(
          shrinkWrap: true,
          crossAxisCount: 2,
          childAspectRatio: 1,
          children: List.generate(vm.pictures!.length, (index) => Container(
          padding: EdgeInsets.all(25),
          color: Colors.grey,
          child:Column(children: [
                  Image.network(
                      "https://line-kw.com/joko/public/storage/${vm.pictures?[index].image}", fit:BoxFit.cover,width: 90,height:90,
                    color: Colors.white,
                  ),
                  SizedBox(height:20),
                  Text("${vm.pictures?[index].title}")
                ],)
            )),
            mainAxisSpacing: 7,
            crossAxisSpacing: 7,
          )
        ],
      ));
    });
  }
  @override
  void initState() {
    super.initState();
  }
  fetchData()async{
    await _listPictureViewModel.fetchPictures();
    setState(() {
      data = _listPictureViewModel.pictures;
    });
}
}
