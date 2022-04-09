import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:vimigo_technical_assessment/screens/sortable_list.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const HomePage()),
    );
  }

  Widget _buildFullscreenImage() {
    return Image.asset(
      'assets/img-1.png',
      fit: BoxFit.cover,
      height: double.infinity,
      width: double.infinity,
      alignment: Alignment.center,
    );
  }

  Widget _buildImage(String assetName, [double width = 350]) {
    return Image.asset('assets/$assetName', width: width);
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0);

    const pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      bodyPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
      key: introKey,
      globalFooter: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomRight,
            end: Alignment.topLeft,
            stops: [0.0, 1.0],
            colors: [Colors.blue, Colors.green],
          ),
        ),
        child: SizedBox(
          width: double.infinity,
          height: 60,
          child: ElevatedButton(
            style: ButtonStyle(
              minimumSize: MaterialStateProperty.all(Size(double.infinity, 60)),
              backgroundColor: MaterialStateProperty.all(Colors.transparent),
            ),
            child: const Text(
              'Let\'s go right away!',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            onPressed: () => _onIntroEnd(context),
          ),
        ),
      ),
      pages: [
        PageViewModel(
          title: "Welcome to Contacts App!",
          body: "Follow the screens to learn more about the app.",
          image: _buildImage('welcome-message.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "View contacts",
          body: "You can view a list of all available contacts.",
          image: _buildImage('img-2.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "View contact details",
          body:
              "If you'd like to know more details about a contact, you may click on the contact's name from the list.",
          image: _buildImage('img-1.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Creating a new contact",
          body:
              "If you'd like to add a new contact, simply click on the plus '+' icon and add the new contact's details.",
          image: _buildImage('img-3.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "You've reached the end of the tutorial!",
          body:
              "If you'd like to repeat the tutorial, click on 'Start again' button.",
          image: _buildImage('img-2.png'),
          footer: ElevatedButton(
            onPressed: () {
              introKey.currentState?.animateScroll(0);
            },
            child: const Text(
              'Start again',
              style: TextStyle(color: Colors.white),
            ),
            style: ElevatedButton.styleFrom(
              primary: Colors.lightGreen,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
          decoration: pageDecoration,
        ),
      ],
      onDone: () => _onIntroEnd(context),
      skipOrBackFlex: 0,
      nextFlex: 0,
      showBackButton: true,
      back: Icon(
        Icons.arrow_back,
      ),
      next: Icon(Icons.arrow_forward),
      done: Text('Done', style: TextStyle(fontWeight: FontWeight.w600)),
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: const EdgeInsets.all(16),
      controlsPadding: kIsWeb
          ? const EdgeInsets.all(12.0)
          : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
      dotsContainerDecorator: const ShapeDecoration(
        color: Colors.black87,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contacts App',
      home: SortablePage(),
    );
  }
}
