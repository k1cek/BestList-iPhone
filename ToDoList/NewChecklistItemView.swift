//
//  NewChecklistItemView.swift
//  ToDoList
//
//  Created by Lukasz Zajac on 17/12/2020.
//

import SwiftUI

struct NewChecklistItemView: View {
    var body: some View {
        VStack {
            Text("Add new item")
            Form { // lista (List) ładnie porządkuje kod, Form również ;)
                Text("Enter item name")
                Button(action: {
                    
                }) {
                    HStack {
                        Image(systemName: "plus.circle.fill")
                        Text("Add new item")
                    }
                }
            }
            HStack {
                Text("Swipe down to cancel...")
                Image(systemName: "icloud.and.arrow.down")
            }
            
        }
    }
}

struct NewChecklistItemView_Previews: PreviewProvider {
    static var previews: some View {
        NewChecklistItemView()
    }
}
