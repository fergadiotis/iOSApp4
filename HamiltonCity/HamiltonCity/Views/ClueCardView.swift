//
//  ClueCardView.swift
//  HamiltonCity
//
//  Created by Tassos Fergadiotis on 2025-02-09.
//

import SwiftUI

struct ClueCardView: View {
    let clue: Clue
    @ObservedObject var viewModel: HamiltonCityViewModel
    @State private var showingImagePicker = false
    @Binding var hasSubmittedPhoto: Bool
    
    var body: some View {
        VStack {
            Text(clue.text)
                .font(.headline)
                .multilineTextAlignment(.center)
                .padding(.bottom, 5)
            
            Text("Location: \(clue.businessName)")
                .foregroundColor(.gray)
            
            if let businessHours = clue.businessHours {
                Text("Hours: \(businessHours)")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            
            if let imageData = clue.image,
               let uiImage = UIImage(data: imageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 150)
            } else {
                Button {
                    showingImagePicker = true
                } label: {
                    Text("Select City Image")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(radius: 5)
        .sheet(isPresented: $showingImagePicker) {
            ImageSelectionView { selectedImage in
                if let cityImage = UIImage(named: selectedImage),
                   let imageData = cityImage.jpegData(compressionQuality: 0.8) {
                    viewModel.markClueFound(clue, with: imageData)
                    hasSubmittedPhoto = true
                }
                showingImagePicker = false
            }
        }
    }
}
