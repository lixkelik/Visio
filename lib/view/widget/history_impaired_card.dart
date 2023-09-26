import 'package:visio/constant/constant_builder.dart';
import 'package:visio/factory/game_factory.dart';
import 'package:intl/intl.dart';
import 'package:visio/view/impaired/texttospeech.dart';
import 'package:visio/view/review_page.dart';

class HistoryImpairedCard extends StatelessWidget {
  final Game gameObj;
  final String uid;
  const HistoryImpairedCard(this.gameObj, this.uid, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 15),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(30)),
        color: appOrange
      ),
      child: InkWell(
        onTap: speakCode,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        gameObj.place,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                        ),
                      ),
                      const SizedBox(width: 10,),
                      (gameObj.isPlayed)
                      ? const Icon(
                          Icons.verified_rounded,
                          color: Color(0xff39E257),
                        )
                      : const Icon(
                        Icons.cancel_rounded,
                        color: Colors.white,
                      )
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.history,
                        color: Colors.white,
                        size: 18,
                      ),
                      const SizedBox(width: 6,),
                      Text(
                        DateFormat('dd-MMMM-yyyy, HH:mm').format(gameObj.createdTime.toDate()),
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.white
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 7,),
                  Text(
                    'Collaborator: ${gameObj.playedBy}',
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12
                    )
                  ),
                  Text(
                    'Code: ${gameObj.code}',
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14
                    )
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
               Navigator.push(context, MaterialPageRoute(builder: (context) => ReviewPage(gameObj, 0, uid, 1)));
              },
              child: Container(
                decoration: const BoxDecoration(
                  color: green,
                  borderRadius: BorderRadius.only(bottomRight: Radius.circular(30), bottomLeft: Radius.circular(30)),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'See Result',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                        )
                      ),
                      SizedBox(width: 10,),
                      Icon(
                        Icons.arrow_right_rounded,
                        color: Colors.white,
                        size: 50,
                        
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void speakCode(){
    if(gameObj.isPlayed == true){
      textToSpeech('Your game has played by ${gameObj.playedBy}! See result to see their answer!');
    }else{
      textToSpeech('The game code is, ${gameObj.code}! Give it to your friends!');
    }
    
  }
}