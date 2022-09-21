//
//
// LoginPresenter.swift
// MoviesApp
//
// Using Swift 5.0
//
// Created by Ing. Miguel de Jesús Robledo Vera on 19/09/22.
// Copyright (c) 2022 and Confidential to Personal All rights reserved.
//


import Foundation

protocol LoginProtocol : AnyObject {
    func hideLoader()
    func showLoader()
    func showError(_ message: String)
    func goToHome()
}

protocol LoginPresenterProtocol {
    func loginApp(user: String, password: String)
}

class LoginPresenter: LoginPresenterProtocol {
    
    private weak var delegate: LoginProtocol?
    
   
    init(delegate: LoginProtocol) {
        self.delegate = delegate
    }
    
    func loginApp(user: String, password: String) {
        if user.isEmpty || password.isEmpty {
            delegate?.showError(.msgErrorUserLogin)
            return
        }
        
        self.callService(user: user, password: password)
    }
    
    private func callService(user: String, password: String) {
        
        let model = LoginRequets(username: user, password: password, requestToken: Singleton.instance.session?.requestToken ?? "")
        
        let jsonData = try? JSONSerialization.data(withJSONObject: model.toDictionary())
        
        self.delegate?.showLoader()
        APIClient().dataRequest(with: .login, body: jsonData, objectType: SessionResponse.self) { response in
            self.delegate?.hideLoader()
            switch response {
            case .success(let val) :
                
                if val.success ?? false {
                    self.delegate?.goToHome()
                } else {
                    self.delegate?.showError(val.statusMessage ?? "")
                }
            case .failure(let error) :                
                self.delegate?.showError(error.localizedDescription)
            }
        }
    }
}
