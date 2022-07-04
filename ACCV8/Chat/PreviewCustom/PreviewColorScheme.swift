//
//  PreviewColorScheme.swift
//  ACCv5
//
//  Created by Manjinder Sandhu on 21/05/22.
//

import SwiftUI

struct PreviewColorScheme<Value: View>: View {
    private let viewToPreview: Value

    init(_ viewToPreview: Value) {
        self.viewToPreview = viewToPreview
    }

    var body: some View {
        Group {
            viewToPreview
            viewToPreview.preferredColorScheme(.dark)
        }
    }
}
