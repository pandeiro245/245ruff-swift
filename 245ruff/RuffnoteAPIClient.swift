//
//  RuffnoteAPIClient.swift
//  245ruff
//
//  Created by nishiko on 2014/09/11.
//  Copyright (c) 2014年 nishiko. All rights reserved.
//

import Foundation

public class RuffnoteAPIClient: NSObject {
    
    let site = "https://ruffnote.com"
    let version = "/api/v1"
    
    public class var sharedClient: RuffnoteAPIClient {
        struct Singleton {
            static let sharedClient = RuffnoteAPIClient()
        }
        return Singleton.sharedClient
    }
    
    func signIn(#login: String, password: String, success: String -> (), failure: String -> ()) {
        let manager = AFHTTPRequestOperationManager()
        var params = [
            "grant_type" : "password",
            "login" : login,
            "password" : password,
            "client_id" : AppSecret.OAuth.clientId,
            "client_secret" : AppSecret.OAuth.clientSecret
        ]
        
        manager.POST(
            "\(site)/oauth/token",
            parameters: params,
            success: { (operation: AFHTTPRequestOperation!, responseObject: AnyObject!) in
                let response = responseObject as [String : AnyObject]
                let accessToken = responseObject["access_token"] as String
                self.notes(
                    accessToken: accessToken,
                    success: { (notes: [Note]) in
                        AppConfiguration.sharedConfiguration.setCurrentNote(notes.first)
                        success(accessToken)
                    },
                    failure: failure)
            },
            failure: { (operation: AFHTTPRequestOperation!, error: NSError!) in
                failure(error.localizedDescription)
            }
        )
    }
    
    func me(#accessToken: String, success: [String : AnyObject] -> (), failure: String -> ()) {
        let manager = authorizedManager(accessToken)
        manager.GET(
            "\(site)\(version)/me",
            parameters: nil,
            success: { (operation: AFHTTPRequestOperation!, responseObject: AnyObject!) in
                success(responseObject as [String : AnyObject])
            },
            failure: { (operation: AFHTTPRequestOperation!, error: NSError!) in
                failure(error.localizedDescription)
            }
        )
    }
    
    func notes(#accessToken: String, success: [Note] -> (), failure: String -> ()) {
        let manager = authorizedManager(accessToken)
        manager.GET(
            "\(site)\(version)/notes",
            //"\(site)\(version)/teams/pandeiro245/notes",
            //"\(site)\(version)/me?team=pandeiro245&type=private",
            //parameters: ["team" : "pandeiro245", "type" : "private"],
            //parameters: ["type" : "private"],
            parameters: ["type" : "fork"],
            success: { (operation: AFHTTPRequestOperation!, responseObject: AnyObject!) in
                var notes = [Note]()
                for attributes : NSDictionary in responseObject as Array {
                    notes.append(Note(attributes: attributes))
                }
                success(notes)
            },
            failure: { (operation: AFHTTPRequestOperation!, error: NSError!) in
                failure(error.localizedDescription)
            }
        )
    }
    
    func createPage(#accessToken: String, page: Page, success: () -> (), failure: String -> ()) {
        let manager = authorizedManager(accessToken)
        var params = [
            "page" : [
                "title" : page.title,
                "content" : page.content,
                "parent" : 16161 // nishiko original
            ]
        ]
        
        manager.POST(
            "\(site)\(version)/\(page.note.path)/pages",
            parameters: params,
            success: { (operation: AFHTTPRequestOperation!, responseObject: AnyObject!) in
                success()
            },
            failure: { (operation: AFHTTPRequestOperation!, error: NSError!) in
                failure(error.localizedDescription)
            }
        )
    }
    
    func createNote(#accessToken: String, note: Note, success: Note -> (), failure: String -> ()) {
        let manager = authorizedManager(accessToken)
        var params = [
            "note" : [
                "title" : note.title,
                "is_private" : note.isPrivate,
                "format" : note.format,
                "team" : note.team.name
            ]
        ]
        
        manager.POST(
            "\(site)\(version)\notes",
            parameters: params,
            success: { (operation: AFHTTPRequestOperation!, responseObject: AnyObject!) in
                let note = Note(attributes: responseObject as NSDictionary)
                success(note)
            },
            failure: { (operation: AFHTTPRequestOperation!, error: NSError!) in
                failure(error.localizedDescription)
            }
        )
    }
    
    private func authorizedManager(accessToken: String) -> AFHTTPRequestOperationManager{
        let manager = AFHTTPRequestOperationManager()
        manager.requestSerializer.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        return manager
    }
}