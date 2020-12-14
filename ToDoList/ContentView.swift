//
//  ContentView.swift
//  ToDoList
//
//  Created by Lukasz Zajac on 14/12/2020.
//

import SwiftUI

struct ContentView: View {
    @State var checklistItems = ["Walk the dog", "Brush my teeth", "Learn iOS development", "Finish homework", "Change internet provider", "Read Raywenderlich.com"]
    var body: some View {
        NavigationView {
            List {
                ForEach(checklistItems, id: \.self) {
                    item in Text(item)
                }
                .onDelete(perform: deleteListItem)
            }
            .navigationBarTitle("Moja lista")
            .onAppear() {
                self.printChecklistContents()
            }
        }
    }
    func printChecklistContents() {
        for item in checklistItems {
            print(item)
        }
    }
    
    func deleteListItem(whichElement: IndexSet) {
        checklistItems.remove(atOffsets: whichElement)
        printChecklistContents()
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

