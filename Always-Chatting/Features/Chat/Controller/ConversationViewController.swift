//
//  ConversationViewController.swift
//  Always-Chatting
//
//  Created by Fernando Tello on 18/04/22.
//

import UIKit
import Firebase

class ConversationViewController:UITableViewController {
    
    var conversations: [String] = []
    
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
        
        loadConversation()
    }
}

// MARK: - Functions
extension ConversationViewController {
    
    // MARK: - Data Manipulation Methods
    func loadConversation() {
        db.collection("conversations").getDocuments() { (querySnapshot, err) in
            self.conversations = []
            if let err = err {
                print("Error getting documents : \(err)")
            } else {
                for document in querySnapshot!.documents {
                    let documentID = document.documentID
                    let date = document.get("date") as? Timestamp
                    let name = document.get("name") as? String ?? "name default"
                    
                    print(documentID)
                    print(name)
                    self.conversations.append(name)
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
        
        //        db.collection(K.FStore.collectionName)
        //            .order(by: K.FStore.dateField)
        //            .addSnapshotListener { (querySnapshot, error) in
        //
        //            self.messages = []
        //
        //            if let e = error {
        //                print("There was an issue retrieving data from Firestore. \(e)")
        //            } else {
        //                if let snapshotDocuments = querySnapshot?.documents {
        //                    for doc in snapshotDocuments {
        //                        let data = doc.data()
        //                        if let messageSender = data[K.FStore.senderField] as? String, let messageBody = data[K.FStore.bodyField] as? String {
        //                            let newMessage = Message(sender: messageSender, body: messageBody)
        //                            self.messages.append(newMessage)
        //
        //                            DispatchQueue.main.async {
        //                                   self.tableView.reloadData()
        //                                let indexPath = IndexPath(row: self.messages.count - 1, section: 0)
        //                                self.tableView.scrollToRow(at: indexPath, at: .top, animated: false)
        //                            }
        //                        }
        //                    }
        //                }
        //            }
        //        }
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

// MARK: - Table View
extension ConversationViewController {
    // Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        conversations.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ConversationItemCell", for: indexPath)
        let item = conversations[indexPath.row]
        cell.textLabel?.text = item
        return cell
    }
    
    // Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(conversations[indexPath.row])
        print(indexPath.row)
    }
}
