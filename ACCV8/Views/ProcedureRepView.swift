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
    @EnvironmentObject var model: Model
    @Environment(\.dismiss) var dismiss
    @ObservedResults(Reps.self) var users
    @ObservedResults(ProcedureReport.self) var procReports
//    @ObservedRealmObject var user: Reps
    @State var isLoggingOut = false
    @State var error: Error?
    @State var errorMessage: ErrorMessage? = nil
    @State private var alertTitle = "Artemis Cardiac Care Alert!"
    @State private var alertMessage = ""
    @State private var showAlertToggle = false
   
    
    @State private var reportedBy = accApp.currentUser?.profile.email
    @State private var reportedById = accApp.currentUser?.id
    @State private var reportOfCentre = ""
    @State private var reportDate = Date()
    @State private var procName1 = "Angiography"
    @State private var procName2 = "Angioplasty"
    @State private var procName3 = "PPI/ICD"
    @State private var procName4 = "BMV/EP/RFA"
    @State private var procName5 = "ECHO"
    @State private var procName6 = "TMT"
    @State private var procName7 = "Holter"
    @State private var procName8 = "DSE/SE"
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
            Image("Background 11")
                .resizable()
                .aspectRatio(contentMode: .fill)
//                .opacity(0.8)
                .ignoresSafeArea()
                .accessibility(hidden: true))
        
        .overlay(
            VStack {
                DatePicker(selection: $reportDate, label: { Text("Date") })
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
                        Text("\(procName4) - ")
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
                        Text("\(procName8) - ")
                        Stepper(value: $procQty8, in: 0...10) {
                            Text("\(procQty8)")
                        }
                    }
                }
                Divider()
                    .foregroundColor(.secondary)
                Button {
                   saveProcRep()

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
        .alert(isPresented: $showAlertToggle, content: {
            Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            })
}
    func saveProcRep() {
     
        let reps = users.first
        reportOfCentre = reps!.centreName
        let p1 = Procedures(value: ["procName": procName1, "procQty": procQty])
        let p2 = Procedures(value: ["procName": procName2, "procQty": procQty2])
        let p3 = Procedures(value: ["procName": procName3, "procQty": procQty3])
        let p4 = Procedures(value: ["procName": procName4, "procQty": procQty4])
        let p5 = Procedures(value: ["procName": procName5, "procQty": procQty5])
        let p6 = Procedures(value: ["procName": procName6, "procQty": procQty6])
        let p7 = Procedures(value: ["procName": procName7, "procQty": procQty7])
        let p8 = Procedures(value: ["procName": procName8, "procQty": procQty8])
        let rep = ProcedureReport()
        rep.reportedBy = reportedBy!
        rep.reportedById = reportedById!
        rep.centreName = reportOfCentre
        rep.reportDate = reportDate
        rep.procedures.append(objectsIn: [p1, p2, p3, p4, p5, p6, p7, p8])
        $procReports.append(rep)
     
//        guard accApp.syncManager.errorHandler == nil else {
//                        alertTitle = "Artemis Cardiac Care Alert!"
//                        alertMessage = "Report submitted"
//                        showAlertToggle.toggle()
//            return
//        }
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
    private func clearSubscriptions() {
        let subscriptions = realm.subscriptions
        subscriptions.update {
            subscriptions.removeAll()
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
        ProcedureRepView()
    }
}
