import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pigolearn_round1/controllers/bookmark_controller.dart';
import 'package:pigolearn_round1/controllers/theme_controller.dart';
import 'package:pigolearn_round1/view/history/history_screen.dart';


class DetailPage extends StatefulWidget {
  String word;
  String example;
  String meaning;
  String image;
  String docid;

  DetailPage(this.example,this.meaning,this.image,this.word,this.docid) ;

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
final bookmarkController = Get.find<BookMarkController>();
  final themeCn = Get.find<ThemeController>();


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("PingoLearn Round-2"),
      ),
      body: Container(
        width: size.width,
        height: size.height,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15,20,15,60),
          child: Obx(() => Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:  [
             

                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
               const Text("Your word:",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,),textAlign: TextAlign.center,),
                 Text(widget.word,style: const TextStyle(fontSize: 25,fontWeight: FontWeight.bold,),textAlign: TextAlign.center,),
                  
                 const SizedBox(
                   height: 30
                 ),
                  Container(height: 150,
                  width: 300,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                  const SizedBox(
                   height: 5
                 ),
                      const Text("Meaning",style: TextStyle(fontSize: 19,fontWeight: FontWeight.bold,),),

                         const SizedBox(
                   height: 5
                 ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15,2,15,5),
                        child: Text(widget.meaning,style: const TextStyle(fontSize: 15,fontWeight: FontWeight.normal,),textAlign: TextAlign.start,),
                      )
                    ],
                  ),
                  color: themeCn.isDarkMode.value? Colors.grey[800]: Colors.grey[200],),

                  const SizedBox(
                   height: 30
                 ),

                    Container(height: 100,
                  width: 300,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                        
                  const SizedBox(
                   height: 5
                 ),
                      const Text("Example",style: TextStyle(fontSize: 19,fontWeight: FontWeight.bold,),),

                         const SizedBox(
                   height: 5
                 ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15,2,15,5),
                        child: Text(widget.example,style: const TextStyle(fontSize: 15,fontWeight: FontWeight.normal,),textAlign: TextAlign.start,),
                      )
                    ],
                  ),
                  color: themeCn.isDarkMode.value? Colors.grey[800]: Colors.grey[200],),
                 const SizedBox(
                   height: 30
                 ),
                  widget.image == "" ? Image.asset("assets/images/image_not_found.png",height: 150,width: 150,):  Image.network(  widget.image,height: 150,width: 150,)
                  ],
                ),
              ElevatedButton(
                child: const Icon(Icons.delete,color: Colors.white),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all( Colors.red),
                  padding: MaterialStateProperty.all(const EdgeInsets.all(20)),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.0),
                side: const BorderSide(color: Colors.red)
                  ),)) ,
                onPressed:  (){
                  bookmarkController.deleteFromBookMarks(widget.docid);
                  Get.off(HistoryScreen());
                })
            ]
          ))
        ),
      ),
    );
  }
}