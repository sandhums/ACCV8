//
//  FeaturedItem.swift
//  ACCV8
//
//  Created by Manjinder Sandhu on 01/07/22.
//

import SwiftUI
import RealmSwift

struct FeaturedItem: View {
    @Environment(\.realm) var realm
    @ObservedResults(Centre.self) var centres
    var centre: Centre
    @Environment(\.sizeCategory) var sizeCategory
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Spacer()
            Image(uiImage: UIImage(named: centre.centreLogoF)!)
//            Image(uiImage: UIImage(data: centre.centreLogo!) ?? UIImage())
                .resizable()
                .frame(width: 30, height: 30)
                .cornerRadius(10)
                .padding(4)
                .background(.ultraThinMaterial)
                .cornerRadius(18)
                .modifier(OutlineOverlay(cornerRadius: 18))
            GradientText(text: "\(centre.centreName)")
                .font(Font.largeTitle.bold())
                .frame(maxWidth: .infinity, alignment: .leading)
            Text(centre.centreDesc)
                .font(.footnote.weight(.semibold))
                .foregroundStyle(.secondary)
            Text(centre.centreText)
                .font(.footnote)
                .foregroundStyle(.secondary)
                .lineLimit(sizeCategory > .large ? 1 : 2)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 40)
        .frame(maxWidth: .infinity)
        .frame(height: 350)
        .background(.ultraThinMaterial)
        .backgroundColor(opacity: 0.5)
    }
}

struct FeaturedItem_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            FeaturedItem(centre: Centre())
            FeaturedItem(centre: Centre())
                .environment(\.sizeCategory, .accessibilityLarge)
        }
    }
}
