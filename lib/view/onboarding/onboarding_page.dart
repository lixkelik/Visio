import 'package:visio/constant/constant_builder.dart';

import '../../factory/onboard_factory.dart';
import '../authentication/login_page.dart';
import '../widget/exit_dialog.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {

  late PageController _pageController;
  int _pageIndex = 0;
  
  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);

  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        final shouldExit = showExitDialog(context);
        return shouldExit ?? false;
      },
      child: Scaffold(
        body: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          color: (_pageIndex == 0) ? lightPink : (_pageIndex == 1) ? lightPurple : (_pageIndex == 2) ? lightGreen : (_pageIndex == 3) ? lightBlue : white,
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  physics: const BouncingScrollPhysics(),
                  controller: _pageController,
                  itemCount: onboardData.length,
                  onPageChanged: (index){
                    setState(() {
                      _pageIndex = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    return OnboardController(
                      image: onboardData[index].image,
                      title: onboardData[index].title,
                      description: onboardData[index].description,
                      
                    );
                  }
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    ...List.generate(
                      onboardData.length,
                      (index) => Padding(
                        padding: const EdgeInsets.only(right: 4),
                        child: DotIndicator(
                          isActive: index == _pageIndex,
                        ),
                      )
                    ),
                    const Spacer(),
                    ElevatedButton(
                      onPressed: () {
                        if(_pageIndex == onboardData.length-1){
                          Navigator.pushReplacement(
                            context, MaterialPageRoute(builder: (context) => const LoginPage())
                          );
                        }else{
                          _pageController.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.ease);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: appOrange,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AnimatedOpacity(
                            duration: const Duration(milliseconds: 600),
                            opacity: (_pageIndex == onboardData.length-1)? 1 : 0,
                            child: Text(
                              (_pageIndex == onboardData.length-1) ? "Start" : "",
                              style: styleWSB20,
                            ),
                          ),
                          const SizedBox(width: 5,),
                          const Icon(Icons.arrow_forward_ios_rounded),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}

class DotIndicator extends StatelessWidget {
  const DotIndicator({
    super.key, this.isActive = false,
  });
  final bool isActive;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: (isActive) ? 12 : 5,
      width: (isActive) ? 6 : 5,
      decoration: BoxDecoration(
        color: (isActive) ? appOrange :  const Color(0xff8C8C8C),
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}

class OnboardController extends StatelessWidget {
  const OnboardController({
    super.key, required this.image, required this.title, required this.description,
  });

  final String image, title, description;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const Spacer(),
          Image.asset(image, width: 300, height: 300,),
          const Spacer(),
          Text(
            title,
            style: styleB25,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10,),
          Text(
            description,
            style: const TextStyle(
              fontSize: 18,
              color: Color(0xff747474)
            ),
            textAlign: TextAlign.center,
          ),
          const Spacer(),
        ],
      ),
    );
  }
}