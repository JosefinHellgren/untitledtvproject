//
//  ShowEntryViewModel.swift
//  untitledtvproject
//
//  Created by josefin hellgren on 2023-06-09.
//

import Foundation
import Firebase

class ShowEntryViewModel : ObservableObject{
    
    @Published var summary: String = ""
       @Published var showingAlertPopUp: Bool = false
    
    func saveToFireStore (show2: ApiShows.Returned, listChoice: String){
        
        let db = Firestore.firestore()
        guard let user = Auth.auth().currentUser else {return}
        do {
            _ = try db.collection("users").document(user.uid).collection(listChoice).addDocument(from: show2)
            showingAlertPopUp = true
        } catch {
            print("error!")
            }
    }
    
    func setContent() {
        
        summary = summary.replacingOccurrences(of: "<p>", with: "")
        summary = summary.replacingOccurrences(of: "</p>", with: "")
        summary = summary.replacingOccurrences(of: "<b>", with: "")
        summary = summary.replacingOccurrences(of: "</b>", with: "")
        summary = summary.replacingOccurrences(of: "<i>", with: "")
        summary = summary.replacingOccurrences(of: "</i>", with: "")
    }
    
    
    
}
