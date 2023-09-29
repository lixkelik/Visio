import 'package:visio/constant/constant_builder.dart';

class Onboard {
  final String image, title, description;
  Onboard({required this.image, required this.title, required this.description});
}

final List<Onboard> onboardData = [
  Onboard(
    image: splashills, 
    title: 'Hello! Welcome to Visio', 
    description: 'A gamification education app for visually impaired children.'
  ),
  Onboard(
    image: readills, 
    title: 'Learn Collaboratively', 
    description: 'We push visually impaired children to learn collaboratively with their friends about object around them using our technology.'
  ),
  Onboard(
    image: togetherills, 
    title: 'Don\'t have a partner?', 
    description: 'Don\'t worry! Visio has self learning features where children can ask anything they want!'
  ),
  Onboard(
    image: portraitills, 
    title: 'Ready to explore the world ?', 
    description: 'Alot of games and fun ahead! Let\'s learn, explore and socialize!'
  ),
];