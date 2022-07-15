//
//  RevenueRepView.swift
//  ACCV8
//
//  Created by Manjinder Sandhu on 13/07/22.
//

import SwiftUI
import RealmSwift

struct RevenueRepView: View {
  
    @Environment(\.realm) var realm
    @Environment(\.dismiss) var dismiss
    @ObservedRealmObject var user: Reps
//  @ObservedResults(Reps.self) var users

    
    @State private var revenueReportedBy = accApp.currentUser?.profile.email
    @State private var revenueReportedById = accApp.currentUser?.id
    @State private var revenueOfCentre = ""
    @State private var revenueDate = Date()
    @State private var revenueIPD = ""
    @State private var revenueOPD = ""
    @State private var revenueTot = 0.0
    @State private var collectAmt = ""
    @FocusState private var focussedField: Field?
    
    enum Field: Hashable {
        case revenueIPD
        case revenueOPD
        case collectAmt
    }
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
             
                DatePicker(selection: $revenueDate, label: { Text("Report Date") })
    
                TextField("Revenue IPD", text: $revenueIPD)
                        .keyboardType(.numberPad)
                        .focused($focussedField, equals: .revenueIPD )
                        .submitLabel(.next)
                        .onSubmit { focussedField = .revenueOPD }
                        .customField(icon: "indianrupeesign.circle")
                  
                TextField("Revenue OPD", text: $revenueOPD)
                        .keyboardType(.numberPad)
                        .focused($focussedField, equals: .revenueOPD)
                        .submitLabel(.next)
                        .onSubmit { focussedField = .collectAmt  }
                        .customField(icon: "indianrupeesign.circle")
                   
                    TextField("Collection", text: $collectAmt)
                        .keyboardType(.numberPad)
                        .focused($focussedField, equals: .collectAmt)
                        .submitLabel(.next)
                        .onSubmit { insertReport() }
                        .customField(icon: "indianrupeesign.circle.fill")
                       
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
            Text("Submit Revenue Report")
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
    func insertReport() {
        revenueOfCentre = user.userCentre
        let revIPDouble = Double(revenueIPD) ?? 0.0
        let revOPDouble = Double(revenueOPD) ?? 0.0
        let revenueTot = revIPDouble + revOPDouble
        let collectAmtDouble = Double(collectAmt) ?? 0.0
        let user = accApp.currentUser!
        let client = user.mongoClient("mongodb-atlas")
         let database = client.database(named: "ACC8DB")
         let collection = database.collection(withName: "RevenueReport")
         // Insert the custom user data object
        collection.insertOne([
            "_id": AnyBSON(ObjectId.generate()),
            "revenueReportedBy": AnyBSON(revenueReportedBy ?? "sdfgh"),
            "revenueReportedById": AnyBSON(revenueReportedById!),
            "revenueOfCentre": AnyBSON(revenueOfCentre),
            "revenueDate": AnyBSON(revenueDate),
            "revenueIPD": AnyBSON(revIPDouble),
            "revenueOPD": AnyBSON(revOPDouble),
            "revenueTot": AnyBSON(revenueTot),
            "collectAmt": AnyBSON(collectAmtDouble)
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
        let foundSubscription = subscriptions.first(named: "allRevRep")
        try await subscriptions.update {
            if foundSubscription != nil {
                foundSubscription!.updateQuery(toType: RevenueReport.self)
                print("updating query allRevRep")
            } else {
                subscriptions.append(
                    QuerySubscription<RevenueReport>(name: "allRevRep"))
                print("appending query allRevRep")
            }
        }
    }
}

struct RevenueRepView_Previews: PreviewProvider {
    static var previews: some View {
        RevenueRepView(user: Reps())
    }
}
