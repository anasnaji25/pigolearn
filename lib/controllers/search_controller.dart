




import 'package:get/get.dart';
import 'package:pigolearn_round1/data/network/NetworkApiService.dart';

class SearchController extends GetxController{


RxString searchWord = "".obs;
RxString meaning = "".obs;
RxString example = "".obs;
RxString imageUrl = "".obs;

  
NetworkApiService networkApiService = NetworkApiService();


  searchTheWord(String keyword){
   var response =  networkApiService.getResponse(keyword);
  

    response.then((value) {
      
searchWord(value["word"]);
meaning(value["definitions"][0]["definition"]);
example(value["definitions"][0]["example"]);
imageUrl(value["definitions"][0]["image_url"]);
      print(value["definitions"][0]["definition"]);



    });



  }







 
  


}