import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:real_estate_app/maptab.dart';
import 'package:real_estate_app/real_home.dart';

void main() {
  runApp(RealEstateApp());
}

class RealEstateApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 1;
  bool _isVisible = true;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (_isVisible) {
          setState(() {
            _isVisible = false;
          });
        }
      } else if (_scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        if (!_isVisible) {
          setState(() {
            _isVisible = true;
          });
        }
      }
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: <Widget>[
          RealEstateMap(controller: _scrollController),
          RealEstateWidget(scrollController: _scrollController),
          Center(child: Text('Profile')),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        height: _isVisible ? 70.0 : 0.0,
        margin: EdgeInsets.only(bottom: 16.0),
        child: Wrap(
          children: [
            CustomBottomNavigationBar(
              selectedIndex: _selectedIndex,
              onItemTapped: _onItemTapped,
            ),
          ],
        ),
      ),
    );
  }
}

class CustomBottomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  CustomBottomNavigationBar(
      {required this.selectedIndex, required this.onItemTapped});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16.0),
      width: MediaQuery.of(context).size.width * 0.64,
      decoration: BoxDecoration(
        color: Colors.black54,
        borderRadius: BorderRadius.circular(30.0),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.7), blurRadius: 10.0)
        ],
      ),
      child: BottomNavigationBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        currentIndex: selectedIndex,
        onTap: onItemTapped,
        items: [
          BottomNavigationBarItem(
              icon: CircleAvatar(
                  backgroundColor: selectedIndex == 0
                      ? Color.fromARGB(255, 225, 141, 16)
                      : Colors.black,
                  child: Icon(
                    Icons.map,
                    color: Colors.white,
                  )),
              label: ''),
          BottomNavigationBarItem(
              icon: CircleAvatar(
                  backgroundColor: selectedIndex == 1
                      ? Color.fromARGB(255, 225, 141, 16)
                      : Colors.black,
                  child: Icon(
                    Icons.home,
                    color: Colors.white,
                  )),
              label: ''),
          BottomNavigationBarItem(
              icon: CircleAvatar(
                  backgroundColor: selectedIndex == 2
                      ? Color.fromARGB(255, 225, 141, 16)
                      : Colors.black,
                  child: Icon(
                    Icons.person,
                    color: Colors.white,
                  )),
              label: ''),
        ],
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: false,
      ),
    );
  }
}

class AnimatedPropertyCard extends StatelessWidget {
  final int index;

  AnimatedPropertyCard({required this.index});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => DetailPage()),
        );
      },
      child: Card(
        margin: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
                'https://plus.unsplash.com/premium_photo-1661883964999-c1bcb57a7357?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8aG91c2VzfGVufDB8fDB8fHww'),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Property Title',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text('\$200,000',
                  style: TextStyle(fontSize: 16, color: Colors.grey)),
            ),
          ],
        ),
      ),
    );
  }
}

class DetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Page'),
      ),
      body: Center(
        child: Image.network(
            'https://plus.unsplash.com/premium_photo-1661883964999-c1bcb57a7357?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8aG91c2VzfGVufDB8fDB8fHww'),
      ),
    );
  }
}


