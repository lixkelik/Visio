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
      height: 138,
      margin: const EdgeInsets.only(bottom: 15),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: appOrange
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
            child: Image.network(
              gameObj.obj[0].image,
              width: 85,
              height: 138,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => const SizedBox(
                width: 85,
                child: Center(
                  child: Text(
                    'Error',
                    style: TextStyle(
                      color: Color.fromARGB(255, 174, 174, 174)
                    ),
                  ),
                ),
              ),
              loadingBuilder: (context, child, loadingProgress){
                if (loadingProgress == null) {
                  return child;
                } else {
                  return Container(
                    width: 85,
                    color: const Color.fromARGB(255, 214, 214, 214),
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
              },
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: speakCode,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 4),
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
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                       Navigator.push(context, MaterialPageRoute(builder: (context) => ReviewPage(gameObj, 0, uid, 1)));
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                          color: green,
                          borderRadius: BorderRadius.only(bottomRight: Radius.circular(10))
                        ),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 7),
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
                                size: 40,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
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