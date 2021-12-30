import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pigolearn_round1/controllers/bookmark_controller.dart';
import 'package:pigolearn_round1/values/app_fonts.dart';
import 'package:pigolearn_round1/view/history/detail_page.dart';



class HistoryScreen extends StatefulWidget {
  HistoryScreen({Key? key}) : super(key: key);

  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
final bookmarkController = Get.find<BookMarkController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("History"),
        centerTitle: true,
      ),
     body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>> (
       stream: bookmarkController.getBookMarks(),
       builder: (context, snapshot) {
         print("Works here....");
        if( snapshot.hasError){
          return const Center(
            child: Text("Something went wrong"),
          );
        }else if(snapshot.connectionState == ConnectionState.waiting){
         return const Center(
            child: CircularProgressIndicator(),
          );
        }else{
         return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(15,5,15,5),
                child: InkWell(
                  onTap: (){
                    Get.to(DetailPage(
                      snapshot.data!.docs[index]["example"],
                      snapshot.data!.docs[index]["meaning"],
                      snapshot.data!.docs[index]["image"],
                      snapshot.data!.docs[index]["word"],
                      snapshot.data!.docs[index].id,
                    ));
                  },
                  child: Container(
                    height: 80,
                       decoration: const BoxDecoration(
                         
                         borderRadius: BorderRadius.all(Radius.circular(25))
                       ),
                       child: Card(
                         elevation: 3,
                         child:  Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            
                            children: [
                              const SizedBox(width: 10,),
                              snapshot.data!.docs[index]["image"] == ""?  Container(width: 50,
                                                        height: 50,
                                                        decoration: const BoxDecoration(
                                                            shape: BoxShape.circle,
                                                            image: DecorationImage(
                                                                image: AssetImage(
                                                                    "assets/images/image_not_found.png"),
                                                                fit: BoxFit.cover)),
                                                    ):  Container(width: 50,
                                                        height: 50,
                                                        decoration:  BoxDecoration(
                                                            shape: BoxShape.circle,
                                                            image: DecorationImage(
                                                                image: NetworkImage(
                                                                    snapshot.data!.docs[index]["image"]),
                                                                fit: BoxFit.cover)),
                                                    ),
                     
                                                    const SizedBox(width: 10,),
                     
                                                    Text(snapshot.data!.docs[index]["word"],style: khistoryNameStyle,)
                     
                            ],
                          ),
                     
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: InkWell(
                              onTap: (){bookmarkController.deleteFromBookMarks(snapshot.data!.docs[index].id);},
                              child: const Icon(Icons.delete,color:Colors.red)),
                          )
                             
                         ],
                       ),)
                     ),
                ),
              );
            },
          );
        }
       }
     ),
    );
  }
}