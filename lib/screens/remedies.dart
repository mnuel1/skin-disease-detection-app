import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class RemediesScreen extends StatefulWidget {
  @override
  _RemediesScreenState createState() => _RemediesScreenState();
}

class _RemediesScreenState extends State<RemediesScreen> {
  final List<String> imgList = [
    'assets/ImageCarousel/Basalcellcarcinoma.JPG',
    'assets/ImageCarousel/Dermatofibroma.JPG',
    'assets/ImageCarousel/Melanocyticnevil.JPG',
    'assets/ImageCarousel/Melanoma.JPG',
    'assets/ImageCarousel/Pyogenicgranulomasandhemorrhage.JPG',
    'assets/ImageCarousel/Sebhorrickeratosis.JPG',
  ];

  final List<String> captions = [
    'Basal Cell Carcinoma',
    'Dermatofibroma',
    'Melanocytic Nevil',
    'Melanoma',
    'Pyogenic Granulomas & Hemorrhage',
    'Sebhorric Keratosis',
  ];

  final List<String> headings = [
    'Apply Hydrogen peroxide',
    'Jojoba oil & Vitamin C',
    'Apply Garlic',
    'Frankincense essential ',
    'Table salt & Vaseline',
    'Apply Aloe Vera',
  ];

  final List<String> descriptions = [
    'Patients should apply hydrogen peroxide to the malignant area using a soaked cotton swab until it becomes saturated and white. Cover the cancerous area with another soaked cotton swab and leave it until it dries. Repeat this treatment at least once daily.',
    'Apply a vitamin C and jojoba oil tincture to dermatofibromas three to five times daily, massaging for moisture. Use a quarter-sized amount per dermatofibroma. Before bed, apply plain jojoba oil and massage into the skin.',
    'Carefully position a crushed garlic clove atop the mole, securing it firmly with a bandage. Leave this in place for several hours each day, maintaining this routine over consecutive days for effective results',
    'Prepare a diluted mixture by blending the essential oil with a carrier oil, ensuring a proper ratio for safe topical application. Apply this blend directly to the affected skin area, consistently using it as a supportive measure for skin cancer treatment.',
    'Administer table salt onto the lesion, safeguard surrounding skin using Vaseline, and then cover the treated area with gauze. After a week\'s consistent application, a noticeable reduction occurred, transforming the lesion into a smaller papule.',
    'Utilize a small quantity of aloe vera gel, applying it directly onto the affected region, and gently massage it in. Consistency is key; repeat this process twice daily until the lesions gradually fade away, ensuring diligent and repeated application for optimal results.',
  ];

  final List<String> references = [
    'Star Health',
    'Medical News Today',
    'e Pain Assist',
    'Immunity Therapy Center',
    'National Library of Medicine',
    'Earth Clinic',
  ];

  int currentSlideIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> imageSliders = imgList.asMap().entries.map((entry) {
      final int index = entry.key;
      final String imagePath = entry.value;

      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 20),
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 7,
                offset: Offset(0, 4), // Adjust the offset as needed
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15.0), // Adjust the radius as needed
            child: Stack(
              children: <Widget>[
                Image.asset(imagePath, fit: BoxFit.cover, width: 1000.0),
                Positioned(
                  bottom: 0.5,
                  left: 0.0,
                  right: 0.0,
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color.fromARGB(200, 0, 0, 0),
                          Color.fromARGB(0, 0, 0, 0)
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 20.0,
                    ),
                    child: Text(
                      captions[index],
                      style: Theme.of(context)
                          .textTheme
                          .headline6!
                          .copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }).toList();

    return Scaffold(
      body: Stack(
        children: [
          // Top text widgets
          Positioned(
            top: 30.0,
            left: 16.0,
            right: 16.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.03,
                ),
                Text(
                  'Home Remedies',
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.06,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.01,
                ),
                Text(
                  'Recommendation For You',
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.06,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          // CarouselSlider taking the bottom half of the top screen
          Positioned(
            top: MediaQuery.of(context).size.height * 0.1,
            left: 0,
            right: 0,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.40,
              child: CarouselSlider(
                options: CarouselOptions(
                  aspectRatio: 1.5,
                  viewportFraction: 0.9,
                  enlargeCenterPage: true,
                  enlargeStrategy: CenterPageEnlargeStrategy.height,
                  enableInfiniteScroll: false,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 10),
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  onPageChanged: (index, reason) {
                    setState(() {
                      currentSlideIndex = index;
                    });
                  },
                ),
                items: imageSliders,
              ),
            ),
          ),
          // Additional widgets below the image carousel (headings, descriptions, icons)
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            top: MediaQuery.of(context).size.height * 0.43,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
              decoration: BoxDecoration(
                color: Colors.white12,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey.withOpacity(0.2),
                        ),
                        padding: EdgeInsets.all(8.0),
                        child: const Icon(
                          Icons.local_hospital_outlined,
                          color: Colors.grey,
                          size: 33,
                        ),
                      ),
                      SizedBox(width: 8.0),
                      Text(
                        headings[currentSlideIndex],
                        style: TextStyle(
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Playfair Display',
                        ),
                      ),
                    ],
                  ),
                  Text(
                    descriptions[currentSlideIndex],
                    style: TextStyle(fontSize: 20.0, fontFamily: 'Open Sans'),
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(height: 8.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey.withOpacity(0.2),
                        ),
                        padding: EdgeInsets.all(8.0),
                        child: const Icon(
                          Icons.link_outlined,
                          color: Colors.grey,
                          size: 33,
                        ),
                      ),
                      SizedBox(width: 8.0),
                      Text(
                        references[currentSlideIndex],
                        style: TextStyle(fontSize: 16.0, fontStyle: FontStyle.italic),
                      ),
                    ],
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
