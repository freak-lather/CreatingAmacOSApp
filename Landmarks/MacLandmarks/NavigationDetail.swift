//
//  NavigationDetail.swift
//  MacLandmarks
//
//  Created by ajay lather on 27/04/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import SwiftUI
import MapKit

struct NavigationDetail: View {
    @EnvironmentObject var userData: UserData
    var landmark: Landmark
    
    var landmarkIndex: Int {
        userData.landmarks.firstIndex(where: { $0.id == landmark.id })!
    }
    
    var body: some View {
        ScrollView {
            MapView(coordinate: landmark.locationCoordinate)
            .frame(height: 250)
            .overlay(
                    GeometryReader { proxy in
                        Button("Open in Maps") {
                            let destination = MKMapItem(placemark: MKPlacemark(coordinate: self.landmark.locationCoordinate))
                            destination.name = self.landmark.name
                            destination.openInMaps()
                        }
                        .frame(width: proxy.size.width, height: proxy.size.height, alignment: .bottomTrailing)
                        .offset(x: -10, y: -10)
                    }
            )
            
            Button("Open in Maps") {
                let destination = MKMapItem(placemark: MKPlacemark(coordinate: self.landmark.locationCoordinate))
                destination.name = self.landmark.name
                destination.openInMaps()
            }
            
            VStack(alignment: .leading, spacing: 12) {
                HStack(alignment: .center, spacing: 24) {
                    CircleImage(image: landmark.image.resizable(), shadowRadius: 4)
                        .frame(width: 160, height: 160)

                    VStack(alignment: .leading) {
                        Text(landmark.name).font(.title)
                        Text(landmark.park)
                        Text(landmark.state)
                    }
                    .font(.caption)
                }
                
                Divider()

                Text("About \(landmark.name)")
                    .font(.headline)

                Text(landmark.description)
                    .lineLimit(nil)
            }
            .padding()
            .frame(maxWidth: 700)
            .offset(x: 0, y: -50)
        }
    }
}

struct NavigationDetail_Previews: PreviewProvider {
    static var previews: some View {
        NavigationDetail(landmark: landmarkData[0])
            .environmentObject(UserData())
    }
}
