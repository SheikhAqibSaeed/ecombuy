import 'package:flutter/material.dart';

class CheckOutScreen extends StatefulWidget {
  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckOutScreen> {
  // Variables to store user input
  String fullName = '';
  String cardNumber = '';
  String expirationDate = '';
  String cvv = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Checkout Screen'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Product Details:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            Text('Product Name: Your Product Name'),
            Text('Price: \$100.00'),
            SizedBox(height: 20.0),
            Text(
              'Billing Information:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            TextField(
              onChanged: (value) {
                setState(() {
                  fullName = value;
                });
              },
              decoration: InputDecoration(labelText: 'Full Name'),
            ),
            TextField(
              onChanged: (value) {
                setState(() {
                  cardNumber = value;
                });
              },
              decoration: InputDecoration(labelText: 'Card Number'),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        expirationDate = value;
                      });
                    },
                    decoration: InputDecoration(labelText: 'Expiration Date'),
                  ),
                ),
                SizedBox(width: 10.0),
                Expanded(
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        cvv = value;
                      });
                    },
                    decoration: InputDecoration(labelText: 'CVV'),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                // Implement your payment logic here
                // You can use the values of fullName, cardNumber, expirationDate, and cvv
                // to process the payment.
              },
              child: Text('Confirm Payment'),
            ),
          ],
        ),
      ),
    );
  }
}
