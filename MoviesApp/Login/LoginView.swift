//
//
// LoginView.swift
// MoviesApp
//
// Using Swift 5.0
//
// Created by Ing. Miguel de Jesús Robledo Vera on 19/09/22.
// Copyright (c) 2022 and Confidential to Personal All rights reserved.
//


import UIKit

class LoginView: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var txtUser: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var lblError: UILabel!
    
    lazy var presenter: LoginPresenterProtocol = LoginPresenter(delegate: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblError.isHidden = true
        // Do any additional setup after loading the view.
    }
    
   
    
//    MARK: - Action buttons
    
    @IBAction func loginAction(_ sender: Any) {
        lblError.isHidden = true
         
        DispatchQueue.main.async {
            self.presenter.loginApp(user: self.txtUser.text?.trim() ?? "",
                                    password: self.txtPassword.text?.trim() ?? "")
        }
        hideKeyBoard()
    }
    
}


extension LoginView: LoginProtocol {
    func goToHome() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            let view  = HomeView.getViewController()
            
            let navigationController = UINavigationController(rootViewController: view)
            navigationController.fullScreen()
            
            self.present(navigationController, animated: true, completion: nil)
            
        }        
    }
    
    func hideLoader() {
        self.hideIndicator()
    }
    
    func showLoader() {
        self.showIndicator()
    }
    
    func showError(_ message: String) {
        //simpleAlert(title: .Verify, message: message)
        DispatchQueue.main.async {
            self.lblError.isHidden = false
            self.lblError.text = message
        }        
    }
    
    
}
