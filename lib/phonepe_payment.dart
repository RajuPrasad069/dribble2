import 'dart:convert';
import 'dart:core';
import 'dart:core';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:phonepe_payment_sdk/phonepe_payment_sdk.dart';

class PhonePePayment extends StatefulWidget {
  final double totalPrice;

  const PhonePePayment( {super.key, required this.totalPrice});

  @override
  State<PhonePePayment> createState() => _PhonePePaymentState();
}

class _PhonePePaymentState extends State<PhonePePayment> {
  String environment = "UAT_SIM";
  String appId = "";
  String merchantId = "PGTESTPAYUAT";
  bool enableLogging = true;
  String checksum = "";
  String SaltKey = "099eb0cd-02cf-4e2a-8aca-3e6c6aff0399";
  String SaltIndex = "1";
  String callbackurl =
      "https://webhook.site/3579301d-205f-47f3-84bd-e8991560da25";
  String body = "";
  String apiEndPoint = "/pg/v1/pay";
  Object? result;

  getChecksum() {
    final requestData = {
      "merchantId": merchantId,
      "merchantTransactionId": "transaction_123",
      "merchantUserId": "90223250",
      "amount": 1000,
      "mobileNumber": "9999999999",
      "callbackUrl": callbackurl,
      "paymentInstrument": {
        "type": "PAY_PAGE",
      },
    };
    String base64Body = base64.encode(utf8.encode(json.encode(requestData)));
    checksum =
        '${sha256.convert(utf8.encode(base64Body + apiEndPoint + SaltKey))}###$SaltIndex';

    return base64Body;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    phonepeInit();
    body = getChecksum().toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          title: Text("PhonePe Pyament Getway",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 80,),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              SizedBox(
                height: 50,
                width: 250,
                child: ElevatedButton(
                  onPressed: () {
                    startPgTransaction();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple, // Set the background color here
                  ),
                  child: Text('Start Transaction',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                ),
              ),

              Text("Total Price: \$${widget.totalPrice.toStringAsFixed(2)}"),

              SizedBox(height: 20,),
              Text("Result\n$result"),
            ],
          ),
        ),
    );
  }

  void phonepeInit() {
    PhonePePaymentSdk.init(environment, appId, merchantId, enableLogging)
        .then((val) => {
              setState(() {
                result = 'PhonePe SDK Initialized - $val';
              })
            })
        .catchError((error) {
      handleError(error);
      return <dynamic>{};
    });
  }

  void startPgTransaction() async {
    try {
      var response = PhonePePaymentSdk.startPGTransaction(
          body, callbackurl, checksum, {}, apiEndPoint, "");
      response
          .then((val) => {
                setState(() {
                  if (val != null) {
                    String status = val['status'].toString();
                    String error = val['error'].toString();
                    if (status == "SUCCESS") {
                      result = "Flow complete-status:SUCCESS";
                    } else {
                      result = "Flow complete-status:$status and error $error";
                    }
                  } else {
                    result = "Flow Incomplete";
                  }
                })
              })
          .catchError((error) {
        handleError(error);
        return <dynamic>{};
      });
    } catch (error) {
      handleError(error);
    }
  }

// handle ko create kiye hai jisme hm error ko handle krenge
  void handleError(error) {
    setState(() {
      result = {"error": error};
    });
  }
}
