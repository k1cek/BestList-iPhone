//
//  ContentView.swift
//  ToDoList
//
//  Created by Lukasz Zajac on 14/12/2020.
//

import SwiftUI

// Każdy program, niezależnie od języka programowania i platformy, ma punkt wejścia (entry point). To początek programu - pierwszy zestaw instrukcji wykonywanych podczas uruchamiania programu. W przypadku aplikacji dla systemu iOS punkt wejścia znajduje się w delegacie aplikacji, którego kod znajduje się w AppDelegate.swift. Możesz myśleć o app delegate jako o "root object" - „obiekcie głównym” aplikacji. Zarządza aplikacją na poziomie systemu, co obejmuje inicjalizację interfejsu użytkownika aplikacji.

struct ChecklistView: View {
    
    // 1. uruchomienie aplikacji: struktura jest tworzona.
    // 2. View ma dwie własciwosci: body, który definiuje interfejs i checklist, który łączy viewModel
    
    // Properties
    // ==========
    // tablica przeniesiona do checklist
    
    
    @ObservedObject var checklist = Checklist() // połączenie z Checklist() - nowa własciwosc, instancja. The = sign means “put whatever is on the right side of me into checklist,” and Checklist() means “create a new instance of Checklist.” This is ChecklistView’s connection to Checklist — the view’s connection to the ViewModel. As an @ObservedObject, checklist will always keep the view up-to-date with any changes to its @Published properties.
    
    @State var newChecklistItemViewIsVisible = false // property, when true, will couse pop-up to appear
    
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
                                // klikam na element i musze sie dowiedziec jaki ma index aby zastosowac toggle. Pobieram unikalny ID UUID i wyszukuje jaki ma index
                                // You provide firstIndex(where:) with the code in the braces — in case you’ve forgotten, it’s called a closure — and it goes through the array, applying that code to each element. The $0 is shorthand for “the first parameter passed to the closure,” which is the current array element.
                            
                            self.checklist.items[matchingIndex].isChecked.toggle()
                        }
                        self.checklist.printChecklistContents() // wyswitlam liste
                    }
                    
                }
                .onDelete(perform: checklist.deleteListItem) // umozliwia usuniecie elementu poprzez przsuniecie palcem
                .onMove(perform: checklist.moveListItem) // umozliwia przesuwanie listy w gore lub w dol po kliknieciu w edit
            }
            .navigationBarItems(
                leading: Button(action: {
                                    self.newChecklistItemViewIsVisible.toggle()
                    
                }) {
                    HStack {
                        Image(systemName: "plus.circle.fill")
                        Text("Dodaj")
                    }
                    .sheet(isPresented: $newChecklistItemViewIsVisible) { // wyswietla na całej stronie. .alert wyswietla tylko małe okienko na srodku. isPresented wyswietli sie jesli wartosc bedzie true
                        NewChecklistItemView()
                    }
                },
                trailing: EditButton()) // przycisk edycji listy
            .navigationBarTitle("Moja lista")
            .onAppear() { // pierwsze uruchomienie aplikacji,  wyswietla w konsoli liste
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

