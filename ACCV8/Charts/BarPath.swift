//
//  BarPath.swift
//  ACCV8
//
//  Created by Manjinder Sandhu on 15/08/22.
//

import SwiftUI

struct BarPath: Shape {
  let data: Double
  let max: Double
  let min: Double
  
  func path(in rect: CGRect) -> Path {
    guard min != max else {
      return Path()
    }
    
    let height = CGFloat((data - min) / (max - min)) * rect.height
    let bar = CGRect(x: rect.minX, y: rect.maxY - (rect.minY + height), width: rect.width, height: height)
    
    return RoundedRectangle(cornerRadius: 5).path(in: bar)
  }
}
