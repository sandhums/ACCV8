//
//  ProcedureRepView.swift
//  ACCV8
//
//  Created by Manjinder Sandhu on 13/07/22.
//

import SwiftUI
import RealmSwift

struct ProcedureRepView: View {
    @Environment(\.realm) var realm
    @Environment(\.dismiss) var dismiss
//    @ObservedRealmObject var user: Reps
    @ObservedResults(Reps.self) var users
    @ObservedRealmObject var report: ProcedureReport

    
    @State private var reportedBy = accApp.currentUser?.profile.email
    @State private var reportedById = accApp.currentUser?.id
    @State private var reportOfCentre = ""
    @State private var reportDate = Date()
    @State private var procName1 = "Angiography"
    @State private var procName2 = "Angioplasty"
    @State private var procName3 = "PPI/ICD"
    @State private var procName4 = ""
    @State private var procName5 = "ECHO"
    @State private var procName6 = "TMT"
    @State private var procName7 = "Holter"
    @State private var procName8 = ""
    @State private var procQty = 0
    @State private var procQty2 = 0
    @State private var procQty3 = 0
    @State private var procQty4 = 0
    @State private var procQty5 = 0
    @State private var procQty6 = 0
    @State private var procQty7 = 0
    @State private var procQty8 = 0
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                }
      
        .background(Color("Background"))
        .frame(maxWidth: .infinity)
//        .frame(height: 500)
        .background(
            Image("background-1")
                .resizable()
                .aspectRatio(contentMode: .fill)
//                .opacity(0.8)
                .ignoresSafeArea()
                .accessibility(hidden: true))
        .overlay(
            VStack {
                DatePicker(selection: $reportDate, label: { Text("Report Date") })
                Divider()
                    .foregroundColor(.secondary)
                Group {
                    HStack {
                        Text("\(procName1) - ")
                        Stepper( value: $procQty, in: 0...15) {
                            Text("\(procQty)")
                        }
                    
                    }
                    HStack {
                        Text("\(procName2) - ")
                        Stepper(value: $procQty2, in: 0...15) {
                            Text("\(procQty2)")
                        }
                    }
                    HStack {
                        Text("\(procName3) - ")
                        Stepper(value: $procQty3, in: 0...10) {
                            Text("\(procQty3)")
                        }
                    }
                    HStack {
                        TextField(" Enter Other", text: $procName4)
                        Stepper(value: $procQty4, in: 0...10) {
                            Text("\(procQty4)")
                        }
                }
                }
                Divider()
                    .foregroundColor(.secondary)
                Group {
                    HStack {
                        Text("\(procName5) - ")
                        Stepper(value: $procQty5, in: 0...20) {
                            Text("\(procQty5)")
                        }
                    }
                    HStack {
                        Text("\(procName6) - ")
                        Stepper(value: $procQty6, in: 0...20) {
                            Text("\(procQty6)")
                        }
                    }
                    HStack {
                        Text("\(procName7) - ")
                        Stepper(value: $procQty7, in: 0...10) {
                            Text("\(procQty7)")
                        }
                    }
                    HStack {
                        TextField(" Enter Other", text: $procName8)
                        Stepper(value: $procQty8, in: 0...10) {
                            Text("\(procQty8)")
                        }
                    }
                }
                Divider()
                    .foregroundColor(.secondary)
                Button {
                    insertReport()

                } label: {
                    AngularButton(title: "Submit")
                }
            }
                .padding(20)
                .padding(.vertical, 10)
                .background(
                    Rectangle()
                        .fill(.ultraThinMaterial)
                        .frame(maxHeight: .infinity, alignment: .bottom)
                        .cornerRadius(30)
                        .blur(radius: 30)
        )
                .background(
                    Rectangle()
                        .fill(.ultraThinMaterial)
                        .backgroundStyle(cornerRadius: 30)
//                        .opacity(appear[0] ? 1 : 0)
                )
                .padding(20)
          )
            Button (action: {
                dismiss()
            }, label: {
                CloseButton()
            })
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
            .padding(20)
            .ignoresSafeArea()
            Text("Submit Procedure Report")
                .font(.title3).bold()
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                .padding(40)
        }
        .task {
            do {
            try await setSubscription()
            } catch {
                
            }
        }
}
//    func saveRep() {
//        let user = users.first
//        let reportOfCentre = user!.userCentre
//        let report = ProcedureReport(value: [ObjectId.generate(), reportedBy!, reportedById!, reportOfCentre, reportDate, [[procName1, procQty],[procName2, procQty2],[procName3, procQty3],[procName4, procQty4], [procName5, procQty5], [procName6, procQty6], [procName7, procQty7], [procName8, procQty8]]])
//        do {
//        let realm = try Realm()
//        realm.writeAsync {
//            realm.add(report)
//            print("report saved")
//            dismiss()
//        }
//        } catch {
//            print("error saving report")
//        }
//
//    }
    func insertReport() {
        let rep = users.first
        reportOfCentre = rep!.userCentre
        let user = accApp.currentUser!
        let client = user.mongoClient("mongodb-atlas")
         let database = client.database(named: "ACC8DB")
         let collection = database.collection(withName: "ProcedureReport")
         // Insert the custom user data object
        collection.insertOne([
            "_id": AnyBSON(ObjectId.generate()),
            "reportOfCentre": AnyBSON(reportOfCentre),
            "reportedBy": AnyBSON(reportedBy!),
            "reportedById": AnyBSON(reportedById!),
            "reportDate": AnyBSON(reportDate),
            "procedures.procName": [[AnyBSON(procName1)],[AnyBSON(procName2)], [AnyBSON(procName3)],[AnyBSON(procName4)],[AnyBSON(procName5)],[AnyBSON(procName6)],[AnyBSON(procName7)],[AnyBSON(procName8)]],
            "procedures.procQty" : [[AnyBSON(procQty)],[AnyBSON(procQty2)],[AnyBSON(procQty3)],[AnyBSON(procQty4)],[AnyBSON(procQty5)],[AnyBSON(procQty6)],[AnyBSON(procQty7)],[AnyBSON(procQty8)],]
             ]) { (result) in
             switch result {
             case .failure(let error):
                 print("Failed to insert document: \(error.localizedDescription)")
             case .success(let newObjectId):
                 print("Inserted custom user data document with object ID: \(newObjectId)")
             }
             }
    }
    private func setSubscription() async throws {
        let subscriptions = realm.subscriptions
        let foundSubscription = subscriptions.first(named: "allProcRep")
        try await subscriptions.update {
            if foundSubscription != nil {
                foundSubscription!.updateQuery(toType: ProcedureReport.self)
                print("updating query allProcRep")
            } else {
                subscriptions.append(
                    QuerySubscription<ProcedureReport>(name: "allProcRep"))
                print("appending query allProcRep")
            }
        }
    }

}

struct ProcedureRepView_Previews: PreviewProvider {
    static var previews: some View {
        ProcedureRepView(report: ProcedureReport())
    }
}
