import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hulp/modules/entities/Certification.dart';
import 'package:hulp/modules/entities/event.dart';
import 'package:hulp/modules/presenter/user.dart';
import 'package:hulp/utils/save_file_web.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

class CertificationPage extends StatefulWidget {
  const CertificationPage({Key key, this.event}) : super(key: key);
  final Event event;


  @override
  _CertificationPageState createState() => _CertificationPageState();
}

class _CertificationPageState extends State<CertificationPage> {
  UserPresenter _userPresenter = new UserPresenter();
  Future<Certification> certification;

  @override
  void initState() {
    super.initState();
    certification =  getCertification();
    print(certification);
  }

  Future<void> _createPDF(certification) async {
    PdfDocument document = PdfDocument();
    final page = document.pages.add();

    page.graphics.drawString(
        'Declaro que ${certification.volunteer.name} \nportador do CPF ${certification.volunteer.cpf} \nparticipou do evento ${certification.event.name} \nno dia ${certification.event.date} \nEntre os horarios ${certification.event.startDate} ate ${certification.event.endDate} ', PdfStandardFont(PdfFontFamily.helvetica, 20),);

    List<int> bytes = document.save();
    saveAndLaunchFile(bytes, 'certificado.pdf');

  }


  Future<Certification> getCertification() async{
    final req =  await _userPresenter.getCertification(widget.event.id);
    return Certification.fromJson(req);



  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child:   Center(
        child: FutureBuilder<Certification>(
          future: certification,
          builder: (context, snapshot) {

            if (snapshot.hasData) {
              return Column(
                children: [
                  SizedBox(height: 100,),
                  Center(
                    child: RichText(
                      textAlign: TextAlign.justify,
                      text: TextSpan(
                        style: TextStyle(color: Colors.black, fontSize: 40),
                        children: <TextSpan>[
                          TextSpan(text: 'Informo que  '),
                          TextSpan(text: '${snapshot.data.volunteer.name} \n'),
                          TextSpan(text: 'Portador do CPF:'),
                          TextSpan(text: '${snapshot.data.volunteer.cpf} \n'),
                          TextSpan(text: 'participou como voluntario do evento: '),
                          TextSpan(text: '${snapshot.data.event.name} \n'),
                          TextSpan(text: 'no dia '),
                          TextSpan(text: '${snapshot.data.date}'),
                          TextSpan(text: 'entre os horarios '),
                          TextSpan(text: '${snapshot.data.startDate}'),
                          TextSpan(text: 'ate'),
                          TextSpan(text: '${snapshot.data.endDate}'),

                        ],
                      ),
                      textScaleFactor: 0.5,
                    ),
                  ),
                  ElevatedButton(onPressed: (){_createPDF(snapshot.data);}, child: Text('Salvar'))
                ],
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }

            // By default, show a loading spinner.
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }



}
