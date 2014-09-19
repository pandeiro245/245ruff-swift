//
//  SettingsViewController.swift
//  245ruff
//
//  Created by nishiko on 2014/09/19.
//  Copyright (c) 2014年 nishiko. All rights reserved.
//

import UIKit

class SettingsViewController: FXFormViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.title = NSLocalizedString("Settings", comment: "")
        self.formController.form = SettingsForm()
        
        let cancelItem = UIBarButtonItem(barButtonSystemItem: .Cancel, target: self, action: "cancelItemDidTap:")
        self.navigationItem.leftBarButtonItem = cancelItem
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func signOutDidTap() {
        AppConfiguration.sharedConfiguration.setCurrentUser(nil)
        AppConfiguration.sharedConfiguration.setCurrentNote(nil)
        self.close()
    }
    
    func cancelItemDidTap(sender: AnyObject!) {
        self.close()
    }
    
    func close() {
        self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
}