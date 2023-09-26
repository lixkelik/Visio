import 'package:visio/constant/constant_builder.dart';

class ArticlePeer extends StatelessWidget {
  const ArticlePeer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Funfact Article'),
        backgroundColor: appOrange,
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          // gambar artikel
          Image.asset(articleBg),
          const Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'What is an Airport ?',
                  style: styleB25
                ),
                SizedBox(height: 16.0),
                Text(
                  ''' An airport is a place where airplanes can land or take off. Most airports in the world have only a long strip of level ground called a runway. Many airports have buildings which are used to hold airplanes and passengers. A building that holds passengers waiting for their planes or luggage is called a terminal. The sections between planes and the terminal are called "gates". 
  Airports also have buildings called hangars to hold planes when they are not used. Some airports have buildings to control the airport, like a control tower which tells planes where to go. An international airport is a large airport that airplanes can use to fly to and from other countries. A domestic airport is an airport which is usually smaller and only has airplanes coming from different places in the same country. Most international airports have shops and restaurants for airplane passengers to use.
                  ''',
                  textAlign: TextAlign.justify,
                  style: styleR15
                ),
              ],
            ),
          ),
          // reward biar lucu
          Image.asset(readills, width: 92, height: 113),
          const SizedBox(height: 20),
          const Text(
            "Now you know!",
            style: styleB15
          ),

          const SizedBox(height: 30),
          
          
        ]),
      ),
    );
  }
}
