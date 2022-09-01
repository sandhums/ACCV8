//
//  Onboarding.swift
//  ACCV8
//
//  Created by Manjinder Sandhu on 01/09/22.
//

import SwiftUI

struct Onboarding: View {
    @Binding var showOnBoarding: Bool
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                }
        .background(Color("Background"))
        .frame(maxWidth: .infinity)

        .background(
            Image("Background 12")
                .resizable()
                .aspectRatio(contentMode: .fill)
//                .opacity(0.8)
                .ignoresSafeArea()
                .accessibility(hidden: true))
            TabView() {
                Card1().tag(0)
                Card2().tag(1)
                Card3().tag(2)
                Card4().tag(3)
                Card5().tag(4)
            }
            .tabViewStyle(PageTabViewStyle())
            Button {
                showOnBoarding.toggle()
            } label: {
                Text("Skip Tour")
            }
            .buttonStyle(.plain)
            .foregroundColor(.white)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
            .padding()
        }
    }
}

struct Onboarding_Previews: PreviewProvider {
    static var previews: some View {
        Onboarding(showOnBoarding: .constant(false))
    }
}
