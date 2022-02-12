//
//  ContentView.swift
//  Instafilter
//
//  Created by Can Bi on 11.02.2022.
//

import CoreImage
import CoreImage.CIFilterBuiltins
import SwiftUI

struct ContentView: View {    
    @State private var image: Image?
    @State private var filterIntensity = 0.5 // 0-1
    @State private var filterRadius = 100.0 // 0-200
    @State private var filterScale = 5.0 //0-10
    @State private var isIntesityAvailable = false
    @State private var isRadiusAvailable = false
    @State private var isScaleAvailable = false
    
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    @State private var processedImage: UIImage?
    
    @State private var currentFilter: CIFilter = CIFilter.sepiaTone()
    let context = CIContext()
    
    @State private var showingFilterSheet = false
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    Rectangle()
                        .fill(.secondary)
                    
                    Text("Tap to select a picture")
                        .foregroundColor(.white)
                        .font(.headline)
                    
                    image?
                        .resizable()
                        .scaledToFit()
                }
                .onTapGesture {
                    showingImagePicker = true
                }
                
                HStack{
                    Text("Intensity")
                        .frame(minWidth: 100, maxWidth: 100, minHeight: 20, maxHeight: 20, alignment: .leading)
                    Slider(value: $filterIntensity)
                        .disabled(isIntesityAvailable == false)
                        .id(isIntesityAvailable)
                        .onChange(of: filterIntensity) { _ in applyProcessing() }
                }.padding(.top)
                
                HStack{
                    Text("Radius")
                        .frame(minWidth: 100, maxWidth: 100, minHeight: 20, maxHeight: 20, alignment: .leading)
                    Slider(value: $filterRadius, in: 0...200)
                        .disabled(isRadiusAvailable == false)
                        .id(isRadiusAvailable)
                        .onChange(of: filterRadius) { _ in applyProcessing() }
                    
                }
                HStack{
                    Text("Scale")
                        .frame(minWidth: 100, maxWidth: 100, minHeight: 20, maxHeight: 20, alignment: .leading)
                    Slider(value: $filterScale,in:  0...10 )
                        .disabled(isScaleAvailable == false)
                        .id(isScaleAvailable)
                        .onChange(of: filterScale) { _ in applyProcessing() }
                }.padding(.bottom)
                
                HStack {
                    Button("Change Filter") {
                        showingFilterSheet = true
                    }
                    
                    Spacer()
                    
                    Button("Save", action: save)
                        .disabled(image == nil)
                }
            }
            .padding([.horizontal, .bottom])
            .navigationTitle("Instafilter")
            .onChange(of: inputImage) { _ in loadImage() }
            .sheet(isPresented: $showingImagePicker) {
                ImagePicker(image: $inputImage)
            }
            .confirmationDialog("Select a filter", isPresented: $showingFilterSheet) {
                Group{
                    Button("Crystallize") { setFilter(CIFilter.crystallize()) }
                    Button("Edges") { setFilter(CIFilter.edges()) }
                    Button("Gaussian Blur") { setFilter(CIFilter.gaussianBlur()) }
                    Button("Pixellate") { setFilter(CIFilter.pixellate()) }
                    Button("Sepia Tone") { setFilter(CIFilter.sepiaTone()) }
                    Button("Unsharp Mask") { setFilter(CIFilter.unsharpMask()) }
                    Button("Vignette") { setFilter(CIFilter.vignette()) }
                    Button("Comic") { setFilter(CIFilter.comicEffect()) }
                    Button("Thermal") { setFilter(CIFilter.thermal()) }
                    Button("Zoom Blur") { setFilter(CIFilter.zoomBlur()) }
                }
                Button("Cancel", role: .cancel) { }
            }
        }
    }
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        
        
        let beginImage = CIImage(image: inputImage)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        
        applyProcessing()
    }
    
    func save() {
        guard let processedImage = processedImage else { return }
        
        let imageSaver = ImageSaver()
        
        imageSaver.successHandler = {
            print("Success!")
        }
        
        imageSaver.errorHandler = {
            print("Oops! \($0.localizedDescription)")
        }
        
        imageSaver.writeToPhotoAlbum(image: processedImage)
    }
    
    func applyProcessing() {
        let inputKeys = currentFilter.inputKeys
        
        if inputKeys.contains(kCIInputIntensityKey) {
            currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey)
            isIntesityAvailable = true
        }
        if inputKeys.contains(kCIInputRadiusKey) {
            currentFilter.setValue(filterRadius, forKey: kCIInputRadiusKey)
            isRadiusAvailable = true
        }
        if inputKeys.contains(kCIInputScaleKey) {
            currentFilter.setValue(filterScale, forKey: kCIInputScaleKey)
            isScaleAvailable = true
        }
        
        guard let outputImage = currentFilter.outputImage else { return }
        
        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
            let uiImage = UIImage(cgImage: cgimg)
            image = Image(uiImage: uiImage)
            processedImage = uiImage
        }
    }
    
    func setFilter(_ filter: CIFilter) {
        //defaults
        filterIntensity = 0.5
        filterRadius = 100.0
        filterScale = 5.0
        isScaleAvailable = false
        isRadiusAvailable = false
        isScaleAvailable = false
        
        currentFilter = filter
        loadImage()
    }
}
