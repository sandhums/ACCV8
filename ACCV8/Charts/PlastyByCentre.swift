//
//  PlastyByCentre.swift
//  ACCV8
//
//  Created by Manjinder Sandhu on 15/08/22.
//

import Foundation
import SwiftUI

struct PlastyByCentre: View {
  @Binding var data: [Double]
  @Binding var labels: [String]
  let accentColor: Color
  let axisColor: Color
  let showGrid: Bool
  let gridColor: Color
  let spacing: CGFloat
  
  private var minimum: Double { (data.min() ?? 0) * 0.95 }
  private var maximum: Double { (data.max() ?? 1) * 1.05 }
  
  var body: some View {
    VStack {
      ZStack {
        if showGrid {
          BarChartGrid(divisions: 10)
            .stroke(gridColor.opacity(0.2), lineWidth: 0.5)
        }
        
        BarStack(data: $data,
                 labels: $labels,
                 accentColor: accentColor,
                 gridColor: gridColor,
                 showGrid: showGrid,
                 min: minimum,
                 max: maximum,
                 spacing: spacing)
        
        BarChartAxes()
          .stroke(Color.black, lineWidth: 2)
      }
      
      LabelStack(labels: $labels, spacing: spacing)
    }
    .padding([.horizontal, .top], 20)
  }
}
