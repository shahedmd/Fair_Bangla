import 'package:fair_bangla/myOrdermodel.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:get/get.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:typed_data';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

class PDFcontroller extends GetxController {
  Future<void> generateAndPrintOrderPDF(OrderModel order) async {
    final pdf = pw.Document();

    final fontData = await rootBundle.load("font/Inter-Bold.ttf");
    final ttf = pw.Font.ttf(fontData);

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text("Fair Bangla", style: pw.TextStyle(fontSize: 24, font: ttf)),
              pw.SizedBox(height: 10),
              pw.Text("Order ID: ${order.orderId}", style: pw.TextStyle(font: ttf)),
              pw.Text("Date: ${order.timestamp.toString()}", style: pw.TextStyle(font: ttf)),
              pw.Text("Status: ${order.status}", style: pw.TextStyle(font: ttf)),
              pw.SizedBox(height: 10),
              pw.Text("Items:", style: pw.TextStyle(font: ttf, fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 5),
              ...order.items.map((item) {
                return pw.Container(
                  margin: const pw.EdgeInsets.symmetric(vertical: 5),
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text("Name: ${item.name}", style: pw.TextStyle(font: ttf)),
                      pw.Text("Quantity: ${item.quantity}", style: pw.TextStyle(font: ttf)),
                      pw.Text("Price: \$${item.price}", style: pw.TextStyle(font: ttf)),
                      pw.Text("Color: ${item.selectedColor}", style: pw.TextStyle(font: ttf)),
                      pw.Text("Size: ${item.selectedSize}", style: pw.TextStyle(font: ttf)),
                    ],
                  ),
                );
              }).toList(),
              pw.Divider(),
              pw.Text("Total: \$${order.total}", style: pw.TextStyle(font: ttf, fontWeight: pw.FontWeight.bold)),
            ],
          );
        },
      ),
    );

    Uint8List bytes = await pdf.save();
    final blob = html.Blob([bytes]);
    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor = html.AnchorElement(href: url)
      ..setAttribute("download", "order_${order.timestamp}.pdf")
      ..click();
    html.Url.revokeObjectUrl(url);
  }
}
