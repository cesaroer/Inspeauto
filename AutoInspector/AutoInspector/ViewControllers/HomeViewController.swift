//
//  HomeViewController.swift
//  AutoInspector
//
//  Created by Cesar on 13/02/20.
//  Copyright © 2020 CesarVargas. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let evStoryBoard = UIStoryboard(name: "Events", bundle: nil)
    @IBOutlet weak var tableView: UITableView!
    var automobile : [[AutomobileModel]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clear
        loadData()
    }
    
    func loadData(){
        let db = Firestore.firestore()
        let userID = Auth.auth().currentUser?.uid ?? ""
        
        db.collection("automobile").whereField("uid", isEqualTo: userID)
            .getDocuments() { (querySnapshot, err) in
                let decoder = JSONDecoder()
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        if let data = try?  JSONSerialization.data(withJSONObject: document.data(), options: []) {
                            let auto = try? decoder.decode(AutomobileModel.self, from: data)
                            self.automobile.append([auto!])
                        }
                    }
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return automobile.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AutomobileTableViewCell.identifier, for: indexPath)  as? AutomobileTableViewCell
        cell?.updateCell(automobile: automobile[indexPath.row][0])
        return cell ?? UITableViewCell()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Creamos una variable que almacenara nuestro storyboard
            let nextViewController = evStoryBoard.instantiateViewController(withIdentifier: "eventsVC") as! EventsViewController
        //Configuramos el tipo de presentacion que queremos, en este caso será a pantalla completa y no modal
            nextViewController.modalPresentationStyle = .fullScreen
        //Presentamos el Storyboard
            self.present(nextViewController,animated:true,completion: nil)
    }
}
