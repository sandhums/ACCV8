//
//  ErrorView.swift
//  ACCV8
//
//  Created by Manjinder Sandhu on 29/06/22.
//

import SwiftUI

struct ErrorView: View {
    @State var error: Error
        
    var body: some View {
        Text("Error: \(error.localizedDescription)")
    }
}
