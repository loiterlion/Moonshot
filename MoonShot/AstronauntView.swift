//
//  AstronauntView.swift
//  MoonShot
//
//  Created by Bruce Wang on 2023/12/18.
//

import SwiftUI

struct AstronautView: View {
    let astronaut: Astronaut
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    Image(astronaut.id)
                        .resizable()
                        .scaledToFit()
                    
                    Text(astronaut.description)
                        .padding()
                }
                
            }
            .background(.darkBackground)
            .navigationTitle(astronaut.name)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}


//#Preview {
//    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
//    return AstronautView(astronaut: astronauts["white"]!).preferredColorScheme(.dark)
//
//}

struct AstronautView_Previews: PreviewProvider {
    static var previews: some View {
        let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
        return AstronautView(astronaut: astronauts["white"]!).preferredColorScheme(.dark)
    }
}
