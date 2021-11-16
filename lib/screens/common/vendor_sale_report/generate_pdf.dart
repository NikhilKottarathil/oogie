import 'package:oogie/constants/styles.dart';
import 'package:oogie/models/order_model.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class PDF {
  Future<void> generate(List<OrderModel> orderModels) async {
    final pdf = Document();

    pdf.addPage(MultiPage(
      build: (context) => [
        Container(
          decoration: BoxDecoration(

            // border: Border.all(color: Colors)
          )
        ),
        Row(children: [
          Text('Sales Report',style: TextStyle(fontSize: 32)),
          SvgImage(svg: 'assets/app_logo.svg'),
        ]),
        ListView.separated(
            direction: Axis.vertical,
            itemBuilder: (context, index) {
              OrderModel orderModel=orderModels[index];
              return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(orderModel.date),
                    Text(orderModel.id),
                    Text(orderModel.total.toStringAsFixed(2)),
                  ]);
            },
            separatorBuilder: (Context context, int index) {
              return SizedBox(height: 10);
            },
            itemCount: 10)
      ],
      // footer: (context) => buildFooter(invoice),
    ));

    // return pdf.save();
    await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => pdf.save());
    // PdfApi.saveDocument(name: 'my_invoice.pdf', pdf: pdf);
  }

  static Widget buildHeader(var invoice) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 1 * PdfPageFormat.cm),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildvarAddress(invoice.supplier),
              Container(
                height: 50,
                width: 50,
                child: BarcodeWidget(
                  barcode: Barcode.qrCode(),
                  data: invoice.info.number,
                ),
              ),
            ],
          ),
          SizedBox(height: 1 * PdfPageFormat.cm),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildvarAddress(invoice.customer),
              buildvarInfo(invoice.info),
            ],
          ),
        ],
      );

  static Widget buildvarAddress(var customer) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(customer.name, style: TextStyle(fontWeight: FontWeight.bold)),
          Container(
            width: 250,
            child: Text(
              customer.address,
            ),
          )
        ],
      );

  static Widget buildvarInfo(var info) {
    final titles = <String>[
      'var Number:',
      'var Date:',
    ];
    final data = <String>[info.number, info.date];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(titles.length, (index) {
        final title = titles[index];
        final value = data[index];

        return buildText(title: title, value: value, width: 250);
      }),
    );
  }

  // static Widget buildvarAddress(var supplier) => Column(
  //   crossAxisAlignment: CrossAxisAlignment.start,
  //   children: [
  //     Text(supplier.name, style: TextStyle(fontWeight: FontWeight.bold)),
  //     SizedBox(height: 1 * PdfPageFormat.mm),
  //     Text(supplier.address),
  //   ],
  // );

  static Widget buildTitle(var invoice) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'INVOICE',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          // SizedBox(height: 0.8 * PdfPageFormat.cm),
          // Text(invoice.info.description),
          SizedBox(height: 0.8 * PdfPageFormat.cm),
        ],
      );

  static Widget buildvar(var invoice) {
    final headers = [
      'Name',
      // 'Date',
      'Quantity',
      'Price',
      // 'VAT',
      'Total'
    ];
    final data = invoice.items.map((item) {
      final total = item.Total;

      return [
        item.description,
        // Utils.formatDate(item.date),
        '${item.quantity}',
        '${item.unitPrice}',
        // '${item.vat} %',
        '${total}',
      ];
    }).toList();

    return Table.fromTextArray(
      headers: headers,
      data: data,
      border: null,
      headerStyle: TextStyle(fontWeight: FontWeight.bold),
      headerDecoration: BoxDecoration(color: PdfColors.grey300),
      cellHeight: 30,
      cellAlignments: {
        0: Alignment.centerLeft,
        1: Alignment.center,
        2: Alignment.centerRight,
        3: Alignment.centerRight,
        4: Alignment.centerRight,
        // 5: Alignment.centerRight,
      },
    );
  }

  static Widget buildTotal(var invoice) {
    // final netTotal = invoice.items
    //     .map((item) => double.tryParse(item.unitPrice) * double.tryParse(item.quantity))
    //     .reduce((item1, item2) => item1 + item2);
    // final vatPercent = invoice.items.first.vat;
    // final vat = netTotal * vatPercent;
    double d = 0.0;
    final data = invoice.items.map((item) {
      final total = item.Total;
      d = d + double.tryParse(item.Total);
    }).toList();

    return Container(
      alignment: Alignment.centerRight,
      child: Row(
        children: [
          Spacer(flex: 6),
          Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildText(
                  title: 'Total Amount',
                  value: invoice.customer.itemTotal,
                  unite: true,
                ),
                buildText(
                  title: 'Delivery Charge',
                  value: invoice.customer.deliveryCharge,
                  unite: true,
                ),
                buildText(
                  title: 'Grand  Total',
                  value: invoice.customer.grandTotal,
                  unite: true,
                ),
                Divider(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Widget buildFooter(var invoice) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Divider(),
          SizedBox(height: 2 * PdfPageFormat.mm),
          buildSimpleText(title: 'Address', value: invoice.supplier.address),
          SizedBox(height: 1 * PdfPageFormat.mm),
          // buildSimpleText(title: 'Paypal', value: invoice.supplier.paymentInfo),
        ],
      );

  static buildSimpleText({
    String title,
    String value,
  }) {
    final style = TextStyle(fontWeight: FontWeight.bold);

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: pw.CrossAxisAlignment.end,
      children: [
        Text(title, style: style),
        SizedBox(width: 2 * PdfPageFormat.mm),
        Text(value),
      ],
    );
  }

  static buildText({
    String title,
    String value,
    double width = double.infinity,
    TextStyle titleStyle,
    bool unite = false,
  }) {
    final style = titleStyle ?? TextStyle(fontWeight: FontWeight.bold);

    return Container(
      width: width,
      child: Row(
        children: [
          Expanded(child: Text(title, style: style)),
          Text(value, style: unite ? style : null),
        ],
      ),
    );
  }
}
