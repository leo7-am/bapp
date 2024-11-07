import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 2;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Selected Index: $_selectedIndex'),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        onItemTapped: _onItemTapped,
        selectedIndex: _selectedIndex,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 60), // Move button higher
        child: CircleAvatar(
          radius: 30, // Adjust radius if needed
          backgroundColor: Colors.red,
          child: IconButton(
            icon: Image.asset(
              'assets/home.png',  // Your custom icon image path
              width: 40,  // Adjust width to fit the size
              height: 40, // Adjust height to fit the size
            ),
            onPressed: () => _onItemTapped(2),
          ),
        ),
      ),
    );
  }
}

class CustomBottomNavigationBar extends StatelessWidget {
  final Function(int) onItemTapped;
  final int selectedIndex;

  CustomBottomNavigationBar({required this.onItemTapped, required this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      child: Stack(
        children: [
          CustomPaint(
            size: Size(MediaQuery.of(context).size.width, 90),
            painter: BottomNavPainter(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              IconButton(
                icon: Image.asset(
                  'assets/qrcode.png',  // Your custom icon image path
                  width: 50,  // Adjust width to fit the size
                  height: 50, // Adjust height to fit the size
                ),
                onPressed: () => onItemTapped(0),
              ),
              IconButton(
                icon: Image.asset(
                  'assets/calender.png',  // Your custom icon image path
                  width: 50,  // Adjust width to fit the size
                  height: 50, // Adjust height to fit the size
                ),
                onPressed: () => onItemTapped(1),
              ),
              SizedBox(width: 40), // Space for the center button
              IconButton(
                icon: Image.asset(
                  'assets/question.png',  // Your custom icon image path
                  width: 50,  // Adjust width to fit the size
                  height: 50, // Adjust height to fit the size
                ),
                onPressed: () => onItemTapped(3),
              ),
              IconButton(
                icon: Image.asset(
                  'assets/group.png',  // Your custom icon image path
                  width: 50,  // Adjust width to fit the size
                  height: 50, // Adjust height to fit the size
                ),
                onPressed: () => onItemTapped(4),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class BottomNavPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final path = Path();

    // Adjusting the control points for a smoother curve
    path.moveTo(0, 0);
    path.quadraticBezierTo(size.width * 0.2, -30, size.width * 0.35, -30); // Adjusted curve on the left
    path.quadraticBezierTo(size.width * 0.5, -50, size.width * 0.65, -30); // Highest point in the center, smoother curve
    path.quadraticBezierTo(size.width * 0.8, -30, size.width, 0); // Adjusted curve on the right
    path.lineTo(size.width, size.height); // Extend to the bottom right
    path.lineTo(0, size.height); // Extend to the bottom left
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
