import 'package:oogie/functions/date_conversion.dart';
import 'package:oogie/models/address_model.dart';
import 'package:oogie/models/delivery_order_Model.dart';
import 'package:oogie/models/order_model.dart';
import 'package:oogie/models/product_model.dart';
import 'package:oogie/models/user_model.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

PdfColor dividerColor = PdfColor.fromHex('#72777A');
PdfColor textDark = PdfColor.fromHex('#303437');
PdfColor textSecondary = PdfColor.fromHex('#6C7072');
PdfColor textPrimary = PdfColor.fromHex('#404446');
TextStyle smallTextDefault =
    TextStyle(fontSize: 12, fontWeight: FontWeight.normal, color: textPrimary);
TextStyle smallTextSubdued = TextStyle(
    fontSize: 12, fontWeight: FontWeight.normal, color: textSecondary);
TextStyle smallTextDark =
    TextStyle(fontSize: 12, fontWeight: FontWeight.normal, color: textDark);
TextStyle mediumTextDefault =
    TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: textPrimary);
TextStyle mediumTextSubdued = TextStyle(
    fontSize: 14, fontWeight: FontWeight.normal, color: textSecondary);
TextStyle mediumTextDark =
    TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: textDark);
TextStyle largeTextDefault =
    TextStyle(fontSize: 18, fontWeight: FontWeight.normal, color: textPrimary);
TextStyle largeTextSubdued = TextStyle(
    fontSize: 18, fontWeight: FontWeight.normal, color: textSecondary);
TextStyle largeTextDark =
    TextStyle(fontSize: 18, fontWeight: FontWeight.normal, color: textDark);

class PDF {
  Future<void> generateBillInvoice(
      {DeliveryOrderModel deliveryOrderModel}) async {
    AddressModel sellerAddress = deliveryOrderModel.pickingAddressModel;
    AddressModel shippingAddress = deliveryOrderModel.shippingAddressModel;
    List<ProductModel> productModels = deliveryOrderModel.products;
    final pdf = Document();

    try {
      pdf.addPage(MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: EdgeInsets.all(25),
        build: (context) => [
          Align(
            alignment: Alignment.center,
            child: Text('Oogie Shopee-Tax Invoice',
                style: TextStyle(
                  fontSize: 22,
                )),
          ),
          SizedBox(height: 20),
          Divider(thickness: 2, color: dividerColor),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: (PdfPageFormat.a4.width - 50) * 4 / 10,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Order ID : ${deliveryOrderModel.id}',
                          style: mediumTextDark),
                      SizedBox(height: 8),
                      RichText(
                        text: TextSpan(children: [
                          TextSpan(text: 'Order Date : ', style: smallTextDark),
                          TextSpan(
                              text: deliveryOrderModel.createdDate.toString(),
                              style: smallTextSubdued),
                        ]),
                      ),
                      SizedBox(height: 8),
                      RichText(
                        text: TextSpan(children: [
                          TextSpan(
                              text: 'Invoice Date : ', style: smallTextDark),
                          TextSpan(
                              text: getDateString(DateTime.now()
                                  .millisecondsSinceEpoch
                                  .toString()),
                              style: smallTextSubdued),
                        ]),
                      ),
                      SizedBox(height: 8),
                      RichText(
                        text: TextSpan(children: [
                          TextSpan(text: 'GSTIN ', style: smallTextDark),
                          TextSpan(
                              text: 'GSTNO54896700023',
                              style: smallTextSubdued),
                        ]),
                      ),
                    ]),
              ),
              SizedBox(
                width: (PdfPageFormat.a4.width - 50) * 3 / 10,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Seller',
                        style: smallTextDefault,
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        sellerAddress.name.toString(),
                        style: smallTextSubdued,
                      ),
                      Text(
                        sellerAddress.address1.toString(),
                        style: smallTextSubdued,
                      ),
                      Text(
                        sellerAddress.address2.toString(),
                        style: smallTextSubdued,
                      ),
                      Text(
                        sellerAddress.landmark.toString(),
                        style: smallTextSubdued,
                      ),
                      Text(
                        sellerAddress.city.toString(),
                        style: smallTextSubdued,
                      ),
                      Text(
                        sellerAddress.pinCode.toString() +
                            ', ' +
                            sellerAddress.state.toString(),
                        style: smallTextSubdued,
                      ),
                      Text(
                        sellerAddress.phoneNumber.toString(),
                        style: smallTextSubdued,
                      ),
                    ]),
              ),
              SizedBox(
                width: (PdfPageFormat.a4.width - 50) * 3 / 10,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Shipping Address',
                        style: smallTextDefault,
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        shippingAddress.name,
                        style: smallTextSubdued,
                      ),
                      Text(
                        shippingAddress.address1,
                        style: smallTextSubdued,
                      ),
                      Text(
                        shippingAddress.address2,
                        style: smallTextSubdued,
                      ),
                      Text(
                        shippingAddress.landmark,
                        style: smallTextSubdued,
                      ),
                      Text(
                        shippingAddress.city,
                        style: smallTextSubdued,
                      ),
                      Text(
                        shippingAddress.pinCode + ', ' + shippingAddress.state,
                        style: smallTextSubdued,
                      ),
                      Text(
                        shippingAddress.phoneNumber +
                            ', ' +
                            shippingAddress.alternativePhoneNumber,
                        style: smallTextSubdued,
                      ),
                    ]),
              ),
            ],
          ),
          SizedBox(height: 20),
          buildItemList(productModels),
          SizedBox(height: 20),
          Align(
            alignment: Alignment.centerRight,
            child: buildBillTotal(deliveryOrderModel),
          )
        ],
        // footer: (context) => buildFooter(invoice),
      ));
      try {
        await Printing.layoutPdf(
            onLayout: (PdfPageFormat format) async => pdf.save());
      } catch (e) {
        print(e);
      }
    } catch (e) {
      print(e);
    }
    // return pdf.save();

    // PdfApi.saveDocument(name: 'my_invoice.pdf', pdf: pdf);
  }

  Future<void> generateSalesReport(
      {List<OrderModel> orderModels,
      DateTime fromDate,
      DateTime toDate,
      UserModel userModel}) async {
    final pdf = Document();

    print('ordermodel length :${orderModels.length}');
    try {
      pdf.addPage(MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: EdgeInsets.all(25),

        build: (context) => [
          Align(
            alignment: Alignment.center,
            child: Text('Oogie Shopee-Sales Report',
                style: TextStyle(
                  fontSize: 22,
                )),
          ),

          SizedBox(height: 20),
          Divider(thickness: 2, color: dividerColor),
          SizedBox(height: 10),
          Row(
            children: [
              Text('Name\t:\t', style: mediumTextSubdued),
              Text(userModel.name.toString(), style: mediumTextDark),
            ],
          ),
          Row(
            children: [
              Text('From  :', style: mediumTextSubdued),
              Text(getDateString(fromDate.millisecondsSinceEpoch.toString()),
                  style: mediumTextDark),
              Text('\t To \t:', style: mediumTextSubdued),
              Text(getDateString(toDate.millisecondsSinceEpoch.toString()),
                  style: mediumTextDark),
            ],
          ),
          SizedBox(height: 20),
          buildOrderList(orderModels),
        ],
        // footer: (context) => buildFooter(invoice),
      ));
      try {
        await Printing.layoutPdf(
            onLayout: (PdfPageFormat format) async => pdf.save());
      } catch (e) {
        print(e);
      }
    } catch (e) {
      print(e);
    }
    // return pdf.save();

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

  static Widget buildItemList(List<ProductModel> productModels) {
    final headers = ['Product', 'Qty', 'Price', 'Total'];
    double subTotal = 0.0;
    double grandTotal = 0.0;
    int totalQty = 0;
    productModels.forEach((e) => subTotal += e.totalPrice);
    productModels.forEach((e) => totalQty += e.qty);
    final footer = ['Total', totalQty, '', subTotal.toStringAsFixed(2)];

    final data = productModels.map((item) {
      return [
        item.name,
        '${item.qty}',
        '${item.price}',
        '${item.totalPrice.toStringAsFixed(2)}',
      ];
    }).toList();
    data.add(['', '', '', '']);

    return Column(children: [
      Table.fromTextArray(
        headers: headers,
        data: data,
        border: null,
        headerStyle: TextStyle(fontWeight: FontWeight.bold),
        headerDecoration: BoxDecoration(color: PdfColors.grey200),
        cellHeight: 30,
        cellAlignments: {
          0: Alignment.centerLeft,
          1: Alignment.centerRight,
          2: Alignment.centerRight,
          3: Alignment.centerRight,
        },
      ),
      Table.fromTextArray(
        headers: footer,
        border: null,
        headerStyle: TextStyle(fontWeight: FontWeight.bold),
        headerDecoration: BoxDecoration(color: PdfColors.grey200),
        cellHeight: 30,
        cellAlignments: {
          0: Alignment.centerLeft,
          1: Alignment.centerRight,
          2: Alignment.centerRight,
          3: Alignment.centerRight,
        },
        data: [],
      ),
    ]);
  }
  static Widget buildOrderList(List<OrderModel> orderModels) {
    print('build orde list ${orderModels.length}');
    final headers = ['Date', 'OrderId', 'Total'];
    double subTotal = 0.0;

    orderModels.forEach((e) => subTotal += e.total);
    final footer = ['Total',  '', subTotal.toStringAsFixed(2)];

    final data =

    orderModels.map((item) {
      return [
        '${item.date.toString()}',
        '${item.id}',
        '${item.total.toStringAsFixed(2)}',
      ];
    }).toList();
    data.add(['', '', '']);

    return Column(children: [
      Table.fromTextArray(
        headers: headers,
        data: data,
        border: null,
        headerStyle: TextStyle(fontWeight: FontWeight.bold),
        headerDecoration: BoxDecoration(color: PdfColors.grey200),
        cellHeight: 30,
        cellAlignments: {
          0: Alignment.centerLeft,
          1: Alignment.centerRight,
          2: Alignment.centerRight,
        },
      ),
      Table.fromTextArray(
        headers: footer,
        border: null,
        headerStyle: TextStyle(fontWeight: FontWeight.bold),
        headerDecoration: BoxDecoration(color: PdfColors.grey200),
        cellHeight: 30,
        cellAlignments: {
          0: Alignment.centerLeft,
          1: Alignment.centerRight,
          2: Alignment.centerRight,
        },
        data: [],
      ),
    ]);
  }

  static Widget buildBillTotal(DeliveryOrderModel deliveryOrderModel) {
    double subTotal = 0.0;
    double grandTotal = 0.0;
    int totalQty = 0;
    deliveryOrderModel.products.forEach((e) => subTotal += e.totalPrice);
    deliveryOrderModel.products.forEach((e) => totalQty += e.qty);
    return SizedBox(
        width: PdfPageFormat.a4.width / 2,
        child: Column(children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text('SubTotal', style: mediumTextDefault),
            Text(subTotal.toStringAsFixed(2), style: mediumTextDark),
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text('Tax', style: mediumTextDefault),
            Text('Inclusive of all Taxes', style: mediumTextDark),
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text('Grand Total', style: largeTextDark),
            Text(grandTotal.toStringAsFixed(2), style: largeTextDark),
          ])
        ]));
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
