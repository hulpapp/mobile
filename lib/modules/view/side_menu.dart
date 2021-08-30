import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hulp/modules/view/events/createEvent.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Center(
              child: Text(
                  'hulp',
                  style: GoogleFonts.anton(fontSize: 100,fontWeight: FontWeight.w700, color: Color.fromARGB(255,72,20,69))
              ),
            ),
          ),
          ListTile(
            title: Text('Eventos'),
            onTap: () {
              Navigator.pushNamed(
                context,
                '/event/new',
              );
            },
          ),

        ],
      ),
    );
  }
}

