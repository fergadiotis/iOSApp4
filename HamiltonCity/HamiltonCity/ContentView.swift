//
//  ContentView.swift
//  HamiltonCity
//
//  Created by Tassos Fergadiotis on 2025-02-09.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = HamiltonCityViewModel()
    @State private var hasStarted = false
    @State private var showVictoryMessage = false
    @State private var currentClueIndex = 0
    @State private var hasSubmittedPhoto = false
    
    // Define gold color directly
    private let goldColor = Color(red: 1.0, green: 0.84, blue: 0.0)
    
    var body: some View {
        NavigationView {
            ZStack {
                // Using the background asset
                Color("background")
                    //.resizable()
                    .scaledToFill()
                    //.edgesIgnoringSafeArea(.all)
                
                // Semi-transparent overlay for better readability
                Image("Lake Domain")
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    // Title
                    Text("🏆 Hamilton 🏆")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding()
                    
                    if hasStarted {
                        // Progress indicator
                        Text("Clues Found: \(viewModel.foundCount) / \(viewModel.clues.count)")
                            .foregroundColor(.white)
                            .padding(.bottom)
                        
                        // Current discount status
                        Text(viewModel.getDiscount())
                            .foregroundColor(.white)
                            .padding(.bottom)
                        
                        // Current clue card
                        if currentClueIndex < viewModel.clues.count {
                            ClueCardView(
                                clue: viewModel.clues[currentClueIndex],
                                viewModel: viewModel,
                                hasSubmittedPhoto: $hasSubmittedPhoto
                            )
                            .padding(.bottom)
                            .onAppear {
                                hasSubmittedPhoto = false
                            }
                        }
                        
                        // Navigation buttons
                        HStack(spacing: 20) {
                            Button("Next Clue") {
                                currentClueIndex += 1
                                hasSubmittedPhoto = false
                            }
                            .buttonStyle(.borderedProminent)
                            .disabled(!hasSubmittedPhoto || currentClueIndex >= viewModel.clues.count - 1)
                            
                            Button("Reset Hunt") {
                                resetGame()
                            }
                            .buttonStyle(.bordered)
                            .foregroundColor(.white)
                        }
                        .padding()
                    } else {
                        Spacer()
                        
                        Button("Start the Hunt 🎯") {
                            hasStarted = true
                            viewModel.loadClues()
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(goldColor)
                        .foregroundColor(.black)
                        .font(.title)
                        .padding(.vertical, 20)
                        .padding(.horizontal, 40)
                        
                        Spacer()
                    }
                }
                .padding()
                .alert("Congratulations! You've won the Ultimate Grand Prize! 🎁",
                       isPresented: $showVictoryMessage) {
                    Button("OK", role: .cancel) { }
                }
                .onChange(of: viewModel.checkUltimatePrize()) { oldValue, hasWon in
                    if hasWon {
                        showVictoryMessage = true
                    }
                }
                .onAppear {
                    if viewModel.clues.isEmpty {
                        viewModel.loadClues()
                    }
                }
            }
        }
    }
    
    private func resetGame() {
        hasStarted = false
        viewModel.resetClues()
        currentClueIndex = 0
        hasSubmittedPhoto = false
    }
}

#Preview {
    ContentView()
}
