import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RealEstateWidget extends StatefulWidget {
  final ScrollController scrollController;

  RealEstateWidget({required this.scrollController});
  @override
  _RealEstateWidgetState createState() => _RealEstateWidgetState();
}

class _RealEstateWidgetState extends State<RealEstateWidget>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _searchBarController;
  late AnimationController _sliderController;
  late Animation<double> _sizeAnimation;
  late Animation<double> _profileAnimation;
  late Animation<Offset> _textSlideAnimation;
  late Animation<Offset> _buttonSlideAnimation;
  late Animation<double> _buyCounterAnimation;
  late Animation<double> _rentCounterAnimation;
  late Animation<double> _sliderButtonWidthAnimation;

  ScrollController _scrollController = ScrollController();

  bool _isSearchBarExpanded = false;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
  }

  void _initializeAnimations() {
    _controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );

    _searchBarController = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );

    _sliderController = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );

    _sizeAnimation =
        Tween<double>(begin: 0.3, end: 1.0).animate(_searchBarController);

    _profileAnimation = CurvedAnimation(
      parent: _controller,
      curve: Interval(0.5, 1.0, curve: Curves.easeInOut),
    );

    _textSlideAnimation = Tween<Offset>(
      begin: Offset(0, 1),
      end: Offset(0, 0),
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _buttonSlideAnimation = Tween<Offset>(
      begin: Offset(-1, 0),
      end: Offset(0, 0),
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _buyCounterAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    _rentCounterAnimation = CurvedAnimation(
      parent: _controller,
      curve: Interval(0.5, 1.0, curve: Curves.easeInOut),
    );

    _sliderButtonWidthAnimation =
        Tween<double>(begin: 40.0, end: 200.0).animate(
      CurvedAnimation(parent: _sliderController, curve: Curves.easeInOut),
    );

    _controller.forward();
    _sliderController.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _searchBarController.dispose();
    _sliderController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _controller.reset();
    _controller.forward();
    _sliderController.reset();
    _sliderController.forward();
  }

  void _toggleSearchBar() {
    setState(() {
      _isSearchBarExpanded = !_isSearchBarExpanded;
      if (_isSearchBarExpanded) {
        _searchBarController.forward();
      } else {
        _searchBarController.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFDF6F1),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: _toggleSearchBar,
                    child: AnimatedBuilder(
                      animation: _sizeAnimation,
                      builder: (context, child) {
                        return Container(
                          width: MediaQuery.of(context).size.width *
                              _sizeAnimation.value,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                color: Color.fromARGB(255, 225, 141, 16),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    "Saint Petersburg",
                                    style: GoogleFonts.lato(fontSize: 12),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  Spacer(),
                  ScaleTransition(
                    scale: _profileAnimation,
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(
                          'https://plus.unsplash.com/premium_photo-1661883964999-c1bcb57a7357?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8aG91c2VzfGVufDB8fDB8fHww'),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SlideTransition(
                    position: _textSlideAnimation,
                    child: Text(
                      "Hi, Marina,",
                      textAlign: TextAlign.left,
                      style: GoogleFonts.lato(fontSize: 18, color: Colors.grey),
                    ),
                  ),
                  SlideTransition(
                    position: _textSlideAnimation,
                    child: Text(
                      "Let's select your\n  perfect place",
                      style: GoogleFonts.lato(
                          fontSize: 28, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildAnimatedCounter(
                      "BUY",
                      1034,
                      100,
                      Color.fromARGB(255, 225, 141, 16),
                      Colors.white,
                      _buyCounterAnimation),
                  _buildAnimatedCounter("RENT", 2212, 10, Colors.white,
                      Colors.grey, _rentCounterAnimation),
                ],
              ),
              SizedBox(height: 20),
              Expanded(
                child: ListView(
                  controller: widget.scrollController,
                  children: [
                    _buildImageItem(
                      imageUrl:
                          'https://plus.unsplash.com/premium_photo-1661883964999-c1bcb57a7357?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8aG91c2VzfGVufDB8fDB8fHww',
                      address: 'Gladkova St., 25',
                      fullWidth: true,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: _buildImageItem(
                            imageUrl:
                                'https://plus.unsplash.com/premium_photo-1661883964999-c1bcb57a7357?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8aG91c2VzfGVufDB8fDB8fHww',
                            address: 'Trofimova St., 43',
                            fullWidth: false,
                          ),
                        ),
                        Expanded(
                          child: _buildImageItem(
                            imageUrl:
                                'https://plus.unsplash.com/premium_photo-1661883964999-c1bcb57a7357?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8aG91c2VzfGVufDB8fDB8fHww',
                            address: 'Novaya St., 17',
                            fullWidth: false,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: _buildImageItem(
                            imageUrl:
                                'https://plus.unsplash.com/premium_photo-1661883964999-c1bcb57a7357?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8aG91c2VzfGVufDB8fDB8fHww',
                            address: 'Krasnaya St., 9',
                            fullWidth: false,
                          ),
                        ),
                        Expanded(
                          child: _buildImageItem(
                            imageUrl:
                                'https://plus.unsplash.com/premium_photo-1661883964999-c1bcb57a7357?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8aG91c2VzfGVufDB8fDB8fHww',
                            address: 'Zelenaya St., 6',
                            fullWidth: false,
                          ),
                        ),
                      ],
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

  Widget _buildAnimatedCounter(String label, int value, double radius,
      Color color, Color textColor, Animation<double> animation) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.all(Radius.circular(radius))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            "$label",
            style: GoogleFonts.lato(fontSize: 16, color: textColor),
          ),
          AnimatedBuilder(
            animation: animation,
            builder: (context, child) {
              return Text(
                (value * animation.value).toInt().toString(),
                style: GoogleFonts.lato(
                    fontSize: 40,
                    color: textColor,
                    fontWeight: FontWeight.bold),
              );
            },
          ),
          Text(
            "offers",
            style: GoogleFonts.lato(fontSize: 16, color: textColor),
          ),
        ],
      ),
    );
  }

  Widget _buildImageItem(
      {required String imageUrl,
      required String address,
      required bool fullWidth}) {
    return Container(
      margin: EdgeInsets.all(8.0),
      width: fullWidth ? double.infinity : null,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
        ),
      ),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.2,
        child: Stack(
          children: [
            Positioned(
              bottom: 20,
              left: 0,
              right: 0,
              child: Center(
                child: AnimatedBuilder(
                  animation: _sliderButtonWidthAnimation,
                  builder: (context, child) {
                    return Container(
                      height: 60,
                      width: _sliderButtonWidthAnimation.value,
                      padding:
                          EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Stack(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                address,
                                style: GoogleFonts.lato(fontSize: 14),
                                overflow: TextOverflow.ellipsis,
                              ),
                              Expanded(child: Container()),
                            ],
                          ),
                          Positioned(
                            right: 0,
                            child: CircleAvatar(
                                backgroundColor: Colors.white,
                                // radius: 100,
                                child: Icon(Icons.navigate_next,
                                    color: Colors.black)),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}