import 'package:fair_bangla/myOrdermodel.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:get/get.dart';

import 'dart:typed_data';
import 'dart:html' as html;




class PDFcontroller extends GetxController{
  Future<void> generateAndPrintOrderPDF( OrderModel order) async {
  final pdf = pw.Document();

  pdf.addPage(
    pw.Page(
      build: (pw.Context context) {
        return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text("Fair Bangla", style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 10),
            pw.Text("Order ID: ${order.orderId}"),
            pw.Text("Date: ${order.timestamp.toString()}"),
            pw.Text("Status: ${order.status}"),
            pw.SizedBox(height: 10),
            pw.Text("Items:", style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 5),
            ...order.items.map((item) {
              return pw.Container(
                margin: const pw.EdgeInsets.symmetric(vertical: 5),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text("Name: ${item.name}"),
                    pw.Text("Quantity: ${item.quantity}"),
                    pw.Text("Price: \$${item.price}"),
                    pw.Text("Color: ${item.selectedColor}"),
                    pw.Text("Size: ${item.selectedSize}"),
                  ],
                ),
              );
            }).toList(),
            pw.Divider(),
            pw.Text("Total: \$${order.total}", style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
          ],
        );
      },
    ),
  );
  final orderid = order.timestamp;
  Uint8List bytes = await pdf.save();
    final blob = html.Blob([bytes]);
    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor = html.AnchorElement(href: url)
      ..setAttribute("download", "Order_$orderid.pdf")
      ..click();
    html.Url.revokeObjectUrl(url);
 
}

}
