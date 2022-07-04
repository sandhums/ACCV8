//
//  CustomProgressView.swift
//  ACCV8
//
//  Created by Manjinder Sandhu on 01/07/22.
//

import SwiftUI

struct CustomProgressView: View {
    var message: String?

    private enum Dimensions {
        static let padding: CGFloat = 100
        static let bgColor = Color("Clear")
        static let cornerRadius: CGFloat = 16
    }

    init() {
        message = nil
    }

    init(_ message: String?) {
        self.message = message
    }

    var body: some View {
        VStack {
            if let message = message {
                ProgressView(message)
            } else {
                ProgressView()
            }
        }
        .padding(Dimensions.padding)
        .background(.ultraThinMaterial,
                    in: RoundedRectangle(cornerRadius: Dimensions.cornerRadius))
    }
}

struct CustomProgressView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            AppearancePreviews(
                Group {
                    ZStack {
                        VStack {
                            Text("Background Text")
                                .padding(150)
                                .background(Color.blue)
                        }
                        CustomProgressView()
                    }
                    ZStack {
                        VStack {
                            Text("Background Text")
                                .padding(150)
                                .background(Color.blue)
                        }
                        CustomProgressView("Some Text")
                    }
                }
            )
        }
        .previewLayout(.sizeThatFits)
        .padding()
    }
}
