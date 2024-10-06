import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Home_Screen extends StatelessWidget {
  const Home_Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        //for this center title appbar will be in the center
        title: Text(
          'News',
          style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w700),
        ),
        leading: IconButton(
            onPressed: () {},
            icon: Image.asset(
              'assets/icons/list.png',
              height: 30,
              width: 30,
            )),
      ),
      body: Center(
        child: Image.asset('assets/icons/list.png'),
      ),
    );
  }
}
