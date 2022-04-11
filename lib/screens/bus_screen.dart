import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../widgets/bus_screen_widgets/bus_comments.dart';

class BusScreen extends StatelessWidget {
  const BusScreen({Key? key, dbName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("bus").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasData) {
            var docs = snapshot.data?.docs;

            return Container(
              padding: const EdgeInsets.all(20),
              height: MediaQuery.of(context).size.height - 100,
              child: ListView.builder(
                itemBuilder: (context, index) {
                  //calculate rating for each driver
                  double sum = 0;
                  for (int i = 0; i < docs?[index]["reviews"].length; i++) {
                    sum += docs?[index]["reviews"][i]["busInfra"];
                  }
                  sum /= docs?[index]["reviews"].length;
                  sum = double.parse((sum).toStringAsFixed(2));
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return BusCommentsScreen(comm: docs?[index]["reviews"]);
                      }));
                    },
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(border: Border.all(width: 0.5)),
                      height: 70,
                      width: 120,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(docs?[index]["busNo"],
                              style: const TextStyle(fontSize: 18)),
                          Row(
                            children: [
                              const Icon(
                                Icons.star_outlined,
                                color: Colors.orange,
                                size: 32,
                              ),
                              Text(
                                sum.toString(),
                                style: const TextStyle(fontSize: 24),
                              ),
                              IconButton(
                                  onPressed: () {
                                    Navigator.push(context, MaterialPageRoute(
                                      builder: (context) {
                                        return BusCommentsScreen(
                                            comm: docs?[index]["reviews"]);
                                      },
                                    ));
                                  },
                                  icon: const Icon(
                                    Icons.navigate_next_sharp,
                                    size: 32,
                                  ))
                            ],
                          )
                          // Text(rating.toString())
                        ],
                      ),
                    ),
                  );
                },
                itemCount: docs?.length,
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    ));
  }
}
