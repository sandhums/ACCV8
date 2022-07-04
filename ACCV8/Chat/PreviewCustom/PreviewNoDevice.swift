//
//  PreviewNoDevice.swift
//  ACCv5
//
//  Created by Manjinder Sandhu on 21/05/22.
//

import SwiftUI

struct PreviewNoDevice<Value: View>: View {
    private let viewToPreview: Value

    init(_ viewToPreview: Value) {
        self.viewToPreview = viewToPreview
    }

    var body: some View {
        Group {
            viewToPreview
                .previewLayout(.sizeThatFits)
//                .padding()
        }
    }
}
