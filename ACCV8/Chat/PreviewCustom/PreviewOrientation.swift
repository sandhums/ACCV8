//
//  PreviewOrientation.swift
//  ACCv5
//
//  Created by Manjinder Sandhu on 21/05/22.
//

import SwiftUI

struct PreviewOrientation<Value: View>: View {
    private let viewToPreview: Value

    init(_ viewToPreview: Value) {
        self.viewToPreview = viewToPreview
    }

    var body: some View {
        Group {
            viewToPreview
            viewToPreview.previewInterfaceOrientation(.landscapeRight)
        }
    }
}
