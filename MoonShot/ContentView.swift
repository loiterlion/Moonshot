//
//  ContentView.swift
//  MoonShot
//
//  Created by Bruce Wang on 2023/12/18.
//

import SwiftUI

struct GridLayout: View {
    let astronauts: [String: Astronaut]
    let missions: [Mission]
    
    let columns = [GridItem(.adaptive(minimum: 150))]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(missions) { mission in
                    NavigationLink(value:mission) {
                        VStack {
                            Image(mission.image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                                .padding()
                            VStack {
                                Text(mission.displayName)
                                    .font(.headline)
                                    .foregroundStyle(.white)
                                Text(mission.formattedLaunchDate)
                                    .font(.caption)
                                    .foregroundColor(.white.opacity(0.7))
                            }
                            .padding(.vertical)
                            .frame(maxWidth: .infinity)
                            .background(.lightBackground)
                        }
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.lightBackground)
                        )
                        .padding()
                    }
                }
            }
            .padding([.horizontal, .bottom])
        }
    }
}

struct ListLayout: View {
    let astronauts: [String: Astronaut]
    let missions: [Mission]
    
    var body: some View {
        
        List(missions) { mission in
            NavigationLink(value: mission) {
                HStack {
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                    
                    VStack {
                        Text(mission.displayName)
                            .font(.headline)
                            .foregroundStyle(.white)
                        Text(mission.formattedLaunchDate)
                            .font(.caption)
                            .foregroundColor(.white.opacity(0.7))
                    }
                }
            }
        }
        .background(.lightBackground)
    }
}

struct ContentView: View {
    let columns = [GridItem(.adaptive(minimum: 150))]
    @State private var showingGrid = false
    
    var body: some View {
        let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
        
        let missions: [Mission] = Bundle.main.decode("missions.json")
        
        NavigationStack {
            Group {
                if showingGrid {
                    GridLayout(astronauts: astronauts, missions: missions)
                } else {
                    ListLayout(astronauts: astronauts, missions: missions)
                }
            }
            .navigationDestination(for: Mission.self) { mission in
                MissionView(mission: mission, astronauts: astronauts)
            }
            .navigationTitle("Moonshot")
            .background(.darkBackground)
            .preferredColorScheme(.dark)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        toggleShowingStyle()
                    } label: {
                        Text("Toggle Style")
                    }

                }
            }
        }
    }
    
    func toggleShowingStyle() {
        showingGrid.toggle()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
