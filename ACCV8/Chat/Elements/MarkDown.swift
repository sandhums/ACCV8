//
//  MarkDown.swift
//  ACCv5
//
//  Created by Manjinder Sandhu on 27/05/22.
//

import SwiftUI

struct MarkDown: View {
    let text: String
    
    @State private var formattedText: AttributedString?

    var body: some View {
        Group {
            if let formattedText = formattedText {
                Text(formattedText)
            } else {
                Text(text)
            }
        }
        .onAppear(perform: formatText)
    }
    
    private func formatText() {
        do {
            try formattedText = AttributedString(markdown: text)
        } catch {
            print("Couldn't convert this from markdown: \(text)")
        }
    }
}

struct MarkDown_Previews: PreviewProvider {
    static var previews: some View {
        MarkDown(text: "Sample of *italics*, **bold**, ~~strikethrough~~, [link](https://realm.io)")
    }
}
