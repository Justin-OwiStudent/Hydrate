
import Foundation
import Firebase
import FirebaseFirestore


class StepViewModel: ObservableObject {

    let db = Firestore.firestore()

    let Colname = "Steps"

    //list of items
    @Published var StepsList = [Step]()

    func getAllStepData() {

        db.collection(Colname).getDocuments {snapshot, err in

            if err == nil {
                DispatchQueue.main.async {
                    self.StepsList = snapshot!.documents.map{d in
                        return Step(
                            docId: d.documentID,
                            title: d["title"] as? String ?? "None - cant find title",
                            stepCount: d["stepCount"] as? String ?? "None - cant find stepCount",
                            date: d["date"] as? String ?? "None - cant find date"
                        )
                    }
                }
            } else {
                print(err?.localizedDescription ?? "Something went wrong while getting docs.")
            }

        }

    }




    static func CreateStepData(collectionName: String, stepCount: Double) {
        let db = Firestore.firestore()
        let uuidString = UUID().uuidString
        // Create a dictionary to store the step count data
        let data: [String: Any] = [
            "id": uuidString,
            "stepCount": stepCount,
            "timestamp": Date()
        ]

        db
            .collection("Steps")
            .document()
            .setData(data) { err in
                if let err = err {
                    print("error creating steps \(err.localizedDescription)")
                } else {
                    print("Document saved")
                }
            }
    }

}

