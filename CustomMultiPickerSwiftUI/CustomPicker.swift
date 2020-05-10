//
//  ImagePicker.swift
//  CustomMultiPickerSwiftUI
//
//  Created by Felix Falkovsky on 10.05.2020.
//  Copyright © 2020 Felix Falkovsky. All rights reserved.
//

import SwiftUI
import Photos

struct CustomPicker: View {
    
    @Binding var imagePost: [UIImage]
    @State var data : [Images] = []
    @State var grid : [Int] = []
    @Binding var show : Bool
    @State var disabled = false
    
    var body: some View {
        
        GeometryReader { geometry in
            VStack {
                if !self.grid.isEmpty {
                    HStack {
                        Text("")
                            .padding(5)
                            .font(.system(size: 15, weight: .semibold, design: .serif))
                            .foregroundColor(Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)))
                        Spacer()
                    }
                    .padding(.leading)
                    .padding(.top)
                    ScrollView(.vertical, showsIndicators: true) {
                        VStack(spacing: 3) {
                            ForEach(self.grid, id: \.self) { items in
                                HStack(spacing: 3) {
                                    ForEach(items..<items+3, id: \.self) { object in
                                        HStack {
                                            if object < self.data.count {
                                                Card(data: self.data[object],imagePost: self.$imagePost)
                                            }
                                        }
                                    }
                                    if self.data.count % 3 != 0 && items == self.grid.last! {
                                       Spacer()
                                    }
                                }
                               .padding(.leading, (self.data.count % 3 != 0 && items == self.grid.last!) ? 5 : 0)
                            }
                        }
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                    }
                    Button(action: {
                        self.show = false
                    }, label: {
                        Text("ADD")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(.gray)
                            .frame(width: 120, height: 44)
                    })
                        .buttonStyle(ButtonModifier())
                        .disabled((self.imagePost.count != 0) ? false : true)
                        .padding([.top, .bottom], 15)
                    
                } else {
                    if self.disabled {
                        Text("Enable Storage Access In Settings !!!")
                    }
                    else {
                        Indicator()
                    }
                }
                
            }
            .background(Color.white)
            .cornerRadius(12)
        }
        .background(Color.white.edgesIgnoringSafeArea(.all)
        .onTapGesture {
            self.show.toggle()
        })
            .onAppear {
                PHPhotoLibrary.requestAuthorization { (status) in
                    if status == .authorized {
                        self.getAllImages()
                        self.disabled = false
                    } else {
                        self.disabled = true
                    }
                }
        }
    }
    func getAllImages(){
        
        let req = PHAsset.fetchAssets(with: .image, options: .none)
        
        DispatchQueue.global(qos: .utility).async {
            req.enumerateObjects { (asset, _, _) in
                let options = PHImageRequestOptions()
                options.isSynchronous = true
                options.resizeMode = .fast
                options.deliveryMode = .highQualityFormat
                options.isNetworkAccessAllowed = false
                //options.version = .original
                
                PHCachingImageManager.default().requestImage(for: asset, targetSize: CGSize(width: 500, height: 500), contentMode: .aspectFill, options: options) { (image, _) in
                    let dataItem = Images(image: image ?? UIImage(), imagePost: false)
                    self.data.append(dataItem)
                }
            }
            if req.count == self.data.count{
                self.getGrid()
            }
        }
    }
    func getGrid(){
        for i in stride(from: 0, to: self.data.count, by: 3){
            self.grid.append(i)
        }
    }
}


struct Images {
    var image : UIImage
    var imagePost : Bool
}


struct Indicator : UIViewRepresentable {
    
    func makeUIView(context: Context) -> UIActivityIndicatorView  {
        let view = UIActivityIndicatorView(style: .medium)
        view.startAnimating()
        return view
    }

    func updateUIView(_ uiView:  UIActivityIndicatorView, context: Context) {
    }
}
