//
//  ImagePlaceholderView.swift
//  VizManager
//
//  Created by Öznur Köse on 24.05.2023.
//

import SwiftUI

struct ImagePlaceholderView: View {
    var body: some View {
        ZStack {
            ZStack(alignment: .bottomTrailing) {
                Circle()
                    .strokeBorder(.blue, lineWidth:1)
                    .frame(width: 200, height: 200)
                
                Image(systemName: "plus.circle")
                    .background(Color(UIColor.systemBackground))
                    .frame(width: 58, height: 58)
                    .foregroundColor(.blue)
                    .font(.title)
            }
            Image(systemName: "photo.on.rectangle")
                .resizable()
                .scaledToFit()
                .padding(70)
                .frame(width: 250, height: 250)
                .foregroundColor(.blue)
                .clipShape(Circle())
        }
    }
}

struct ImagePlaceholderView_Previews: PreviewProvider {
    static var previews: some View {
        ImagePlaceholderView()
    }
}
