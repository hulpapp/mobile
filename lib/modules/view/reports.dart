import 'package:flutter/material.dart';
import 'package:hulp/modules/entities/reports.dart';
import 'package:hulp/modules/presenter/donations.dart';
import 'package:hulp/modules/view/side_menu.dart';
import 'package:hulp/utils/responsivity.dart';

import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_datagrid_export/export.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart'
    hide Alignment, Column, Row;

import 'package:hulp/utils/save_file_web.dart' as helper;

class ReportPage extends StatefulWidget {

  final int eventId;

  const ReportPage({Key key, this.eventId}) : super(key: key);


  @override
  _ReportPageState createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  List<Report> report = <Report>[];
  DonationPresenter _donationPresenter = new DonationPresenter();
  ReportDataSource reportDataSource;
  final GlobalKey<SfDataGridState> _sfKey = GlobalKey<SfDataGridState>();

  @override
  void initState() {
    super.initState();
    listDonations();
  }


  listDonations() async {
    var req = await _donationPresenter.listDonationByEvent(widget.eventId);
    setState(() {
      reportDataSource = ReportDataSource(reportData: req );
    });

    print(req);
  }

  Future<void> exportDataGridToExcel() async {
    final Workbook workbook = _sfKey.currentState.exportToExcelWorkbook();

    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();

    await helper.saveAndLaunchFile(bytes, 'DataGrid.xlsx');
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Relatórios'),),
      floatingActionButton: FloatingActionButton(
        onPressed: exportDataGridToExcel,
    child: const Icon(Icons.description),
    backgroundColor: Colors.green,
    ),
      body:  SafeArea(
        child: Row(
          children: [
            if (Responsive.isDesktop(context))
              Expanded(
                child: SideMenu(),
              ),
            Expanded(flex: 5,child: SfDataGrid(
              columnWidthMode: ColumnWidthMode.fill,
              source: reportDataSource,
              columns: <GridColumn>[
                GridColumn(
                    columnName: 'Cidade',
                    label: Container(
                        padding: const EdgeInsets.all(16.0),
                        alignment: Alignment.center,
                        child: const Text(
                          'Cidade',
                        ))),
                GridColumn(
                    columnName: 'Item',
                    label: Container(
                        padding: const EdgeInsets.all(8.0),
                        alignment: Alignment.center,
                        child: const Text('Item'))),
                GridColumn(
                    columnName: 'Quantidade',
                    label: Container(
                        padding: const EdgeInsets.all(8.0),
                        alignment: Alignment.center,
                        child: const Text(
                          'Quantidade',
                          overflow: TextOverflow.ellipsis,
                        ))),
                GridColumn(
                    columnName: 'Local',
                    label: Container(
                        padding: const EdgeInsets.all(8.0),
                        alignment: Alignment.center,
                        child: const Text('Local'))),
                GridColumn(
                    columnName: 'Destino',
                    label: Container(
                        padding: const EdgeInsets.all(8.0),
                        alignment: Alignment.center,
                        child: const Text('Destino'))),
              ],
            )),
          ],
        ),
      ),
    );
  }

}
class ReportDataSource extends DataGridSource {

  ReportDataSource({List<Report> reportData}) {
    _reportData = reportData.map<DataGridRow>((Report e) => DataGridRow(cells: <DataGridCell>[
      DataGridCell<String>(columnName: 'Cidade', value: e.city),
      DataGridCell<String>(columnName: 'Item', value: e.category),
      DataGridCell<double>(columnName: 'Quantidade', value: e.quantity),
      DataGridCell<String>(columnName: 'Local', value: e.position),
      DataGridCell<String>(columnName: 'Destino', value: e.destination),
    ]))
        .toList();
  }

  List<DataGridRow> _reportData = <DataGridRow>[];

  @override
  List<DataGridRow> get rows => _reportData;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((DataGridCell cell) {
          return Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(8.0),
            child: Text(cell.value.toString()),
          );
        }).toList());
  }
}
