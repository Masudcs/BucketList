//
//  ContentView.swift
//  BucketList
//
//  Created by Md. Masud Rana on 2/21/23.
//

import MapKit
import SwiftUI

struct ContentView: View {
@StateObject private var viewModel = ViewModel()
    
    var body: some View {
        if viewModel.isUnlocked {
            ZStack {
                Map(coordinateRegion: $viewModel.mapRegion, annotationItems: viewModel.locations) { location in
                    MapAnnotation(coordinate: location.coordinate) {
                        VStack {
                            Image(systemName: "star.circle")
                                .resizable()
                                .foregroundColor(.red)
                                .frame(width: 44, height: 44)
                                .background(.white)
                                .clipShape(Circle())
                            
                            Text(location.name)
                                .fixedSize()
                        }
                        .onTapGesture {
                            viewModel.selectedPlace = location
                        }
                    }
                }
                .ignoresSafeArea()

                Circle()
                    .fill(.blue.opacity(0.3))
                    .frame(width: 32, height: 32)

                VStack {
                    Spacer()

                    Button {
                        viewModel.addLocation()
                    } label: {
                        Image(systemName: "plus")
                            .padding()
                            .background(.black.opacity(0.5))
                            .foregroundColor(.white)
                            .font(.title)
                            .clipShape(Circle())
                            .padding(.trailing)
                    }
                    
                }
            }
            .sheet(item: $viewModel.selectedPlace) { place in
                EditView(location: place) { newLocation in
                    viewModel.update(location: newLocation)
                }
            }
        } else {
            VStack {
                Button("Unlocked") {
                    viewModel.authenticate()
                }
                .padding()
                .background(.blue)
                .foregroundColor(.white)
                .clipShape(Capsule())
            }
            .alert("Error in Biometric", isPresented: $viewModel.isError) {
                Button("Cancel", role: .cancel) {
                    
                }
                Button("Again Authenticate") {
                    viewModel.authenticate()
                }
            } message: {
                Text("Your Face ID is not match, please use correct Face ID")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
