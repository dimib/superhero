//
//  ContentView.swift
//  Superhero
//
//  Created by Dimitrios Brukakis on 05.03.20.
//  Copyright © 2020 Dimitri Brukakis. All rights reserved.
//

import SwiftUI

private let dateFormatter: DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .medium
    dateFormatter.timeStyle = .medium
    return dateFormatter
}()

let controller = HeroesController()

struct ContentView: View {
    @State private var dates = [Date]()

    var body: some View {
        NavigationView {
            MasterView(dates: $dates)
                .navigationBarTitle(Text("Master"))
//                .navigationBarItems(
//                    leading: EditButton(),
//                    trailing: Button(
//                        action: {
//                            withAnimation { self.dates.insert(Date(), at: 0) }
//                        }
//                    ) {
//                        Image(systemName: "plus")
//                    }
//                )
            Text("No selection")
        }.navigationViewStyle(DoubleColumnNavigationViewStyle())
    }
}

struct MasterView: View {
    @Binding var dates: [Date]

    @ObservedObject var container = controller
    
    var body: some View {
        List {
            ForEach(container.heroes, id: \.id) { hero in
                NavigationLink(
                    destination: DetailView(superhero: hero)
                ) {
                    Text("\(hero.name)")
                }
            }
        }
    }
}

struct DetailView: View {
    var superhero: SuperHero

    var body: some View {
        Group {
            Text("\(superhero.name)")
        }.navigationBarTitle(Text("Detail"))
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
