//
//
// ViewControllerExtension.swift
// MoviesApp
//
// Using Swift 5.0
//
// Created by Ing. Miguel de Jesús Robledo Vera on 19/09/22.
// Copyright (c) 2022 and Confidential to Personal All rights reserved.
//


import Foundation
import UIKit
import MBProgressHUD

extension UIViewController {
    
    private static var scvForm = UIScrollView()
    
    
    /// This extension is used to upload the keyboard in form screens
    /// - Parameter scroll: Receives the scroll of the parent view
    func setKeyBoardScroll(scroll: UIScrollView) {
        UIViewController.scvForm = scroll
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardWillShow(notification:) ),
                                               name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardWillHide(notification:)),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)
        
        let tap1 = UITapGestureRecognizer(target: self, action: #selector(hideKeyBoard))
        self.view.addGestureRecognizer(tap1)
        self.view.isUserInteractionEnabled = true
        
    }
    
    
    /// Funcionalidad para levantar el scroll y el teclado quede por debajo del input a editar
    /// - Parameter notification:
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let userInfo = notification.userInfo,
              let frame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        let contentInfo = UIEdgeInsets(top: 0, left: 0, bottom: frame.height, right: 0)
        UIViewController.scvForm.contentInset = contentInfo
    }
    
    /// Regresa el scroll de la vista a su posición original
    @objc func keyboardWillHide(notification: NSNotification) {
        UIViewController.scvForm.contentInset = UIEdgeInsets.zero
    }
    
    /// Funcionalidad para ocultar el teclado
    @objc func hideKeyBoard() {
        DispatchQueue.main.async {
            self.view.endEditing(true)
        }
    }
    
    /// This method sends an informational alert
    /// - Parameters:
    ///   - title: Description of the alert title
    ///   - message: Message to be displayed to the user
    ///   - controller: View Controller that will launch the alert
    ///   - titleButton: Button description title
    func simpleAlert(title: String, message: String, titleButton: String? = .Continue) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: titleButton, style: UIAlertAction.Style.default, handler: nil))
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    /// Abrir la vista de forma PopPup
    func modalPopPup() {
        self.providesPresentationContextTransitionStyle = true
        self.definesPresentationContext = true
        self.modalPresentationStyle = .overCurrentContext
        self.modalTransitionStyle = .crossDissolve
    }
    
    /// Abrir la vista de forma PopPup
    func fullScreen() {
        self.providesPresentationContextTransitionStyle = true
        self.definesPresentationContext = true
        self.modalPresentationStyle = .fullScreen
        self.modalTransitionStyle = .crossDissolve
        
    }
}

extension UIViewController {
    //MARK:- MBProgressHUD
    
    /// Abre un indicador Loader para informar que se está realizando alguna acción
    /// - Parameters:
    ///   - title: Descripción general
    ///   - Description: Texto informativo Subtitulo
    func showIndicator(withTitle title: String? = "", and Description:String? = "") {
        DispatchQueue.main.async {
            let Indicator = MBProgressHUD.showAdded(to: self.view, animated: true)
            Indicator.label.text = title
            Indicator.isUserInteractionEnabled = false
            Indicator.detailsLabel.text = Description
            Indicator.show(animated: true)
        }
    }
    
    ///Oculta el indicador Loader de la vista
    func hideIndicator() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            MBProgressHUD.hide(for: self.view, animated: true)
        }
    }
}
