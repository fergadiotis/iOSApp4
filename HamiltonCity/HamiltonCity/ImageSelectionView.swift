//
//  ImageSelectionView.swift
//  HamiltonCity
//
//  Created by Tassos Fergadiotis on 2025-02-09.
//

import SwiftUI

struct ImageSelectionView: View {
    // Use the three separate names that match your asset files
    let images = ["Hamilton Gardens", "City Center", "Waikato River", "Taitua Arboretum", "Cricket Ground", "Farmer Marke", "ArtPst Galleries", "River Walk", "Hamilton Zoo", "Lake Domain", ]
    let onSelect: (String) -> Void
    @Environment(\.dismiss) var dismiss
    @State private var selectedImage: String?
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(.systemBackground)
                    .edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 0) {
                    Text("Select City Location")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.vertical, 20)
                    
                    ScrollView {
                        VStack(spacing: 16) {
                            ForEach(images, id: \.self) { imageName in
                                LocationCard(
                                    imageName: imageName,
                                    isSelected: selectedImage == imageName,
                                    onTap: {
                                        selectedImage = imageName
                                        onSelect(imageName)
                                    }
                                )
                            }
                        }
                        .padding()
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }
}

struct LocationCard: View {
    let imageName: String
    let isSelected: Bool
    let onTap: () -> Void
    
    var locationInfo: (title: String, description: String) {
        switch imageName {
        case "Hamilton Gardens":
            return ("Hamilton Gardens", "World-Class Garden Park")
        case "City Center":
            return ("City Center", "Heart of Hamilton")
        case "Waikato River":
            return ("Waikato River", "Scenic Waterfront")
        case "Taitua Arboretum":
            return ("Taitua Arboretum", "Native Tree Collection")
        case "Cricket Ground":
            return ("Cricket Ground", "Seddon Park Stadium")
        case "Farmer Marke":
            return ("Farmers' Market", "Local Fresh Produce")
        case "ArtPst Galleries":
            return ("ArtPost Galleries", "Contemporary Art Space")
        case "River Walk":
            return ("River Walk", "Riverside Walking Trail")
        case "Hamilton Zoo":
            return ("Hamilton Zoo", "Wildlife Experience")
        case "Lake Domain":
            return ("Lake Domain", "Recreational Park")
        default:
            return (imageName, "Tourist Spot")
        }
    }
    
    var body: some View {
        Button(action: onTap) {
            HStack(spacing: 16) {
                // Using the cityimages asset for each card
                Image("cityimages")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 90, height: 80)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(locationInfo.title)
                        .font(.headline)
                    
                    Text(locationInfo.description)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    Text("Popular Tourist Spot")
                        .font(.caption)
                        .foregroundColor(.red)
                }
                
                Spacer()
                
                if isSelected {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.blue)
                }
            }
            .padding()
            .background(Color(.systemBackground))
            .cornerRadius(15)
            .shadow(radius: 5)
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(isSelected ? Color.blue : Color.gray.opacity(0.2), lineWidth: isSelected ? 2 : 1)
            )
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    ImageSelectionView { _ in }
}
