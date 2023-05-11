import 'package:flutter/material.dart';

//-----GLOBAL VARIABLES-----
final Color mainColor = Color(0xFFFF5656);

final List<MountModel> mountItems = [
  MountModel(
      path:
          'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/06/1d/51/2c/mount-semeru-volcano.jpg?w=1200&h=-1&s=1',
      name: 'Mount Semeru',
      description:
          'Semeru, or Mount Semeru, is an active volcano in East Java, Indonesia. It is located in the subduction zone, where the Indo-Australia plate subducts under the Eurasia plate. It is the highest mountain on the island of Java.',
      location: 'East Java'),
  MountModel(
      path:
          'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/0f/04/fa/82/view-sabana-1-2.jpg?w=1200&h=-1&s=1',
      name: 'Mount Merbaru',
      description:
          'Mount Merbabu is a dormant stratovolcano in Central Java province on the Indonesian island of Java. The name Merbabu could be loosely translated as Mountain of Ash from the Javanese combined words; Meru means mountain and awu or abu means ash.',
      location: 'Central Java'),
  MountModel(
      path:
          'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/10/6d/1c/4d/mauna-loa-helicopters.jpg?w=1100&h=-1&s=1',
      name: 'Mauna Loa',
      description:
          'Mauna Loa is one of five volcanoes that form the Island of Hawaii in the U.S. state of Hawai in the Pacific Ocean. The largest subaerial volcano in both mass and volume, Mauna Loa has historically been considered the largest volcano on Earth, dwarfed only by Tamu Massif.',
      location: 'Hawaii'),
  MountModel(
      path:
          'https://media-cdn.tripadvisor.com/media/attractions-splice-spp-720x480/06/e6/b3/e9.jpg',
      name: 'Mount Vesuvius',
      description:
          'Mount Vesuvius is a somma-stratovolcano located on the Gulf of Naples in Campania, Italy, about 9 km east of Naples and a short distance from the shore. It is one of several volcanoes which form the Campanian volcanic arc.',
      location: 'Italy'),
  MountModel(
      path:
          'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/13/34/97/65/fujisan-view-from-fujiyoshida.jpg?w=1200&h=-1&s=1',
      name: 'Mount Fuji',
      description:
          'Mount Fuji, Japanese Fuji-san, also spelled Fujisan, also called Fujiyama or Fuji no Yama, highest mountain in Japan. It rises to 12,388 feet (3,776 metres).',
      location: 'Japan')
];

final List<CategoryModel> categories = [
  CategoryModel(category: 'Mountain', icon: Icons.terrain),
  CategoryModel(category: 'Forest', icon: Icons.park),
  CategoryModel(category: 'Beach', icon: Icons.beach_access),
  CategoryModel(category: 'Hiking', icon: Icons.directions_walk)
];

//-----MAIN METHOD-----
void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashPage(),
    ),
  );
}

//-----PAGES-----
// splash page
class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => MountsApp()));
    });

    return Container(
      color: mainColor,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Icon(Icons.terrain, color: Colors.white, size: 90),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: EdgeInsets.only(bottom: 80),
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// landing page
class MountsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Center(child: Icon(Icons.terrain, color: mainColor, size: 40)),
        actions: [SizedBox(width: 40, height: 40)],
        iconTheme: IconThemeData(color: mainColor),
      ),
      drawer: Drawer(
        child: Container(
          padding: EdgeInsets.all(30),
          color: mainColor,
          alignment: Alignment.bottomLeft,
          child: Icon(Icons.terrain, color: Colors.white, size: 80),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppHeader(),
          AppSearch(),
          Expanded(child: AppMountListView()),
          AppCategoryList(),
          AppBottomBar()
        ],
      ),
    );
  }
}

//details page
class DetailsPage extends StatelessWidget {
  MountModel mount;
  DetailsPage(this.mount, {super.key});

  @override
  Widget build(BuildContext context) {
    var selectedItem = mount;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
              child: Stack(
                children: [
                  Container(
                    padding: EdgeInsets.all(30),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(selectedItem.path),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.7),
                          ],
                          begin: Alignment.center,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 30,
                    left: 30,
                    right: 0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          selectedItem.name,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          selectedItem.location,
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                  AppBar(
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                    iconTheme: IconThemeData(color: Colors.white),
                    title: Center(
                      child: Icon(Icons.terrain, color: Colors.white, size: 40),
                    ),
                    actions: [
                      Container(
                        margin: EdgeInsets.only(right: 10),
                        child:
                            Icon(Icons.pending, color: Colors.white, size: 30),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Column(
              children: [
                DetailsRatingBar(),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, bottom: 20),
                        child: Text(
                          'About ${selectedItem.name}',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(left: 20, right: 20, bottom: 20),
                        child: Text('${selectedItem.description}',
                            style: TextStyle(fontSize: 12)),
                      ),
                    ],
                  ),
                ),
                DetailsBottomActions(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

//-----WIDGETS-----

class DetailsBottomActions extends StatelessWidget {
  const DetailsBottomActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
      child: Row(
        children: [
          Expanded(
            child: Material(
              borderRadius: BorderRadius.circular(15),
              color: mainColor,
              child: InkWell(
                highlightColor: Colors.white.withOpacity(0.2),
                splashColor: Colors.white.withOpacity(0.2),
                onTap: () {},
                child: Container(
                  padding: EdgeInsets.all(21),
                  child: Text(
                    'Book Now',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 10),
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
              border: Border.all(color: mainColor, width: 2),
            ),
            child: Icon(Icons.turned_in_not, color: mainColor, size: 25),
          ),
        ],
      ),
    );
  }
}

class AppHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 30, top: 30, right: 30),
      child: Row(
        children: [
          ClipOval(
            child: Image.network(
                'https://avatars.githubusercontent.com/u/69029656?v=4',
                width: 50,
                height: 50,
                fit: BoxFit.cover),
          ),
          SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hello, Kursat',
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              Text(
                'Nice to See You!',
                style: TextStyle(color: mainColor, fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class AppSearch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Discover',
            style: TextStyle(fontWeight: FontWeight.w900, fontSize: 25),
          ),
          SizedBox(height: 20),

          // rest of the code omitted for brevity
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 50,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    children: [
                      Icon(Icons.search, color: Colors.grey),
                      SizedBox(width: 10),
                      Text(
                        'Search',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10),
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: mainColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(Icons.tune, color: Colors.white),
              )
            ],
          )
        ],
      ),
    );
  }
}

class AppMountListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: mountItems.length,
          itemBuilder: (context, index) {
            // rest of the code omitted for brevity...

            MountModel currentMount = mountItems[index];

            return GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => DetailsPage(currentMount)));
              },
              child: Container(
                alignment: Alignment.bottomLeft,
                padding: EdgeInsets.all(20),
                margin: EdgeInsets.all(10),
                width: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                      image: NetworkImage(currentMount.path),
                      fit: BoxFit.cover),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      currentMount.name,
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      currentMount.location,
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}

class AppCategoryList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Category',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                Text(
                  'See More',
                  style: TextStyle(
                      color: mainColor,
                      fontSize: 12,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Container(
            height: 100,
            margin: EdgeInsets.only(left: 10),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,

              // rest of the code omitted for brevity...

              itemBuilder: (context, index) {
                CategoryModel currentCategory = categories[index];

                return Container(
                  width: 100,
                  margin: EdgeInsets.only(top: 10, right: 10),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.grey.withOpacity(0.2), width: 2),
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(currentCategory.icon, color: mainColor),
                      Text(currentCategory.category,
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold))
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class AppBottomBar extends StatefulWidget {
  @override
  AppBottomBarState createState() => AppBottomBarState();
}

class AppBottomBarState extends State<AppBottomBar> {
  List<AppBottomBarItem> barItems = [
    AppBottomBarItem(icon: Icons.home, label: 'Home', isSelected: true),
    AppBottomBarItem(icon: Icons.explore, label: 'Explore', isSelected: false),
    AppBottomBarItem(
        icon: Icons.turned_in_not, label: 'Tag', isSelected: false),
    AppBottomBarItem(
        icon: Icons.person_outline, label: 'Profile', isSelected: false)
  ];

  //... rest of the code omitted for brevity...

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: Offset.zero)
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(barItems.length, (index) {
          AppBottomBarItem currentBarItem = barItems[index];

          Widget barItemWidget;

          if (currentBarItem.isSelected) {
            barItemWidget = Container(
              padding: EdgeInsets.only(left: 15, top: 5, bottom: 5, right: 15),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20), color: mainColor),
              child: Row(
                children: [
                  Icon(currentBarItem.icon, color: Colors.white),
                  SizedBox(width: 5),
                  Text(currentBarItem.label,
                      style: TextStyle(color: Colors.white))
                ],
              ),
            );
          } else {
            barItemWidget = IconButton(
                icon: Icon(currentBarItem.icon, color: Colors.grey),
                onPressed: () {
                  setState(() {
                    barItems.forEach((AppBottomBarItem item) {
                      item.isSelected = item == currentBarItem;
                    });
                  });
                });
          }

          return barItemWidget;
        }),
      ),
    );
  }
}

class DetailsRatingBar extends StatelessWidget {
  var sampleRatingData = {
    'Rating': '4.6',
    'Price': '\$12',
    'Open': '24hrs',
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(
          sampleRatingData.entries.length,
          (index) => Container(
            padding: EdgeInsets.all(20),
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.withOpacity(0.2), width: 2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                Text(
                  sampleRatingData.entries.elementAt(index).key,
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                Text(
                  sampleRatingData.entries.elementAt(index).value,
                  style: TextStyle(
                    color: mainColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//----MODELS----

class MountModel {
  String path;
  String name;
  String location;
  String description;

  MountModel(
      {this.path = '',
      this.name = '',
      this.location = '',
      this.description = ''});
}

class CategoryModel {
  String category;
  IconData? icon;

  CategoryModel({this.category = '', this.icon});
}

class AppBottomBarItem {
  IconData? icon;
  bool isSelected;
  String label;

  AppBottomBarItem({this.icon, this.label = '', this.isSelected = false});
}
