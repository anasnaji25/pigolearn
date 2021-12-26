import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pigolearn_round1/controllers/search_controller.dart';
import 'package:pigolearn_round1/data/network/NetworkApiService.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';


class HomeScreen extends StatefulWidget {

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
 SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  String _lastWords = '';




final searchController = Get.find<SearchController>();


 @override
  void initState() {
    super.initState();
    _initSpeech();
  }

  /// This has to happen only once per app
  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  /// Each time to start a speech recognition session
  void _startListening() async {
    await _speechToText.listen(onResult: _onSpeechResult);
    setState(() {});
  }

  
  void _stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }

 
  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _lastWords = result.recognizedWords;
    });

    searchController.searchTheWord(_lastWords);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return  Scaffold(
      appBar: AppBar(
        title: const Text("PingoLearn-Round 1"),
        centerTitle: true,
      ),
      body: Container(
        width: size.width,
        height: size.height,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15,20,15,60),
          child: Obx(() =>  Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:  [
             searchController.searchWord.value == ""? Container(
                height:100,
                width: 300,
                child: const Text("Press the button to start speaking",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,),textAlign: TextAlign.center,)) : 

                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
               const Text("Your word:",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,),textAlign: TextAlign.center,),
                 Text(searchController.searchWord.value,style: const TextStyle(fontSize: 25,fontWeight: FontWeight.bold,),textAlign: TextAlign.center,),
                  
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
                        child: Text(searchController.meaning.value,style: const TextStyle(fontSize: 15,fontWeight: FontWeight.normal,),textAlign: TextAlign.start,),
                      )
                    ],
                  ),
                  color: Colors.grey[200],),

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
                        child: Text(searchController.example.value,style: const TextStyle(fontSize: 15,fontWeight: FontWeight.normal,),textAlign: TextAlign.start,),
                      )
                    ],
                  ),
                  color: Colors.grey[200],),
 const SizedBox(
                   height: 30
                 ),
                  Image.network(searchController.imageUrl.value,height: 150,width: 150,)
                  ],
                ),

               
               
              ElevatedButton(
                child: Icon(Icons.mic),
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(EdgeInsets.all(20)),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.0),
                side: const BorderSide(color: Colors.blue)
                  ),)) ,
                onPressed:  _speechToText.isNotListening ? _startListening : _stopListening,)
            ]
          ), ),
        ),
      )
    );
  }
}