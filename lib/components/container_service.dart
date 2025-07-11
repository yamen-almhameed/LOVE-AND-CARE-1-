import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ContainerService extends StatelessWidget {
  final String title;
  final String description;
  final String image;
  final bool isImageLeft; // المتغير اللي يحدد موقع الصورة
  final bool color;
  const ContainerService({
    super.key,
    required this.title,
    required this.description,
    required this.image,
    this.isImageLeft = false, // افتراضي الصورة على اليمين
    this.color = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: 240,
            height: 120,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(48),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
              border: color
                  ? Border.all(color: Colors.white)
                  : Border.all(color: Color(0xFFf5ada9)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: isImageLeft
                    ? [
                        SizedBox(width: 90),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              title,
                              style: GoogleFonts.inter(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              width: 100,
                              child: Text(
                                description,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.inter(
                                  fontSize: 10,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ]
                    : [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title,
                              style: GoogleFonts.inter(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              description,
                              style: GoogleFonts.inter(
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 90),
                      ],
              ),
            ),
          ),
          Positioned(
            top: -13,
            left: isImageLeft ? -17 : null,
            right: isImageLeft ? null : -19,
            child: Image.asset(
              image,
              width: 90,
              height: 85,
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }
}
