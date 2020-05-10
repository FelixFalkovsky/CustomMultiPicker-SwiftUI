//
//  ContentView.swift
//  CustomMultiPickerSwiftUI
//
//  Created by Felix Falkovsky on 10.05.2020.
//  Copyright © 2020 Felix Falkovsky. All rights reserved.
//

import SwiftUI
import Photos

struct ContentView: View {
    
    @State var imagePost: [UIImage] = []
    @State var show = false
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
            if !self.imagePost.isEmpty {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 5) {
                        ForEach(self.imagePost, id: \.self) { item in
                            GeometryReader { geometry in
                                Image(uiImage: item)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 280, height: 280)
                                    .shadow(radius: 0.3)
                                    .cornerRadius(25)
                                    .rotation3DEffect(Angle(degrees:
                                        (Double(geometry.frame(in: .global).minX) - 10) / -40), axis: (x: 0, y: 80.0, z: 0))
                            }
                            .frame(width: 280, height: 280)
                        }
                    }
                    .padding(.horizontal, 5)
                }
                .padding(.bottom, 10)
            }
            }
            Spacer()
            HStack {
                Button(action: {
                    self.imagePost.removeAll()
                    self.show.toggle()
                }) {
                    Image(systemName: "camera")
                        .foregroundColor(Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)))
                        .frame(width: 120, height: 44)
                }
                .buttonStyle(ButtonModifier())
                .sheet(isPresented: self.$show) {
                    CustomPicker(imagePost: self.$imagePost, show: self.$show)
                }
                .padding([.top, .bottom], 10)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice("iPhone XR")
    }
}
