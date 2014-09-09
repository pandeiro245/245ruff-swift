//
//  SignInViewController.swift
//  245ruff
//
//  Created by nishiko on 2014/09/09.
//  Copyright (c) 2014年 nishiko. All rights reserved.
//

import UIKit

class SignInViewController: FXFormViewController {
    override init() {
        super.init()
        
        self.title = NSLocalizedString("Sign in", comment: "")
        self.formController.form = SignInForm()
        
        let cancelItem = UIBarButtonItem(barButtonSystemItem: .Cancel, target: self, action: "cancelItemDidTap:")
        self.navigationItem.leftBarButtonItem = cancelItem
    }
    
    func signInDidTap() {
        let form = self.formController.form as SignInForm;
        
        if form.login != nil {
            let user = User(username: form.login)
            AppConfiguration.sharedConfiguration.setCurrentUser(user)
            self.close()
        }
    }
    
    func cancelItemDidTap(sender: AnyObject!) {
        self.close()
    }
    
    func close() {
        self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
}