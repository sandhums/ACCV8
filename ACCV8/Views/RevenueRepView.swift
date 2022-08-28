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
//    @ObservedRealmObject var user: Reps
  @ObservedResults(Reps.self) var users
    @ObservedResults(RevenueReport.self) var revReps
//        @ObservedRealmObject var rep: RevenueReport
    
    @State private var revenueReportedBy = accApp.currentUser?.profile.email
    @State private var revenueReportedById = accApp.currentUser?.id
    @State private var revenueOfCentre = ""
    @State private var revenueDate = Date()
    @State private var revenueIPD = ""
    @State private var revenueOPD = ""
    @State private var revenueTot = 0.0
    @State private var collectAmt = ""
    @FocusState private var focussedField: Field?
    @State private var alertTitle = "Artemis Cardiac Care Alert!"
    @State private var alertMessage = ""
    @State private var showAlertToggle = false
    
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
             
                DatePicker(selection: $revenueDate, label: { Text("Date") })
    
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
                        .onSubmit { saveRevRep() }
                        .customField(icon: "indianrupeesign.circle.fill")
                       
                    Button {
                      saveRevRep()

                    } label: {
                        AngularButton(title: "Submit")
                    }
                    .buttonStyle(.plain)
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
            .buttonStyle(.plain)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
            .padding(20)
            .ignoresSafeArea()
            Text("Submit Revenue Report")
                .font(.title3).bold()
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                .padding(40)
        }
        .alert(isPresented: $showAlertToggle, content: {
            Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            })
        .task {
            do {
            try await setSubscription()
            } catch {
                
            }
        }
}
    func saveRevRep() {
        let revIPDouble = Double(revenueIPD) ?? 0.0
        let revOPDouble = Double(revenueOPD) ?? 0.0
        let revenueTot = revIPDouble + revOPDouble
        let collectAmtDouble = Double(collectAmt) ?? 0.0
        let reps = users.first
        revenueOfCentre = reps!.centreName
        let rep = RevenueReport()
        rep.revenueReportedBy = revenueReportedBy!
        rep.revenueReportedById = revenueReportedById!
        rep.centreName = revenueOfCentre
        rep.revenueDate = revenueDate
        rep.revenueIPD = revIPDouble
        rep.revenueOPD = revOPDouble
        rep.revenueTot = revenueTot
        rep.collectAmt = collectAmtDouble
        $revReps.append(rep)
        
        accApp.syncManager.errorHandler = { error, session in
                alertTitle = "Artemis Cardiac Care Alert!"
                alertMessage = "You are not authorised to submit reports \n Please Log In, again"
                showAlertToggle.toggle()
            accApp.currentUser?.logOut { _ in

            }
            }
       
                            alertTitle = "Artemis Cardiac Care Alert!"
                            alertMessage = "Report submitted"
                            showAlertToggle.toggle()
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
        RevenueRepView()
    }
}
