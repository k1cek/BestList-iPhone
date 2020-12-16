//
//  Checklist.swift
//  ToDoList
//
//  Created by Lukasz Zajac on 16/12/2020.
//
// ViewModel - Strategia wg MVVM

import Foundation

// klasa z rodzajem ObservableObject - ObservableObject jest protokołem i jak sama nazwa wskazuje, kiedy używasz go na obiekcie, inny obiekt może obserwować zmiany. Ten inny obiekt nazywany jest obserwatorem.

// We wzorcu MVVM View obserwuje ViewModel. Ta relacja obserwator - obserwowany wiąże View i ViewModel, tak że gdy dane wyświetlane użytkownikowi są aktualizowane w ViewModel, View aktualizuje się automatycznie.

// The ViewModel should contain all the functionality that the view needs to present
// information to the user. So far, that functionality is:

// 1. Displaying the checklist items.
// 2. Deleting an item.
// 3. Moving an item.
// 4. Toggling an item between “checked” and “unchecked”.

// Zmiana @State na @Published


class Checklist: ObservableObject {
    @Published var items = [
        ChecklistItem(name: "Walk the dog", isChecked: false),
        ChecklistItem(name: "Walk the dog", isChecked: true),
        ChecklistItem(name: "Brush my teeth", isChecked: true),
        ChecklistItem(name: "Learn iOS development", isChecked: true),
        ChecklistItem(name: "Finish homework", isChecked: false),
        ChecklistItem(name: "Change internet provider", isChecked: false),
        ChecklistItem(name: "Read Raywenderlich.com", isChecked: true),
    ]
    
    //metody
    
    func printChecklistContents() {
        for item in items {
            print(item)
        }
    }
    
    func deleteListItem(whichElement: IndexSet) {
        items.remove(atOffsets: whichElement)
        printChecklistContents()
    }
    
    func moveListItem(whichElement: IndexSet, destination: Int) {
        items.move(fromOffsets: whichElement, toOffset: destination)
        printChecklistContents()
    }
}
