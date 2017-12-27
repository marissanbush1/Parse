//
//  ChatViewController.swift
//  ParseChat
//
//  Created by Marissa Bush on 12/9/17.
//  Copyright © 2017 Marissa Bush. All rights reserved.
//

import UIKit
import Parse

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var messages: [PFObject]!
    
    @IBOutlet weak var chatTableView: UITableView!
    @IBOutlet weak var chatTextField: UITextField!
    
    @IBOutlet weak var sendButton: UIButton!
    
    @IBAction func didTapSend(_ sender: Any) {
        if chatTextField.text != "" {
            let chatMessage = PFObject(className: "Message");
            chatMessage["text"] = chatTextField.text
            chatMessage["user"] = PFUser.current()?.username
            
            chatMessage.saveInBackground(block: { (success, error) in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    print("The message was saved!");
                    self.chatTextField.text = "";
                }
            })
        }

    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = chatTableView.dequeueReusableCell(withIdentifier: "ChatCell", for: indexPath) as! ChatCell
        
        let Message = messages[indexPath.row]
        
        if let text = Message["text"] as? String {
            cell.chatTextLabel.text = text
        } else {
            cell.chatTextLabel.text = "N/A";
        }
        
        if let author = Message["user"] as? String {
            cell.chatAuthorLabel.text = author;
        } else {
            cell.chatAuthorLabel.text = "🤡";
        }
        
        return cell;
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        chatTableView.delegate = self
        chatTableView.dataSource = self

        // Do any additional setup after loading the view.
    }
    
    @objc func refresh() {
        let query = PFQuery(className: "Message");
        query.includeKey("user")
        query.order(byAscending: "createdAt");
        query.findObjectsInBackground { (Messages: [PFObject]?, error: Error?) in
            if let Messages = Messages {
                self.messages = Messages;
                self.chatTableView.reloadData();
            } else {
                print(error?.localizedDescription ?? "OOPS")
            }
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
