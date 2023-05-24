//
//  AnnotationView.swift
//  PhotoList
//
//  Created by Öznur Köse on 19.04.2023.
//
import MapKit
import SwiftUI

struct AnnotationView: View {
    
    @State var showTitle = true
    var image: ImageData
    var title: String {
        image.name
    }
    
    var body: some View {
            VStack(spacing: 0) {
                Text(title.trimmingCharacters(in: .whitespacesAndNewlines) == "" ? "Name Unknown" : title)
                    .font(.body)
                    .padding(10)
                    .background(.white)
                    .foregroundColor(.DarkBlue)
                    .cornerRadius(10)
                    .opacity(showTitle ? 0 : 1)
                
                
                Image(systemName: "mappin.circle.fill")
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(Color.white, Color.Burgundy)
                    .font(.largeTitle)
                
                Image(systemName: "arrowtriangle.down.fill")
                    .font(.caption)
                    .foregroundColor(Color.Burgundy)
                    .offset(x: 0, y: -5)
            }
            .onTapGesture {
                withAnimation(.spring()) {
                    showTitle.toggle()
                }
            }
    }
}

struct AnnotationView_Previews: PreviewProvider {
    static var previews: some View {
        AnnotationView(image: ImageModelView.ImagesSample.images[0])
    }
}
