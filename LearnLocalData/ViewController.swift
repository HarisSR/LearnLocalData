//
//  ViewController.swift
//  LearnLocalData
//
//  Created by Haris Shobaruddin Roabbni on 05/07/19.
//  Copyright © 2019 Haris Shobaruddin Robbani. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet weak var inputText: UITextField!
    @IBOutlet weak var passTextField: UITextField!
    
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    var users = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       // myLabel.text = UserDefaults.standard.string(forKey: "name")
        
        //ambil data menggunakan coredata
        getData()
    }

    @IBAction func inputButton(_ sender: UIButton) {
//        myLabel.text = inputText.text
//        // save to core data
//        UserDefaults.standard.set(myLabel.text, forKey: "name")
        
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        
        // buat object entity
        let user = User(context: managedContext)
        
        // set value ke atribut
        user.userName = inputText.text
        user.password = passTextField.text
        
        // commit changes
        do {
            try managedContext.save()
        } catch {
            print(error)
        }
        
        getData()
    }
    
    func getData(){
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        
        do {
            users = try managedContext.fetch(User.fetchRequest())
            for user in users {
                let username = user.userName
                let password = user.password
                
                // show ke label
                myLabel.text = "\(username!), \(password!)"
            }
        } catch {
            print(error)
        }
        print(users)
    }
    
}

