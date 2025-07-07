import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;
  final int currentIndex;
  final VoidCallback NextPressed;
  const SplashScreen({
    super.key,
    required this.imagePath,
    required this.title,
    required this.description,
    required this.currentIndex,
    required this.NextPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF6ECDF),
      body: Column(
        children: [
          const Spacer(),
          Center(
            child: Image.asset(
              imagePath,
              width: 297,
              height: 296,
              fit: BoxFit.contain,
            ),
          ),
          const Spacer(),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFF66890),
                    fontFamily: 'Poppins',
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 15,
                  ),
                  child: Text(
                    description,
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                      height: 1.6, // لزيادة تباعد الأسطر
                    ),
                    textAlign: TextAlign.justify,
                    textDirection: TextDirection.rtl,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: List.generate(3, (index) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 5),
                          child: Container(
                            height: 5,
                            width: 25,
                            decoration: BoxDecoration(
                              color: currentIndex == index
                                  ? Color(0xffF66890)
                                  : Colors.grey,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        );
                      }),
                    ),
                    CircleAvatar(
                      backgroundColor: Color(0xFFF66890),
                      radius: 20,
                      child: IconButton(
                        icon: Icon(Icons.arrow_forward, color: Colors.white),
                        onPressed: NextPressed,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
