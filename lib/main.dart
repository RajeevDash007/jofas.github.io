import 'dart:math' as math;

import 'package:flutter/material.dart' hide Spacer, Page;
import 'package:flutter/gestures.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'src/colors.dart' show CustomColors;
import 'src/logo.dart' show Logo;
import 'src/navbar.dart' show Navbar, OpenNavbarButton;
import 'src/scroll_progress_bar.dart' show ScrollProgressBar;
import 'src/util.dart'
    show openLink, Spacer, Page, PageContent, Tile, Link, InlineLink;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final PageController pageController = PageController();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints viewport) {
        final screenSize = math.min(
          viewport.maxWidth,
          viewport.maxHeight,
        );

        late final fontSizeBody;
        late final fontSizeCaption;
        late final fontSizeHeadline;
        late final iconSize;
        late final textButtonSize;
        late final headlineSpace;
        late final paragraphSpace;
        late final appbarLogoSize;
        late final navbarLogoSize;
        late final navbarLogoPadding;

        if (screenSize <= 640) {
          fontSizeBody = 12;
          fontSizeCaption = 8;
          fontSizeHeadline = 24;
          iconSize = 30;
          textButtonSize = 8;
          headlineSpace = 10;
          paragraphSpace = 20;
          appbarLogoSize = 12;
          navbarLogoSize = 60;
          navbarLogoPadding = 10;
        } else if (screenSize <= 768) {
          fontSizeBody = 16;
          fontSizeCaption = 10;
          fontSizeHeadline = 40;
          iconSize = 50;
          textButtonSize = 10;
          headlineSpace = 20;
          paragraphSpace = 30;
          appbarLogoSize = 20;
          navbarLogoSize = 80;
          navbarLogoPadding = 15;
        } else {
          fontSizeBody = 20;
          fontSizeCaption = 12;
          fontSizeHeadline = 60;
          iconSize = 70;
          textButtonSize = 12;
          headlineSpace = 30;
          paragraphSpace = 40;
          appbarLogoSize = 24;
          navbarLogoSize = 100;
          navbarLogoPadding = 20;
        }

        return MaterialApp(
          title: 'Jonas Fassbender',
          theme: ThemeData(
            primaryColor: Colors.white,
            textTheme: TextTheme(
              bodyText2: TextStyle(
                color: Colors.white,
                fontSize: fontSizeBody,
                height: 1.5,
                letterSpacing: 1,
              ),
              headline2: TextStyle(
                color: Colors.white,
                fontSize: fontSizeHeadline,
                letterSpacing: 5,
              ),
              caption: TextStyle(
                color: Colors.white,
                fontSize: fontSizeCaption,
                letterSpacing: 1,
              ),
              labelMedium: TextStyle(
                color: Colors.black,
                fontSize: 14,
              ),
            ),
            appBarTheme: AppBarTheme(
              color: Colors.white,
              elevation: 0,
            ),
            bottomAppBarTheme: BottomAppBarTheme(
              color: Colors.white,
              elevation: 0,
            ),
            iconTheme: IconThemeData(
              color: Colors.white,
              size: iconSize,
            ),
            dividerTheme: DividerThemeData(
              color: Colors.black,
              thickness: 2,
            ),
            textButtonTheme: TextButtonThemeData(
              style: ButtonStyle(
                padding: MaterialStateProperty.all<EdgeInsets?>(
                  EdgeInsets.symmetric(horizontal: 10),
                ),
                minimumSize: MaterialStateProperty.all<Size?>(Size(0, 0)),
                overlayColor: MaterialStateProperty.all<Color?>(
                  Colors.white.withOpacity(0),
                ),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                textStyle: MaterialStateProperty.resolveWith<TextStyle?>((
                  Set<MaterialState> states,
                ) {
                  final base = Theme.of(context).textTheme.bodyText2!.copyWith(
                        fontSize: textButtonSize,
                      );

                  if (states.contains(MaterialState.focused)) {
                    return base.copyWith(
                      decoration: TextDecoration.underline,
                    );
                  }
                  return base;
                }),
              ),
            ),
          ),
          scrollBehavior: ScrollBehavior().copyWith(
            scrollbars: false,
            dragDevices: {
              PointerDeviceKind.touch,
              PointerDeviceKind.mouse,
              PointerDeviceKind.stylus,
            },
          ),
          home: MyHomePage(
            width: viewport.maxWidth,
            height: viewport.maxHeight,
            pageController: pageController,
            headlineSpace: headlineSpace,
            paragraphSpace: paragraphSpace,
            appbarLogoSize: appbarLogoSize,
            navbarLogoSize: navbarLogoSize,
            navbarLogoPadding: navbarLogoPadding,
          ),
        );
      },
    );
  }
}

class MyHomePage extends StatelessWidget {
  static const int NUM_PAGES = 7;
  static const double MAX_CONTENT_WIDTH = 1536;

  final PageController pageController;
  final double width, height;

  final double headlineSpace;
  final double paragraphSpace;
  final double appbarLogoSize;
  final double navbarLogoSize;
  final double navbarLogoPadding;

  MyHomePage({
    required this.width,
    required this.height,
    required this.pageController,
    required this.headlineSpace,
    required this.paragraphSpace,
    required this.appbarLogoSize,
    required this.navbarLogoSize,
    required this.navbarLogoPadding,
  });

  double get _contentWidth {
    return width > MAX_CONTENT_WIDTH ? MAX_CONTENT_WIDTH : width;
  }

  Widget _headlineSpace() {
    return Spacer(height: headlineSpace);
  }

  Widget _paragraphSpace() {
    return Spacer(height: paragraphSpace);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: OpenNavbarButton(size: appbarLogoSize),
        title: Center(
          child: SizedBox(
            height: appbarLogoSize,
            width: appbarLogoSize,
            child: Logo(color: Colors.black),
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text("GITHUB"),
            onPressed: () {
              openLink("https://github.com/jofas");
            },
          ),
          TextButton(
            child: const Text("GITLAB"),
            onPressed: () {
              openLink("https://gitlab.com/jofas");
            },
          ),
          TextButton(
            child: const Text("RÉSUMÉ"),
            onPressed: () {
              openLink("resume.pdf");
            },
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: ScrollProgressBar(
            controller: pageController,
            pages: NUM_PAGES,
          ),
        ),
      ),
      drawer: Navbar(
        controller: pageController,
        logoPadding: navbarLogoPadding,
        logoSize: navbarLogoSize,
      ),
      body: PageView(
        controller: pageController,
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Page(
            colors: <Color>[
              CustomColors.green[700]!,
              CustomColors.green[800]!,
            ],
            child: PageContent(
              width: _contentWidth,
              padding: EdgeInsets.all(16),
              children: <Widget>[
                Text(
                  "Jonas Fassbender",
                  style: Theme.of(context).textTheme.headline2,
                  textAlign: TextAlign.center,
                ),
                _headlineSpace(),
                Text(
                  "Software engineer and freelancer. In love with the craft.",
                  textAlign: TextAlign.center,
                ),
                _paragraphSpace(),
                Text(
                  "In the summer of 2015 I wrote my first program (a Windows Forms app written in VB.NET, believe it or not). Over the course of that fateful summer I quickly became so deeply enamored with programming that I made it my profession.",
                  textAlign: TextAlign.center,
                ),
                _paragraphSpace(),
                Text(
                  "Since then I've successfully attained two higher education degrees in computing, lived in two countries, became a freelancer and open source contributor, created and maintained a microservice application with over seventy thousand lines of code all by myself, programmed supercomputers including a neuromorphic one with over one million cores (SpiNNaker), tried to teach machines how to see and how to conservatively predict whether a loan request is likely to default, learned a lot, failed many times and had the time of my life doing it all.",
                  textAlign: TextAlign.center,
                ),
                _paragraphSpace(),
                Text.rich(
                  TextSpan(
                    children: <InlineSpan>[
                      TextSpan(
                        text:
                            "This wesite serves as an introduction to myself, my work and the values it embodies. If you like what you see and think I could help you achive your ambitions, don't hesitate to ",
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      InlineLink(
                        text: "contact",
                        url:
                            "mailto://jonas@fassbender.dev?subject=Hi%20There!",
                        style: Theme.of(context).textTheme.bodyText2!,
                      ),
                      TextSpan(
                        text: " me!",
                        style: Theme.of(context).textTheme.bodyText2!,
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          Page(
            colors: <Color>[
              CustomColors.green[800]!,
              CustomColors.blue[800]!,
            ],
            child: PageContent(
              width: _contentWidth,
              padding: EdgeInsets.all(16),
              children: <Widget>[
                Text(
                  "Key Competencies",
                  style: Theme.of(context).textTheme.headline2,
                  textAlign: TextAlign.center,
                ),
                _headlineSpace(),
                Text(
                  "What I can do to help you successfully realize your idea and mold it into software:",
                  textAlign: TextAlign.center,
                ),
                _paragraphSpace(),
                Tile(
                  icon: Icons.architecture,
                  title: "Software Architecture.",
                  content:
                      "Microservices or a monolith? On-premises, cloud, hybrid or multi-cloud? Which 3rd-party vendors or open source technologies fit best? Together we will figure that out. We will deconstruct your problem using Domain Driven Design and create a scalable and maintainable application for you.",
                ),
                _paragraphSpace(),
                Tile(
                  icon: Icons.code,
                  title: "Clean Code.",
                  content:
                      "A maintainable software project that will run for a long time may start with a good, domain-driven architecture. But in the end, it's about the implementation. Let's make the internet a tiny bit better by writing well-tested and easy-to-read code to prevent the next big data leak.",
                ),
                _paragraphSpace(),
                Tile(
                  icon: Icons.lan,
                  title: "Distributed Systems.",
                  content:
                      "High performance and high availability computing is fun. Unfortunately, distributed systems are still very complex. It's hard to figure out communication, synchronization and fault tolerance. Together we will scale up your system while keeping track of all the moving parts.",
                ),
                _paragraphSpace(),
                Tile(
                  icon: Icons.smart_toy,
                  title: "Machine Learning.",
                  content:
                      "The idea of teaching computers how to solve complex tasks from data is very alluring and shows promising results. Having experience with supervised machine learning and conformal prediction on real-world data sets, I'd love to teach computers to make descisions based on your data.",
                ),
                _paragraphSpace(),
                Tile(
                  icon: Icons.devices,
                  title: "Cross Platform.",
                  content:
                      "In the end, software is all about people. And most people interact with computers through a graphical user interface. Having experience with Flutter and Material Design in production, I can help you get your Flutter app off the ground and reach your clients on every device.",
                ),
              ],
            ),
          ),
          Page(
            colors: <Color>[
              CustomColors.blue[800]!,
              CustomColors.purple[800]!,
            ],
            child: PageContent(
              width: _contentWidth,
              padding: EdgeInsets.all(16),
              children: <Widget>[
                Text(
                  "Core Values",
                  style: Theme.of(context).textTheme.headline2,
                  textAlign: TextAlign.center,
                ),
                _headlineSpace(),
                Text(
                  "Software engineering is an idealistic endeavor. I became a freelancer, partly because I didn't want to compromise on what I think software should be. To create synergies and subsequently an environment that fosters collaboration and creativity, core values must match.",
                  textAlign: TextAlign.center,
                ),
                _paragraphSpace(),
                Tile(
                  icon: Icons.spa,
                  title: "Care.",
                  content:
                      "My code, my responsibility. Bugs in production are annoying and potentially dangerous. Mistakes should be caught as early in the development cycle as possible. Not only to prevent security issues, but also from the standpoint of cost. Two days spent on a decent test suite today has the potential of saving a lot of time and money tomorrow.",
                ),
                _paragraphSpace(),
                Tile(
                  icon: Icons.lightbulb,
                  title: "Curiousness.",
                  content:
                      "Software engineering has a lot to do with gut feeling. Sometimes you find ideas along the way that feel like they have the potential of creating something amazing. Instead of rigidly focusing on the backlog, I believe these ideas have to be explored immediately. I give myself the freedom to do so.",
                ),
                _paragraphSpace(),
                Tile(
                  icon: Icons.data_object,
                  title: "Minimalism.",
                  content:
                      "Deleting code is better than writing it. Feature creep and decay result in software that dies before it should, a very costly event. I apply teachings from the Extreme Programming and UNIX philosophies to my work. My focus lies on creating lean, extensible, decoupled and long-living software. If I think a feature does not fit these design principles, I will tell you so and I expect you to be open to negotiation.",
                ),
                _paragraphSpace(),
                Tile(
                  icon: Icons.done,
                  title: "Thoroughness.",
                  content:
                      "Deadlines are artificial constructs. Estimates are faulty and seldom correct. A billion dollar industry has evolved to solve these problems that really aren't problems but just paper tigers. I refuse to partake in this hoax as much as I can, focusing on my work, on doing it the right way, rather than getting caught up in this wasteful game.",
                ),
              ],
            ),
          ),
          Page(
            colors: <Color>[
              CustomColors.purple[800]!,
              CustomColors.violet[800]!,
            ],
            child: PageContent(
              width: _contentWidth,
              padding: EdgeInsets.all(16),
              children: <Widget>[
                Text(
                  "Professional Projects",
                  style: Theme.of(context).textTheme.headline2,
                  textAlign: TextAlign.center,
                ),
                _headlineSpace(),
                Text(
                  "The main projects I am working on or have worked on as a freelancing software engineer:",
                  textAlign: TextAlign.center,
                ),
                _paragraphSpace(),
                Tile(
                  icon: Icons.directions_car,
                  title: "Carpolice.de.",
                  titleUrl: "https://carpolice.de",
                  content:
                      "The carpolice.de InsurTech platform serves car dealers who want to provide their customers with an all-inclusive offer including car insurance. Carpolice.de provides car dealers with an easy-to-use system for selling insurance products specially designed for car dealerships.",
                ),
                _paragraphSpace(),
                Tile(
                  icon: Icons.school,
                  title: "German Sport Univerity Cologne.",
                  titleUrl: "https://www.dshs-koeln.de",
                  content:
                      "Written the technical domain specification for an application enabling teachers to generate rich semester plans applying inquiry-based learning. The tool should guide teachers through the generation steps with the help of a recommendation system. Currently in the stage of raising funds for the development.",
                ),
                _paragraphSpace(),
                Tile(
                  icon: Icons.account_balance,
                  title: "Undisclosed German bank.",
                  titleUrl: "cp_for_loan_approval_prediction.pdf",
                  content:
                      "Applied an adaptation of the conformal prediction method to the consumer loan data of a German bank. The goal was to save the bank money by rejecting loan requests likely to default as early in the approval process as possible. 17% of all declined requests were filtered out by the algorithm while retaining an accuracy of 98%.",
                ),
              ],
            ),
          ),
          Page(
            colors: <Color>[
              CustomColors.violet[800]!,
              CustomColors.red[800]!,
            ],
            child: PageContent(
              width: _contentWidth,
              padding: EdgeInsets.all(16),
              children: <Widget>[
                Text(
                  "Open Source",
                  style: Theme.of(context).textTheme.headline2,
                  textAlign: TextAlign.center,
                ),
                _headlineSpace(),
                Text(
                  "Open source projects I am currently working on:",
                  textAlign: TextAlign.center,
                ),
                _paragraphSpace(),
                Tile(
                  icon: FontAwesomeIcons.rust,
                  title: "My Rust crates.",
                  titleUrl: "https://crates.io/users/jofas",
                  content:
                      "Mainly declarative and procedural macros, serde and actix-web related utility crates.  Browse through them and hopefully you'll find something that can help you with your Rust project.",
                ),
                _paragraphSpace(),
                Tile(
                  icon: Icons.brush,
                  title: "Mgart.",
                  titleUrl: "https://github.com/jofas/mgart",
                  content:
                      "Pronounced \"em-gart.\" I find the beauty of mathematical structures and algorithms very enticing. So I build a program that lets you generate your own algorithmic art with a simple-to-use declarative API.",
                ),
                _paragraphSpace(),
                Tile(
                  icon: Icons.receipt_long,
                  title: "BAREKEEPER.",
                  titleUrl: "https://github.com/jofas/BAREKEEPER",
                  content:
                      "As a freelancer, you have several options when it comes to making your taxes and other business needs, like invoicing or hour tracking. None fit my needs, so I created a free bare-metal tool where you have full control over your data. Best part? You don't even have to leave your terminal.",
                ),
              ],
            ),
          ),
          Page(
            colors: <Color>[
              CustomColors.red[800]!,
              CustomColors.orange[800]!,
            ],
            child: PageContent(
              width: _contentWidth,
              padding: EdgeInsets.all(16),
              children: <Widget>[
                Text(
                  "Personal Pursuits",
                  style: Theme.of(context).textTheme.headline2,
                  textAlign: TextAlign.center,
                ),
                _headlineSpace(),
                Text(
                  "Besides honing my skills as a software engineer and professional I particularly enjoy the following activities:",
                  textAlign: TextAlign.center,
                ),
                _paragraphSpace(),
                Tile(
                  icon: Icons.self_improvement,
                  title: "Meditation.",
                  content:
                      "I meditate to find truth and experience freedom, calmness and peace of mind.",
                ),
                _paragraphSpace(),
                Tile(
                  icon: Icons.science,
                  title: "Fermentation.",
                  content:
                      "Kimchi, sauerkraut, hot sauce or veggies. There is no greater joy than eating a slice of freshly made sourdough bread.",
                ),
                _paragraphSpace(),
                Tile(
                  icon: Icons.hiking,
                  title: "Long distance hiking.",
                  content: "My goal is to one day walk a 2000 mile trail.",
                ),
                _paragraphSpace(),
                Tile(
                  icon: Icons.fitness_center,
                  title: "Olympic weightlifting.",
                  content:
                      "Few sports combine strength, speed and overall athleticism in such an aesthetic and rewarding way.",
                ),
              ],
            ),
          ),
          Page(
            colors: <Color>[
              CustomColors.orange[800]!,
              CustomColors.yellow[800]!,
            ],
            child: PageContent(
              width: _contentWidth,
              padding: EdgeInsets.all(16),
              children: <Widget>[
                Text(
                  "Contact",
                  style: Theme.of(context).textTheme.headline2,
                  textAlign: TextAlign.center,
                ),
                _headlineSpace(),
                Text(
                  "If you are interested in collaborating on a project, be that professional work or open source, feel free to write me an email.",
                  textAlign: TextAlign.center,
                ),
                _paragraphSpace(),
                Text(
                  "If you got something funny or wholesome and wish to share it with me, do so as well.",
                  textAlign: TextAlign.center,
                ),
                _paragraphSpace(),
                Link(
                  text: "jonas@fassbender.dev",
                  url: "mailto://jonas@fassbender.dev?subject=Hi%20There!",
                  style: Theme.of(context).textTheme.bodyText2!,
                  textAlign: TextAlign.center,
                ),
              ],
              footer: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Link(
                    text: "Imprint (DE)",
                    url: "imprint.html",
                    style: Theme.of(context).textTheme.caption!,
                  ),
                  Spacer(width: 40),
                  Link(
                    text: "Privacy Policy (DE)",
                    url: "privacy_policy.html",
                    style: Theme.of(context).textTheme.caption!,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
