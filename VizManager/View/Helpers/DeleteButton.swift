//
//  Delete.swift
//  VizManager
//
//  Created by Öznur Köse on 25.05.2023.
//

import SwiftUI

struct DeleteButton: View {
    var body: some View {
        Image(systemName: "xmark.circle.fill")
            .symbolRenderingMode(.palette)
            .foregroundStyle( Color.white, Color.Burgundy)
            .offset(x: 8, y: -8)
            .shadow(color: Color.primary.opacity(0.3), radius: 1)
    }
}

struct DeleteButton_Previews: PreviewProvider {
    static var previews: some View {
        DeleteButton()
    }
}
