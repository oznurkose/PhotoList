//
//  HeartView.swift
//  PhotoList
//
//  Created by Öznur Köse on 19.04.2023.
//

import SwiftUI

struct HeartView: View {
    var body: some View {
        ZStack{
                    Rectangle()
                        .frame(width: 200, height: 200, alignment: .center)
                        .foregroundColor(.red)
                        .cornerRadius(5)
                    
                    Circle()
                        .frame(width: 200, height: 200, alignment: .center)
                        .foregroundColor(.red)
                        .padding(.top, -200)
                    
                    Circle()
                        .frame(width: 200, height: 200, alignment: .center)
                        .foregroundColor(.red)
                        .padding(.trailing, -200)
                }.rotationEffect(Angle(degrees: -45))
    }
}

struct HeartView_Previews: PreviewProvider {
    static var previews: some View {
        HeartView()
    }
}
