//
//  ShowEntryMoreViewModel.swift
//  untitledtvproject
//
//  Created by josefin hellgren on 2023-06-09.
//

import Foundation
import Firebase


class ShowEntryMoreViewModel :ObservableObject{
    @Published var showingAlert: Bool = false
    
    
    func saveToFireStore(show2: ApiShows.Returned, listChoice: String) {
        let db = Firestore.firestore()
        guard let user = Auth.auth().currentUser else {return}
        do {
            _ = try db.collection("users").document(user.uid).collection(listChoice).addDocument(from: show2)
            showingAlert = true
        } catch {
                print("error!")
            }
        }
    
    
    
    
    
}
