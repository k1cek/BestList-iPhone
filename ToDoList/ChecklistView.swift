//
//  ContentView.swift
//  ToDoList
//
//  Created by Lukasz Zajac on 14/12/2020.
//

import SwiftUI



struct ChecklistView: View {
    
    // Properties
    // ==========
    // tablica przeniesiona do checklist
    
    @ObservedObject var checklist = Checklist() // połączenie z Checklist() - nowa własciwosc, instancja. The = sign means “put whatever is on the right side of me into checklist,” and Checklist() means “create a new instance of Checklist.” This is ChecklistView’s connection to Checklist — the view’s connection to the ViewModel. As an @ObservedObject, checklist will always keep the view up-to-date with any changes to its @Published properties.
    
    // User interface content and layout
    // ==== ========= ======= === ======
    var body: some View {
        NavigationView {
            List {
                // ForEach(checklist.checklistItems, id: \.self.name) - stary zapis bez UUID. poprawnie jest bez "id" poniewaz kazdy ChecklistItem teraz jest zdolne sam tworzyc unikalny id dla siebie
                
                ForEach(checklist.items) { checklistItem in
                    HStack {
                        Text(checklistItem.name)
                        Spacer()
                        Text(checklistItem.isChecked ? "✅" : "🔲") // ternary conditional operator - operator trójargumentowy
                    }
                    .background(Color.white) // This makes the entire row clickable
                    .onTapGesture { // reakcja na klik
                        if let matchingIndex =
                            self.checklist.items.firstIndex(where: { $0.id == checklistItem.id }) {
                                // You provide firstIndex(where:) with the code in the braces — in case you’ve forgotten, it’s called a closure — and it goes through the array, applying that code to each element. The $0 is shorthand for “the first parameter passed to the closure,” which is the current array element.
                            
                            self.checklist.items[matchingIndex].isChecked.toggle()
                        }
                        self.checklist.printChecklistContents()
                    }
                }
                .onDelete(perform: checklist.deleteListItem) // umozliwia usuniecie elementu poprzez przsuniecie palcem
                .onMove(perform: checklist.moveListItem) // umozliwia przesuwanie listy w gore lub w dol po kliknieciu w edit
            }
            .navigationBarItems(trailing: EditButton()) // przycisk edycji listy
            .navigationBarTitle("Moja lista")
            .onAppear() {
                self.checklist.printChecklistContents()
            }
        }
    }
    
    // Methods
    // =======
    
    // przeniesione do checklist
}

// Preview
// =======

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ChecklistView()
    }
}

