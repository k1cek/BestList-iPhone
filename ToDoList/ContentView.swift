//
//  ContentView.swift
//  ToDoList
//
//  Created by Lukasz Zajac on 14/12/2020.
//

import SwiftUI

struct ChecklistItem: Identifiable { // Identifiable - protokół str 336
    let id = UUID() // Universally Unique Identifier - str 336. UUID() tworzy nową instancję UUID
    var name: String
    var isChecked: Bool = false
}

struct ContentView: View {
    
    // Properties
    // ==========
    
    @State var checklistItems = [
        ChecklistItem(name: "Walk the dog", isChecked: false),
        ChecklistItem(name: "Walk the dog", isChecked: true),
        ChecklistItem(name: "Brush my teeth", isChecked: true),
        ChecklistItem(name: "Learn iOS development", isChecked: true),
        ChecklistItem(name: "Finish homework", isChecked: false),
        ChecklistItem(name: "Change internet provider", isChecked: false),
        ChecklistItem(name: "Read Raywenderlich.com", isChecked: true),
    ]
    
    // User interface content and layout
    // ==== ========= ======= === ======
    var body: some View {
        NavigationView {
            List {
                // ForEach(checklistItems, id: \.self.name) - stary zapis bez UUID. poprawnie jest bez "id" poniewaz kazdy ChecklistItem teraz jest zdolne sam tworzyc unikalny id dla siebie
                
                ForEach(checklistItems) { checklistItems in
                    HStack {
                        Text(checklistItems.name)
                        Spacer()
                        checklistItems.isChecked ? Text("✅") : Text("🔲") // ternary conditional operator - operator trójargumentowy
                    }
                }
                .onDelete(perform: deleteListItem) // umozliwia usuniecie elementu poprzez przsuniecie palcem
                .onMove(perform: moveListItem) // umozliwia przesuwanie listy w gore lub w dol po kliknieciu w edit
            }
            .navigationBarItems(trailing: EditButton()) // przycisk edycji listy
            .navigationBarTitle("Moja lista")
            .onAppear() {
                self.printChecklistContents()
            }
        }
    }
    
    // Methods
    // =======
    
    func printChecklistContents() {
        for item in checklistItems {
            print(item)
        }
    }
    
    func deleteListItem(whichElement: IndexSet) {
        checklistItems.remove(atOffsets: whichElement)
        printChecklistContents()
    }
    
    func moveListItem(whichElement: IndexSet, destination: Int) {
        checklistItems.move(fromOffsets: whichElement, toOffset: destination)
        printChecklistContents()
    }
}

    // Preview
    // =======

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

