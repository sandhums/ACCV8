//
//  PreviewDevices.swift
//  ACCv5
//
//  Created by Manjinder Sandhu on 21/05/22.
//

import SwiftUI

struct PreviewDevices<Value: View>: View {
    let devices = [
        "iPhone 13 Pro Max",
        "iPhone 13 mini",
        "iPad (9th generation)"
    ]
    
    private let viewToPreview: Value

    init(_ viewToPreview: Value) {
        self.viewToPreview = viewToPreview
    }

    var body: some View {
        Group {
            ForEach(devices, id: \.self) { device in
                viewToPreview
                    .previewDevice(PreviewDevice(rawValue: device))
                    .previewDisplayName(device)
            }
        }
    }
}
