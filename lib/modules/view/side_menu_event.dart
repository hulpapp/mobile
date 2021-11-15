import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hulp/modules/view/reports.dart';

class SideMenuEvent extends StatelessWidget {
  const SideMenuEvent({Key key, this.eventId}) : super(key: key);
  final int eventId ;


  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Center(
              child: Text(
                  'hulp',
                  style: GoogleFonts.anton(fontSize: 95,fontWeight: FontWeight.w700, color: Color.fromARGB(255,72,20,69))
              ),
            ),
          ),

          // ListTile(
          //   title: Text('Detalhes'),
          //   onTap: () {
          //     Navigator.pushNamed(
          //         context,
          //         '/event/detail',
          //         arguments: eventId
          //     );
          //   },
          // ),
          ListTile(
            title: Text('Locais'),
            onTap: () {
              Navigator.pushNamed(
                context,
                '/event/location',
              );
            },
          ),
          ListTile(
            title: Text('Equipes'),
            onTap: () {
              Navigator.pushNamed(
                context,
                '/teams',
                arguments: eventId
              );
            },
          ),
          ListTile(
            title: Text('Relatórios'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        ReportPage(
                          eventId: eventId,
                        )),
              );
            },
          ),
          ListTile(
            title: Text('login'),
            onTap: () {
              Navigator.pushNamed(
                context,
                '/login',
              );
            },
          ),


        ],
      ),
    );
  }
}

