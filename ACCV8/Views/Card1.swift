//
//  Card1.swift
//  ACCV8
//
//  Created by Manjinder Sandhu on 01/09/22.
//

import SwiftUI


struct Card1: View {
    var body: some View {
            VStack {
                VStack(alignment: .leading, spacing: 14) {
                    Text("App Walkthrough - 1/5 - First Screen")
                        .font(.footnote)
                        .fontWeight(.semibold)
                        .foregroundColor(Color.white.opacity(0.7))
                    Text("Note - Walkthrough won't be shown again, once you click - Skip Tour. Read carefully!")
                        .font(.caption)
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
                        .mask(Text("Sign In/Up")
                                .font(.title2)
                                .bold()
                                .frame(maxWidth: .infinity, alignment: .leading))
                    HStack {
                    Text("Click Sign Up to create your account with email and password or existing users can Sign In. Alternatively,You can directly Sign in with your Apple ID ")
                        .font(.subheadline)
                        .foregroundColor(Color.white.opacity(0.7))
                  
                   Image("login")
                            .resizable()
                            .scaledToFit()
                    }
                    Text("On creating new acccount you will get alert for confirmation required, please check your email to confirm before logging in. ")
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
//                .background(
//                    VisualEffectBlurView(blurStyle: .systemUltraThinMaterialDark)
//                        .mask(RoundedRectangle(cornerRadius: 30, style: .continuous)
//                                .fill(LinearGradient(gradient: Gradient(colors: [Color.red, Color.red,  Color.blue.opacity(0)]), startPoint: .top, endPoint: .bottom)))
//                )
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
//            .background(
//                VisualEffectBlurView(blurStyle: .systemUltraThinMaterialDark)
//                    .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
//                    .blur(radius: 30)
//            )
            .padding(20)
        }
    }


struct Card1_Previews: PreviewProvider {
    static var previews: some View {
        Card1()
    }
}
