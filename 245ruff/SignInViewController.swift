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
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func signInDidTap() {
        let form = self.formController.form as SignInForm;
        
        if form.login != nil && form.password != nil {
            SVProgressHUD.show()
            RuffnoteAPIClient.sharedClient.signIn(
                login: form.login,
                password: form.password,
                success: { (accessToken: String) in
                    let user = User(username: form.login, accessToken: accessToken)
                    AppConfiguration.sharedConfiguration.setCurrentUser(user)
                    SVProgressHUD.dismiss()
                    self.close()
                },
                failure: { (message: String) in
                    let alertController = UIAlertController(
                        title: NSLocalizedString("Error", comment: ""),
                        message: message,
                        preferredStyle: .Alert)
                    alertController.addAction(UIAlertAction(
                        title: NSLocalizedString("OK", comment: ""),
                        style: .Default,
                        handler: nil))
                    self.presentViewController(alertController, animated: true, completion: nil)
                    SVProgressHUD.dismiss()
            })
        }
    }

    func cancelItemDidTap(sender: AnyObject!) {
        self.close()
    }
    
    func close() {
        self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
}