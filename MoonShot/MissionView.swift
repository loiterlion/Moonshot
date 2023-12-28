//
//  MissionView.swift
//  MoonShot
//
//  Created by Bruce Wang on 2023/12/18.
//

import SwiftUI

struct DeviderView: View {
    var body: some View {
        Rectangle()
            .frame(height: 2)
            .foregroundStyle(.lightBackground)
            .padding(.vertical)
    }
}

struct MissionView: View {
    
    let mission: Mission
    let crew: [CrewMember]
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack {
                    
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width * 0.8, height: 100)
                    Text(mission.formattedLaunchDate)
                    
                    DeviderView()
                    
                    VStack(alignment:.leading) {
                        Text("Mission Highlights")
                            .font(.title.bold())
                            .padding(.bottom, 5)
                            
                        Text(mission.description)
                        
                        DeviderView()
                        
                        Text("Crew")
                            .font(.title.bold())
                            .padding(.bottom, 5)
                    }
                    .padding(.horizontal)
                    
                    CrewScrollView(crew: crew)
                    
                    DeviderView()
                }
                .padding(.bottom)
            }
        }
        .navigationTitle(mission.displayName)
        .navigationBarTitleDisplayMode(.inline)
        .background(.darkBackground)
        .preferredColorScheme(.dark)
        
    }
    
    init(mission: Mission, astronauts:[String: Astronaut]) {
        self.mission = mission
        self.crew = self.mission.crew.map({ crewRole in
            guard let astro = astronauts[crewRole.name] else {
                fatalError("Failed to fetch astro with crew name \(crewRole.name)")
            }
            return CrewMember(role:crewRole.role, astronaut: astro)
        })
    }
}


struct MissionView_Previews: PreviewProvider {
    static var previews: some View {
        let missions: [Mission] = Bundle.main.decode("missions.json")
        let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")

        return MissionView(mission: missions[1], astronauts: astronauts)
            .preferredColorScheme(.dark)
    }
}
