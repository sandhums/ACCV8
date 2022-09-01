//
//  Card4.swift
//  ACCV8
//
//  Created by Manjinder Sandhu on 01/09/22.
//

import SwiftUI


struct Card4: View {
    var body: some View {
            VStack {
                VStack(alignment: .leading, spacing: 14) {
                    Text("App Walkthrough - 4/5")
                        .font(.footnote)
                        .fontWeight(.semibold)
                        .foregroundColor(Color.white.opacity(0.7))
                    LinearGradient(
                                gradient: Gradient(stops: [
                            .init(color: Color(#colorLiteral(red: 0.03333336114883423, green: 0.5024509429931641, blue: 1, alpha: 1)), location: 0),
                            .init(color: Color(#colorLiteral(red: 0.7291666269302368, green: 0.7562500238418579, blue: 1, alpha: 1)), location: 0.5629924535751343),
                            .init(color: Color(#colorLiteral(red: 1, green: 0.6083333492279053, blue: 0.8732843995094299, alpha: 1)), location: 1)]),
                                startPoint: UnitPoint(x: 1.0125392039427847, y: 1.0175438863216821),
                                endPoint: UnitPoint(x: -1.1102230246251565e-16, y: 0))
                        .frame(height: 60)
                        .mask(Text("Chat")
                                .font(.title2)
                                .bold()
                                .frame(maxWidth: .infinity, alignment: .leading))
                    HStack {
                    Text("Chat functionality for users. Supports \n * Group Chat \n * Online status \n * Location \n * Images \n Tap on **Start New Chat** to create new Chat Room.")
                        .font(.subheadline)
                        .foregroundColor(Color.white.opacity(0.7))
                  
                   Image("chat")
                            .resizable()
                            .scaledToFit()
                    }
                    Text("Main screen shows list of Active Chats. Tap on the name to go to the Chat Room. Swipe left to delete old chats.")
                        .font(.subheadline)
                        .foregroundColor(Color.white.opacity(0.7))
                }
                
                .padding(30)
                .background(LinearGradient(
                                gradient: Gradient(stops: [
                                                    .init(color: Color(#colorLiteral(red: 0.14509804546833038, green: 0.12156862765550613, blue: 0.2549019753932953, alpha: 1)), location: 0),
                                                    .init(color: Color(#colorLiteral(red: 0.14509804546833038, green: 0.12156862765550613, blue: 0.2549019753932953, alpha: 0)), location: 1)]),
                                startPoint: UnitPoint(x: 0.49999988837676157, y: 2.9497591284275417e-15),
                                endPoint: UnitPoint(x: 0.4999999443689973, y: 0.9363635917143408)))
                .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
                .overlay(
                    RoundedRectangle(cornerRadius: 30, style: .continuous)
                        .stroke(LinearGradient(
                                    gradient: Gradient(stops: [
                                .init(color: Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.800000011920929)), location: 0),
                                .init(color: Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)), location: 1)]),
                                    startPoint: UnitPoint(x: 0.5, y: -3.06161911669639e-17),
                                    endPoint: UnitPoint(x: 0.5000000000000001, y: 0.49999999999999994)), lineWidth: 1)
                        .blendMode(.overlay)
                        .overlay(
                            RoundedRectangle(cornerRadius: 30, style: .continuous)
                                .stroke(LinearGradient(
                                            gradient: Gradient(stops: [
                                        .init(color: Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.800000011920929)), location: 0),
                                        .init(color: Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)), location: 1)]),
                                            startPoint: UnitPoint(x: 0.5, y: -3.06161911669639e-17),
                                            endPoint: UnitPoint(x: 0.5000000000000001, y: 0.49999999999999994)), lineWidth: 3)
                                .blur(radius: 10)
                        )
                )
    
                .padding(20)
            }
            .padding(.bottom, 20)
            .background(LinearGradient(
                            gradient: Gradient(stops: [
                                                .init(color: Color(#colorLiteral(red: 0.14509804546833038, green: 0.12156862765550613, blue: 0.2549019753932953, alpha: 1)).opacity(0), location: 0),
                                                .init(color: Color(#colorLiteral(red: 0.14509804546833038, green: 0.12156862765550613, blue: 0.2549019753932953, alpha: 1)), location: 1)]),
                            startPoint: UnitPoint(x: 0.49999988837676157, y: 2.9497591284275417e-15),
                            endPoint: UnitPoint(x: 0.4999999443689973, y: 0.9363635917143408)))
            .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: 30, style: .continuous)
                    .stroke(LinearGradient(
                                gradient: Gradient(stops: [
                            .init(color: Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)), location: 0),
                            .init(color: Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.800000011920929)), location: 1)]),
                                startPoint: UnitPoint(x: 0.5, y: -3.06161911669639e-17),
                                endPoint: UnitPoint(x: 0.5000000000000001, y: 0.49999999999999994)), lineWidth: 1)
                    .blendMode(.overlay)
                    .overlay(
                        RoundedRectangle(cornerRadius: 30, style: .continuous)
                            .stroke(LinearGradient(
                                        gradient: Gradient(stops: [
                                    .init(color: Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)), location: 0),
                                    .init(color: Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.800000011920929)), location: 1)]),
                                        startPoint: UnitPoint(x: 0.5, y: -3.06161911669639e-17),
                                        endPoint: UnitPoint(x: 0.5000000000000001, y: 0.49999999999999994)), lineWidth: 3)
                            .blur(radius: 10)
                    )
            )

            .padding(20)
        }
}

struct Card4_Previews: PreviewProvider {
    static var previews: some View {
        Card4()
    }
}

