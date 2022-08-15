//
//  LabelStack.swift
//  ACCV8
//
//  Created by Manjinder Sandhu on 15/08/22.
//

import SwiftUI

struct LabelStack: View {
  @Binding var labels: [String]
  let spacing: CGFloat
  
  var body: some View {
    HStack(alignment: .center, spacing: spacing) {
      ForEach(labels, id: \.self) { label in
        Text(label)
          .frame(maxWidth: .infinity)
      }
    }
    .padding(.horizontal, spacing)
  }
}
