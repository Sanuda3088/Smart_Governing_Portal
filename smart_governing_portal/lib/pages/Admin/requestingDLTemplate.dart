import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ReqDLTemplate extends StatefulWidget {
  final String documentId;
  const ReqDLTemplate({
    super.key,
    required this.documentId,
  });

  @override
  State<ReqDLTemplate> createState() => _ReqDLTemplateState();
}

class _ReqDLTemplateState extends State<ReqDLTemplate> {
  late Future<DocumentSnapshot<Map<String, dynamic>>> data;
  late double width;
  late double height;
  late String issuedDate;
  late String dlNo;

  @override
  void initState() {
    super.initState();
    data = FirebaseFirestore.instance
        .collection('DLtest')
        .doc(widget.documentId)
        .get();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 115, 185, 250),
          title: const FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                'License Card Template',
                style:
                    TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
              )),
        ),
        body: _body());
  }

  Widget _buildField(String label, String value) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            Text(
              '$label:',
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                value,
                style: const TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _body() {
    return Center(
      child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        future: data,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
                style: const TextStyle(color: Colors.red),
              ),
            );
          } else if (!snapshot.hasData || !snapshot.data!.exists) {
            return const Center(
              child: Text(
                'Document not found',
                style: TextStyle(color: Colors.red),
              ),
            );
          } else {
            var documentData = snapshot.data!.data()!;
            issuedDate = documentData['Issued Date'] ?? '';
            dlNo = documentData['License No'] ?? '';
            return SingleChildScrollView(
              child: Column(
                children: [
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Container(
                      constraints: BoxConstraints(
                        maxWidth: width * 0.8,
                        minHeight: height * 0.8,
                      ),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 249, 247, 232),
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(
                          color: Colors.black,
                          width: 1.0,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 10, left: 20, right: 20, bottom: 5),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text(
                                "Driving License",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              const Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Image(
                                      image: AssetImage(
                                          "lib/Assets/government.png"),
                                      width: 100,
                                      height: 100,
                                    ),
                                    Image(
                                      image:
                                          AssetImage("lib/Assets/person.png"),
                                      width: 100,
                                      height: 100,
                                    ),
                                  ]),
                              Column(
                                children: [
                                  _buildField('Full Name',
                                      documentData['Full Name'] ?? ''),
                                  _buildField(
                                      'NIC No', documentData['NIC'] ?? ''),
                                  _buildField('License No',
                                      documentData['License No'] ?? ''),
                                  _buildField(
                                      'Address', documentData['Address'] ?? ''),
                                  _buildField('Date of Birth',
                                      documentData['Date of Birth'] ?? ''),
                                  _buildField(
                                      'Gender', documentData['Gender'] ?? ''),
                                  _buildField('Blood Group',
                                      documentData['Blood Group'] ?? ''),
                                  _buildField('Document Number',
                                      documentData['Doc No'] ?? ''),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        issuedDate,
                                        style: const TextStyle(
                                            fontSize: 16,
                                            decoration:
                                                TextDecoration.underline,
                                            decorationStyle:
                                                TextDecorationStyle.dotted),
                                      ),
                                      const Text(
                                        "Date",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  const Column(
                                    children: [
                                      Text(
                                        ".......................",
                                        style: TextStyle(
                                            fontSize: 16,
                                            decoration:
                                                TextDecoration.underline,
                                            decorationStyle:
                                                TextDecorationStyle.dotted),
                                      ),
                                      Text(
                                        "Commissioner General of",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "Motor Traffic",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.0),
                                  border: Border.all(
                                    color: Colors.black,
                                    width: 1.0,
                                  ),
                                ),
                                child: const FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                    "Department of Motor Traffic - Sri Lanka",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Text(
                    'Please make sure all the fields are 100% correct',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.red),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton.icon(
                        onPressed: null,
                        icon: const Icon(
                          Icons.check_outlined,
                        ),
                        label: const Text("Correct"),
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.green),
                        ),
                      ),
                      const SizedBox(width: 5,),
                      ElevatedButton.icon(
                        onPressed: null,
                        icon: const Icon(
                          Icons.close,
                        ),
                        label: const Text("Incorrect",style: TextStyle(),),
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.green),
                        ),
                      )
                    ],
                  )
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
