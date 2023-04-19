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
    var title: String
    
    var body: some View {
        NavigationLink(destination: DetailedView(image: image)) {
            VStack(spacing: 0) {
                Text(title.trimmingCharacters(in: .whitespacesAndNewlines) == "" ? "Name Unknown" : title)
                    .font(.callout)
                    .padding(5)
                    .background(Color(.white))
                    .cornerRadius(10)
                    .opacity(showTitle ? 0 : 1)
                
                
                Image(systemName: "mappin.circle.fill")
                    .font(.title)
                    .foregroundColor(.red)
                    .background(.white, in: Circle())
                
                Image(systemName: "arrowtriangle.down.fill")
                    .font(.caption)
                    .foregroundColor(.red)
                    .offset(x: 0, y: -5)
            }
            .onTapGesture {
                withAnimation(.easeInOut) {
                    showTitle.toggle()
                }
            }
        }
        
    }
}

//struct AnnotationView_Previews: PreviewProvider {
//    static var previews: some View {
//        AnnotationView()
//    }
//}
