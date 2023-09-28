
import 'package:visio/constant/constant_builder.dart';
import 'package:visio/constant/firebase_constant.dart';
import 'package:visio/factory/game_factory.dart';
import 'package:visio/factory/user_factory.dart';
import 'package:visio/view/peer/success_peer_page.dart';
import 'package:visio/view/repository/firestore_repository.dart';

class DescribePeerPage extends StatefulWidget {
  final Game game;
  final int objectCount;
  final bool isOfficial;
  const DescribePeerPage(this.game, this.objectCount, this.isOfficial, {super.key});

  @override
  State<DescribePeerPage> createState() =>
      _DescribePageState(game, objectCount, isOfficial);
}

class _DescribePageState extends State<DescribePeerPage> {
  Game game;
  int objectCount;
  bool isOfficial;
  UserVisio? user;
  final _formKey = GlobalKey<FormState>();

  _DescribePageState(this.game, this.objectCount, this.isOfficial);

  TextEditingController textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getUserData();
  }

  @override
  void dispose() {
    super.dispose();
    textController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: Container(
          margin: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: appOrange.withOpacity(0.7),
            shape: BoxShape.circle
          ),
          child: IconButton(
            onPressed: (() => Navigator.pop(context)), 
            icon: const Icon(Icons.arrow_back),
            tooltip: MaterialLocalizations.of(context).backButtonTooltip,
            splashRadius: 24,
            color: white,
            padding: EdgeInsets.zero,
            alignment: Alignment.center,
            iconSize: 24,
            enableFeedback: true,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Form(
        key: _formKey,
        child: Stack(children: [
          Transform.rotate(
            angle: isOfficial ? 0 : 3.14 / 2,
            child: SizedBox(
                height: 392.75,
                child: Image.network(game.obj[objectCount].image,
                    fit: BoxFit.cover,
                    key: ValueKey(DateTime.now().millisecondsSinceEpoch),
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  } else {
                    return skeletonBox(double.infinity, 293);
                  }
                })),
          ),
          Align(
              child: DraggableScrollableSheet(
            initialChildSize: 0.65,
            minChildSize: 0.5,
            maxChildSize: 0.65,
            builder: (_, ScrollController scrollController) => Container(
              width: double.maxFinite,
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: SingleChildScrollView(
                controller: scrollController,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: lightBlue,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Describe ${game.obj[objectCount].objName}!',
                              style: styleB30
                            ),
                            const SizedBox(height: 5,),
                            const Text(
                              'What is the color? Shape? Material? Where this object usually belong? Tell me fun fact about this object.',
                              softWrap: true,
                              textAlign: TextAlign.left,
                              style: styleR15
                            ),
                            const SizedBox(height: 15),
                            TextFormField(
                              maxLength: 200,
                              maxLines: null,
                              keyboardType: TextInputType.multiline,
                              controller: textController,
                              decoration: const InputDecoration(
                                fillColor: white,
                                filled: true,
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30))),
                                hintText: 'Type here...',
                              ),
                              validator: (value) {
                                if(value == null || value.isEmpty){
                                  return "Please describe the object first!";
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                      
                      const SizedBox(height: 15),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                            onPressed: () {
                              if(_formKey.currentState!.validate()){
                                String description = textController.text;
                                game.obj[objectCount].colaboratorDesc =
                                    description;
                                if (objectCount < 4) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              // ke page selanjutnya
                                              DescribePeerPage(
                                                  game,
                                                  objectCount + 1,
                                                  isOfficial)));
                                
                                } else {
                                  if(!isOfficial){
                                    game.isPlayed = true;
                                    game.colaboratorUid = user!.uid;
                                    game.playedBy = user!.name;
                                    game.colaboratorTime = Timestamp.now();
                                    saveToFirestore(game);
                                  }
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => SuccessPeerPage(
                                              game) // loading page
                                          ));
                                }
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: appOrange,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            child: const Text('Next!',
                                style: styleWSB25)),
                      ),
                    ]),
              ),
            ),
          )),
        ]),
      ),
    );
  }

  Future<void> _getUserData() async {
    UserVisio user = await getUserData();
    setState(() {
      this.user = user;
    });
  }
}
