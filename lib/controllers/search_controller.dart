
// ignore_for_file: use_function_type_syntax_for_parameters

import 'package:get/get.dart';
import 'package:pigolearn_round1/controllers/bookmark_controller.dart';
import 'package:pigolearn_round1/data/network/NetworkApiService.dart';

class SearchController extends GetxController{


RxString searchWord = "".obs;
RxString meaning = "".obs;
RxString example = "".obs;
RxString imageUrl = "".obs;

  
NetworkApiService networkApiService = NetworkApiService();
final bookmarkController = Get.find<BookMarkController>();



  searchTheWord(String keyword){
   var response =  networkApiService.getResponse(keyword);
    response.then((value) {
      searchWord(value["word"]);
     value["definitions"][0]["definition"] == null ? meaning(""): meaning(value["definitions"][0]["definition"]);
     value["definitions"][0]["example"] == null ?example(""): example(value["definitions"][0]["example"]);
     value["definitions"][0]["image_url"] ==null ? imageUrl(""):  imageUrl(value["definitions"][0]["image_url"]);
     bookmarkController.isItemBookMarked(false);
    });
  }

}