//
//  ChecklistItem.swift
//  ToDoList
//
//  Created by Lukasz Zajac on 16/12/2020.
//
// MODEL FILE - Strategia wg MVVM


import Foundation

struct ChecklistItem: Identifiable { // Identifiable - protokół str 336
    let id = UUID() // Universally Unique Identifier - str 336. UUID() tworzy nową instancję UUID
    var name: String
    var isChecked: Bool = false
}
