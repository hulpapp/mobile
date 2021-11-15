import 'package:flutter/material.dart';
import 'package:hulp/modules/entities/Bene.dart';
import 'package:hulp/modules/presenter/user.dart';
import 'package:hulp/modules/view/side_menu.dart';
import 'package:hulp/utils/responsivity.dart';

class BeneficiariesDetail extends StatefulWidget {
  @override
  _BeneficiariesDetailState createState() => _BeneficiariesDetailState();
}

class _BeneficiariesDetailState extends State<BeneficiariesDetail> {
  Future<List<Beneficiary>> bn;
  UserPresenter _userPresenter = new UserPresenter();
  final eventListKey = GlobalKey<_BeneficiariesDetailState>();

  @override
  void initState() {
    super.initState();
    bn = getBeneficiariesList();
  }

  Future<List<Beneficiary>> getBeneficiariesList() async {
    final response = await _userPresenter.listBeneficiary();

    List<Beneficiary> bene = [];

    for (final i in response) {
      bene.add(Beneficiary.fromJson(i));
    }
    return bene;
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Row(
          children: [
            if (Responsive.isDesktop(context))
              Expanded(
                child: SideMenu(),
              ),
            Expanded(
                flex: 5,
                child: Card(
                  child: Container(
                    width: width* 0.45,
                    child: FutureBuilder<List>(
                      future: bn,
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (!snapshot.hasData || snapshot.data.length == 0)
                          return const Text(
                            'Sem Beneficiários Cadastrados',
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          );
                        return ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext context, int index) {
                            var data = snapshot.data[index];
                            return Card(
                              child: ListTile(
                                leading: const Icon(Icons.face),
                                title: Text(
                                  data.name,
                                  style: const TextStyle(fontSize: 20),
                                ),
                                onTap: () {},
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                )),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(
            context,
            '/beneficiary/new',
          );
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
    );
  }
}
