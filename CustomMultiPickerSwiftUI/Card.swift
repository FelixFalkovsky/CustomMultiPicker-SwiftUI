//
//  Card.swift
//  CustomMultiPickerSwiftUI
//
//  Created by Felix Falkovsky on 10.05.2020.
//  Copyright © 2020 Felix Falkovsky. All rights reserved.
//

import SwiftUI
import Photos

struct Card: View {
    
    @State var data: Images
    @Binding var imagePost : [UIImage]
    
    var body: some View {
        
        ZStack {
            
            Image(uiImage: self.data.image)
            .resizable()
            .scaledToFill()
            
            if self.data.imagePost {
                ZStack {
                    Color.black.opacity(0.5)
                    Image(systemName: "checkmark")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundColor(.white)
                }
            }
            
        }
        .frame(width: (UIScreen.main.bounds.width - 150) / 2, height: 140)
        .clipped()
        .onTapGesture {
            if !self.data.imagePost {
                self.data.imagePost = true
                self.imagePost.append(self.data.image)
            }
            else{
                for item in 0..<self.imagePost.count {
                    if self.imagePost[item] == self.data.image {
                        self.imagePost.remove(at: item)
                        self.data.imagePost = false
                        return
                    }
                }
            }
            
        }
        
    }
}
