//
//  PhotoRowView.swift
//  VizManager
//
//  Created by Öznur Köse on 24.05.2023.
//

import SwiftUI

struct PhotoRowView: View {
    var image: ImageData
    var body: some View {
        HStack {
            Image(uiImage: image.image[0])
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
                .clipShape(RoundedRectangle(cornerRadius: 15))
            
            Text("\(image.name)")
            Spacer()
            if image.isFavorite {
                Image(systemName: "heart.fill")
                    .foregroundColor(.red)
            }
        }
    }
}

struct PhotoRowView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoRowView(image: ImageModelView.ImagesSample.images[0])
    }
}
