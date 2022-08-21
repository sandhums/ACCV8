//
//  ConsumptionRepView.swift
//  ACCV8
//
//  Created by Manjinder Sandhu on 27/07/22.
//

import SwiftUI
import RealmSwift

struct ConsumptionRepView: View {
    @Environment(\.realm) var realm
    @Environment(\.dismiss) var dismiss
    @ObservedResults(Reps.self) var users
    @ObservedResults(ConsumptionReport.self) var consReports
    @ObservedResults(Consumables.self) var consumables
    @State private var reportedBy = accApp.currentUser?.profile.email
    @State private var reportedById = accApp.currentUser?.id
    @State private var reportOfCentre = ""
    @State private var reportDate = Date()
    @State private var consName1 = ""
    @State private var consName2 = ""
    @State private var consName3 = ""
    @State private var consName4 = ""
    @State private var consName5 = ""
    @State private var consName6 = ""
    @State private var consName7 = ""
    @State private var consName8 = ""
    @State private var consName9 = ""
    @State private var consName10 = ""
    @State private var consName11 = ""
    @State private var consName12 = ""
    @State private var consName13 = ""
    @State private var consQty1 = 0
    @State private var consQty2 = 0
    @State private var consQty3 = 0
    @State private var consQty4 = 0
    @State private var consQty5 = 0
    @State private var consQty6 = 0
    @State private var consQty7 = 0
    @State private var consQty8 = 0
    @State private var consQty9 = 0
    @State private var consQty10 = 0
    @State private var consQty11 = 0
    @State private var consQty12 = 0
    @State private var consQty13 = 0
    @State private var consCat1 = "Stent"
    @State private var consCat2 = "PTCA Wire"
    @State private var consCat3 = "Balloons"
    @State private var consCat4 = "Others"
    
    
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
        .overlay (
            ScrollView {
            VStack {
               
            DatePicker(selection: $reportDate, label: { Text("Report Date") })
                Divider()
                    .foregroundColor(.secondary)
              
                    
            Group {
                Text("Stents")
                    .font(.caption.weight(.bold))
                    .foregroundStyle(.primary)
                let stents = consumables.where {
                    $0.category == "Stent"
                }
            HStack {
            Picker(selection: $consName1, label: Text("Select Stent")) {
                Text("Select Stent")
                ForEach(stents, id: \.self) { stent in
                    Text(stent.name).tag(stent.name)
                }
            }
                Stepper( value: $consQty1, in: 0...15) {
                    Text("\(consQty1)")
                }
            }
            HStack {
            Picker(selection: $consName2, label: Text("Select Stent")) {
                Text("Select Stent")
                ForEach(stents, id: \.self) { stent in
                    Text(stent.name).tag(stent.name)
                }
            }
                Stepper( value: $consQty2, in: 0...15) {
                    Text("\(consQty2)")
                }
            }
            HStack {
            Picker(selection: $consName3, label: Text("Select Stent")) {
                Text("Select Stent")
                ForEach(stents, id: \.self) { stent in
                    Text(stent.name).tag(stent.name)
                }
            }
                Stepper( value: $consQty3, in: 0...15) {
                    Text("\(consQty3)")
                }
            }
            HStack {
            Picker(selection: $consName4, label: Text("Select Stent")) {
                Text("Select Stent")
                ForEach(stents, id: \.self) { stent in
                    Text(stent.name).tag(stent.name)
                }
            }
                Stepper( value: $consQty4, in: 0...15) {
                    Text("\(consQty4)")
                }
            }
            }
            
            Group {
                Text("PTCA Wires")
                    .font(.caption.weight(.bold))
                    .foregroundStyle(.primary)
                let wires = consumables.where {
                    $0.category == "PTCA Wire"
                }
                HStack {
                Picker(selection: $consName5, label: Text("Select Wire")) {
                    Text("Select Wire")
                    ForEach(wires, id: \.self) { wire in
                        Text(wire.name).tag(wire.name)
                    }
                }
                    Stepper( value: $consQty5, in: 0...15) {
                        Text("\(consQty5)")
                    }
                }
                HStack {
                Picker(selection: $consName6, label: Text("Select Wire")) {
                    Text("Select Wire")
                    ForEach(wires, id: \.self) { wire in
                        Text(wire.name).tag(wire.name)
                    }
                }
                    Stepper( value: $consQty6, in: 0...15) {
                        Text("\(consQty6)")
                    }
                }
                HStack {
                Picker(selection: $consName7, label: Text("Select Wire")) {
                    Text("Select Wire")
                    ForEach(wires, id: \.self) { wire in
                        Text(wire.name).tag(wire.name)
                    }
                }
                    Stepper( value: $consQty7, in: 0...15) {
                        Text("\(consQty7)")
                    }
                }
            }
               
            Group {
                Text("Balloons")
                    .font(.caption.weight(.bold))
                    .foregroundStyle(.primary)
                let balloons = consumables.where {
                    $0.category == "Balloon"
                }
                HStack {
                Picker(selection: $consName8, label: Text("Select Balloon")) {
                    Text("Select Balloon")
                    ForEach(balloons, id: \.self) { balloon in
                        Text( balloon.name).tag( balloon.name)
                    }
                }
                    Stepper( value: $consQty8, in: 0...15) {
                        Text("\(consQty8)")
                    }
                }
                HStack {
                Picker(selection: $consName10, label: Text("Select Balloon")) {
                    Text("Select Balloon")
                    ForEach(balloons, id: \.self) { balloon in
                        Text( balloon.name).tag( balloon.name)
                    }
                }
                    Stepper( value: $consQty10, in: 0...15) {
                        Text("\(consQty10)")
                    }
                }
                HStack {
                Picker(selection: $consName9, label: Text("Select Balloon")) {
                    Text("Select Balloon")
                    ForEach(balloons, id: \.self) { balloon in
                        Text( balloon.name).tag( balloon.name)
                    }
                }
                    Stepper( value: $consQty9, in: 0...15) {
                        Text("\(consQty9)")
                    }
                }
                }
              
                Group {
                    Text("Other Items")
                        .font(.caption.weight(.bold))
                        .foregroundStyle(.primary)
                    let others = consumables.where {
                        $0.category == "Others"
                    }
                    HStack {
                    Picker(selection: $consName13, label: Text("Select Other")) {
                        Text("Select Other")
                        ForEach(others, id: \.self) { other in
                            Text( other.name).tag(other.name)
                        }
                    }
                        Stepper( value: $consQty13, in: 0...15) {
                            Text("\(consQty13)")
                        }
                    }
                    HStack {
                    Picker(selection: $consName11, label: Text("Select Other")) {
                        Text("Select Other")
                        ForEach(others, id: \.self) { other in
                            Text( other.name).tag(other.name)
                        }
                    }
                        Stepper( value: $consQty11, in: 0...15) {
                            Text("\(consQty11)")
                        }
                    }
                    HStack {
                    Picker(selection: $consName12, label: Text("Select Other")) {
                        Text("Select Other")
                        ForEach(others, id: \.self) { other in
                            Text( other.name).tag(other.name)
                        }
                    }
                        Stepper( value: $consQty12, in: 0...15) {
                            Text("\(consQty12)")
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
        }
        .accentColor(.primary)
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
        .padding(EdgeInsets(top: 60, leading: 10, bottom: 20, trailing: 10))
            }
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
        Text("Submit Consumption Report")
                .font(.subheadline).bold()
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .padding(20)
        }
            .task {
                do {
                try await setSubscription()
                } catch {
                    
                }
            }
        
    }
    func saveProcRep() {
        let reps = users.first
        reportOfCentre = reps!.centreName
        let p1 = ConsumptionItems(value: ["category": consCat1, "name": consName1, "quantity": consQty1])
        let p2 = ConsumptionItems(value: ["category": consCat1, "name": consName2, "quantity": consQty2])
        let p3 = ConsumptionItems(value: ["category": consCat1, "name": consName3, "quantity": consQty3])
        let p4 = ConsumptionItems(value: ["category": consCat1, "name": consName4, "quantity": consQty4])
        let p5 = ConsumptionItems(value: ["category": consCat2, "name": consName5, "quantity": consQty5])
        let p6 = ConsumptionItems(value: ["category": consCat2, "name": consName6, "quantity": consQty6])
        let p7 = ConsumptionItems(value: ["category": consCat2, "name": consName7, "quantity": consQty7])
        let p8 = ConsumptionItems(value: ["category": consCat3, "name": consName8, "quantity": consQty8])
        let p9 = ConsumptionItems(value: ["category": consCat3, "name": consName9, "quantity": consQty9])
        let p10 = ConsumptionItems(value: ["category": consCat3, "name": consName10, "quantity": consQty10])
        let p11 = ConsumptionItems(value: ["category": consCat4, "name": consName11, "quantity": consQty11])
        let p12 = ConsumptionItems(value: ["category": consCat4, "name": consName12, "quantity": consQty12])
        let p13 = ConsumptionItems(value: ["category": consCat4, "name": consName13, "quantity": consQty13])
        let rep = ConsumptionReport()
        rep.reportedBy = reportedBy!
        rep.reportedById = reportedById!
        rep.centreName = reportOfCentre
        rep.reportDate = reportDate
        rep.consumptionItems.append(objectsIn: [p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13])
        $consReports.append(rep)
        print("consumption saved")
        dismiss()
    }
    private func setSubscription() async throws {
        let subscriptions = realm.subscriptions
        let foundSubscription = subscriptions.first(named: "allConsumables")
        try await subscriptions.update {
            if foundSubscription != nil {
                foundSubscription!.updateQuery(toType: Consumables.self)
                print("updating query allConsumables")
            } else {
                subscriptions.append(
                    QuerySubscription<Consumables>(name: "allConsumables"))
                print("appending query allConsumables")
            }
        }
        let foundSubscription2 = subscriptions.first(named: "ConsReport")
        try await subscriptions.update {
            if foundSubscription2 != nil {
                foundSubscription2!.updateQuery(toType: ConsumptionReport.self)
                print("updating query ConsReport")
            } else {
                subscriptions.append(
                    QuerySubscription<ConsumptionReport>(name: "ConsReport"))
                print("appending query ConsReport")
            }
        }
    }
}

struct ConsumptionRepView_Previews: PreviewProvider {
    static var previews: some View {
        ConsumptionRepView()
    }
}
