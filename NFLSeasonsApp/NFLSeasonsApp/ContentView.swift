//
//  ContentView.swift
//  NFLSeasonsApp
//
//  Created by Yount, Zach on 4/16/25.
//
import SwiftUI
import MapKit

// MARK: - Model

struct Team: Identifiable {
    let id = UUID()
    let name: String
    let city: String
    let coordinate: CLLocationCoordinate2D
    let founded: Int
    let superBowlAppearances: Int
    let history: String
    let logo: String
}

// MARK: - ContentView

struct ContentView: View {
    let teams: [Team] = [
        Team(name: "Arizona Cardinals", city: "Glendale, AZ", coordinate: CLLocationCoordinate2D(latitude: 33.5276, longitude: -112.2626), founded: 1898, superBowlAppearances: 1, history: "The oldest professional football team in the U.S.", logo: "cardinals_logo"),
        Team(name: "Atlanta Falcons", city: "Atlanta, GA", coordinate: CLLocationCoordinate2D(latitude: 33.7550, longitude: -84.4009), founded: 1966, superBowlAppearances: 2, history: "Known for a passionate fanbase and dramatic games.", logo: "falcons_logo"),
        Team(name: "Baltimore Ravens", city: "Baltimore, MD", coordinate: CLLocationCoordinate2D(latitude: 39.2780, longitude: -76.6227), founded: 1996, superBowlAppearances: 2, history: "Won both Super Bowls they've appeared in.", logo: "ravens_logo"),
        Team(name: "Buffalo Bills", city: "Orchard Park, NY", coordinate: CLLocationCoordinate2D(latitude: 42.7738, longitude: -78.7869), founded: 1960, superBowlAppearances: 4, history: "Famous for losing four consecutive Super Bowl appearances.", logo: "bills_logo"),
        Team(name: "Carolina Panthers", city: "Charlotte, NC", coordinate: CLLocationCoordinate2D(latitude: 35.2251, longitude: -80.8529), founded: 1993, superBowlAppearances: 2, history: "Fast rise in the 2000s and 2010s.", logo: "panthers_logo"),
        Team(name: "Chicago Bears", city: "Chicago, IL", coordinate: CLLocationCoordinate2D(latitude: 41.8623, longitude: -87.6167), founded: 1919, superBowlAppearances: 2, history: "One of the most historic franchises in the NFL.", logo: "bears_logo"),
        Team(name: "Cincinnati Bengals", city: "Cincinnati, OH", coordinate: CLLocationCoordinate2D(latitude: 39.0955, longitude: -84.5161), founded: 1968, superBowlAppearances: 3, history: "Strong recent performances led by Joe Burrow.", logo: "bengals_logo"),
        Team(name: "Cleveland Browns", city: "Cleveland, OH", coordinate: CLLocationCoordinate2D(latitude: 41.5061, longitude: -81.6995), founded: 1946, superBowlAppearances: 0, history: "A loyal fanbase despite many challenges.", logo: "browns_logo"),
        Team(name: "Dallas Cowboys", city: "Arlington, TX", coordinate: CLLocationCoordinate2D(latitude: 32.7473, longitude: -97.0927), founded: 1960, superBowlAppearances: 8, history: "Known as 'America's Team'.", logo: "cowboys_logo"),
        Team(name: "Denver Broncos", city: "Denver, CO", coordinate: CLLocationCoordinate2D(latitude: 39.7439, longitude: -105.0201), founded: 1960, superBowlAppearances: 8, history: "Home of legends like John Elway and Peyton Manning.", logo: "broncos_logo"),
        Team(name: "Detroit Lions", city: "Detroit, MI", coordinate: CLLocationCoordinate2D(latitude: 42.3400, longitude: -83.0456), founded: 1930, superBowlAppearances: 0, history: "Historic team recently rising in performance.", logo: "lions_logo"),
        Team(name: "Green Bay Packers", city: "Green Bay, WI", coordinate: CLLocationCoordinate2D(latitude: 44.5013, longitude: -88.0622), founded: 1919, superBowlAppearances: 5, history: "Owned by fans, home of Lambeau Field.", logo: "packers_logo"),
        Team(name: "Houston Texans", city: "Houston, TX", coordinate: CLLocationCoordinate2D(latitude: 29.6847, longitude: -95.4107), founded: 2002, superBowlAppearances: 0, history: "NFL's youngest team.", logo: "texans_logo"),
        Team(name: "Indianapolis Colts", city: "Indianapolis, IN", coordinate: CLLocationCoordinate2D(latitude: 39.7601, longitude: -86.1639), founded: 1953, superBowlAppearances: 4, history: "Won with Peyton Manning in 2006.", logo: "colts_logo"),
        Team(name: "Jacksonville Jaguars", city: "Jacksonville, FL", coordinate: CLLocationCoordinate2D(latitude: 30.3230, longitude: -81.6373), founded: 1995, superBowlAppearances: 0, history: "Young team with recent playoff success.", logo: "jaguars_logo"),
        Team(name: "Kansas City Chiefs", city: "Kansas City, MO", coordinate: CLLocationCoordinate2D(latitude: 39.0489, longitude: -94.4849), founded: 1960, superBowlAppearances: 5, history: "Recent Super Bowl champs with Patrick Mahomes.", logo: "chiefs_logo"),
        // ... add remaining 16 teams here ...
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(spacing: 12) {
                    ForEach(teams) { team in
                        NavigationLink(destination: TeamLocationView(team: team)) {
                            HStack(spacing: 16) {
                                Image(team.logo)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 50, height: 50)
                                    .clipShape(Circle())
                                    .overlay(Circle().stroke(Color.gray, lineWidth: 1))
                                
                                VStack(alignment: .leading) {
                                    Text(team.name)
                                        .font(.headline)
                                    Text(team.city)
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                }
                                Spacer()
                            }
                            .padding()
                            .background(Color(UIColor.secondarySystemBackground))
                            .cornerRadius(10)
                            .shadow(radius: 1)
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("NFL Teams")
        }
    }
}

// MARK: - Detail View

struct TeamLocationView: View {
    let team: Team
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                Image(team.logo)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120, height: 120)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .padding(.top)
                
                Text(team.name)
                    .font(.largeTitle)
                    .bold()
                
                Text("City: \(team.city)")
                Text("Founded: \(team.founded)")
                Text("Super Bowl Appearances: \(team.superBowlAppearances)")
                    .font(.subheadline)
                
                Text(team.history)
                    .padding()
                
                MapView(coordinate: team.coordinate)
                    .frame(height: 300)
                    .cornerRadius(12)
            }
            .padding()
        }
        .navigationTitle(team.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - Map View

struct MapView: View {
    var coordinate: CLLocationCoordinate2D
    
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 39.5, longitude: -98.35),
        span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)
    )
    
    var body: some View {
        Map(coordinateRegion: $region, annotationItems: [MapPin(coordinate: coordinate)]) { pin in
            MapMarker(coordinate: pin.coordinate, tint: .blue)
        }
        .onAppear {
            region.center = coordinate
        }
    }
}

struct MapPin: Identifiable {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
}

// MARK: - App Entry Point

@main
struct NFLTeamsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
