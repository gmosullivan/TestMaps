//
//  ViewController.swift
//  Test
//
//  Created by Gareth O'Sullivan on 20/08/2018.
//  Copyright © 2018 Locust Redemption. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func attemptLogIn() {
        let url = URL(string: "https://www.udacity.com/api/session")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("appliaction/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = "{\"udacity\": {\"username\": \"\(emailTextField.text!)\", \"password\": \"\(passwordTextField.text!)\"}}".data(using: .utf8)
        print(request)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
            guard (error == nil) else {
                print(error!)
                return
            }
            guard let data = data else {
                print("No data")
                return
            }
            let range = Range(5..<data.count)
            let newData = data.subdata(in: range)
            let parsedResult: [String:AnyObject]
            do {
                parsedResult = try JSONSerialization.jsonObject(with: newData, options: .allowFragments) as! [String:AnyObject]
            } catch {
                print("Could not parse \(newData)")
                return
            }
            print(parsedResult)
        }
        task.resume()
    }
    
    @IBAction func directToSignUp() {
        print("User needs to sign up")
    }


}

