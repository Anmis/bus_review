import 'package:cloud_firestore/cloud_firestore.dart';

updateDriver(userInputData, data) {
  FirebaseFirestore.instance
      .collection("driver")
      .doc(data[1].toLowerCase())
      .update(
    {
      "reviews": FieldValue.arrayUnion(
        [
          {
            "driverName": data[1].toLowerCase(),
            "busNum": data[0],
            "from": data[2],
            "to": data[3],
            "pace": userInputData["pace"],
            "driverRate": userInputData["driverRate"],
            "driverBehaviour": userInputData["driverBehaviour"],
            "remark": userInputData["remark"],
            "overallRate": userInputData["overallRate"]
          }
        ],
      )
    },
  );
}

setDriver(userInputData, data) {
  FirebaseFirestore.instance
      .collection("driver")
      .doc(data[1].toLowerCase())
      .set({
    "driverName": data[1].toLowerCase(),
    "reviews": [
      {
        "driverName": data[1].toLowerCase(),
        "busNum": data[0],
        "from": data[2],
        "to": data[3],
        "pace": userInputData["pace"],
        "driverRate": userInputData["driverRate"],
        "driverBehaviour": userInputData["driverBehaviour"],
        "remark": userInputData["remark"],
        "overallRate": userInputData["overallRate"]
      }
    ]
  });
}

updateBus(userInputData, data) {
  FirebaseFirestore.instance.collection("bus").doc(data[0]).update({
    "busNo": data[0],
    "reviews": FieldValue.arrayUnion([
      {
        "busNo": data[0],
        "busInfra": userInputData["busInfra"],
        "busSeats": userInputData["busSeats"]
      }
    ])
  });
}

SetBus(userInputData, data) {
  FirebaseFirestore.instance.collection("bus").doc(data[0]).set({
    "reviews": [
      {
        "busNo": data[0],
        "busInfra": userInputData["busInfra"],
        "busSeats": userInputData["busSeats"]
      }
    ]
  });
}
