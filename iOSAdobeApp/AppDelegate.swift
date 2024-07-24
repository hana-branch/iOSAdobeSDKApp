//
//  AppDelegate.swift
//  iOSAdobeApp
//
//  Created by Hana Park on 7/23/24.
//

import UIKit
import AdobeBranchExtension

import AEPCore;
import AEPSignal;
import AEPLifecycle;
import AEPIdentity;
import AEPServices;
import AEPAnalytics;
import AEPUserProfile;

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        Branch.enableLogging()
        // Handle your Branch deep link routing in the callback
        AdobeBranchExtension.initSession(launchOptions: launchOptions ?? [:]) { (params, error) in
            if error == nil, let clickedBranchLink = params?["+clicked_branch_link"] as? Bool, clickedBranchLink {
                // Handle Branch Link data (route user, show alert, etc)
            }
        }
        
        // Register AdobeBranchExtension with AEPMobileCore
//        MobileCore.setLogLevel(.error)
        let appState = application.applicationState
        MobileCore.registerExtensions([AdobeBranchExtension.self, MobileCore.self, Signal.self, Lifecycle.self, UserProfile.self, Identity.self, Analytics.self, /*Other AEP SDK's*/], {
            print("AdobeBranchExtension Registered!")
            MobileCore.configureWith(appId: "d10f76259195/c769149ebd48/launch-f972d1367b58-development")
            if appState != .background {
                // Only start lifecycle if the application is not in the background
                MobileCore.lifecycleStart(additionalContextData: ["contextDataKey": "contextDataVal"])
            }
        })
        AdobeBranchExtension.configureEventTypes(["com.adobe.eventType.analytics"], andEventSources: ["com.adobe.eventSource.responseContent"])
        
        return true
    }
    
    // Handling URL opening
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        AdobeBranchExtension.application(app, open: url, options: options)
        return true
    }

    // Handling User Activity
    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        AdobeBranchExtension.application(application, continue: userActivity)
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    func setupTestConfig() {
        var config: [String: Any] = [:]
        
        // ============================================================
        // global
        // ============================================================
        config["global.privacy"] = "optedin"
        config["global.ssl"] = true
        
        // ============================================================
        // Branch
        // ============================================================
        config["branchKey"] = "key_live_fdGefNezUn2f4SqsEYE6sljpDwmRPOl2"
        
        // ============================================================
        // acquisition
        // ============================================================
        config["acquisition.appid"] = ""
        config["acquisition.server"] = ""
        config["acquisition.timeout"] = 0
        
        // ============================================================
        // analytics
        // ============================================================
        config["analytics.aamForwardingEnabled"] = false
        config["analytics.batchLimit"] = 0
        config["analytics.offlineEnabled"] = true
        config["analytics.rsids"] = ""
        config["analytics.server"] = ""
        config["analytics.referrerTimeout"] = 0
        
        // ============================================================
        // audience manager
        // ============================================================
        config["audience.server"] = ""
        config["audience.timeout"] = 0
        
        // ============================================================
        // identity
        // ============================================================
        config["experienceCloud.server"] = ""
        config["experienceCloud.org"] = ""
        config["identity.adidEnabled"] = false
        
        // ============================================================
        // target
        // ============================================================
        config["target.clientCode"] = ""
        config["target.timeout"] = 0
        
        // ============================================================
        // lifecycle
        // ============================================================
        config["lifecycle.sessionTimeout"] = 0
        config["lifecycle.backdateSessionInfo"] = false
        
        // ============================================================
        // rules engine
        // ============================================================
        config["rules.url"] = "pathtoyourrulesfile"
        config["com.branch.extension/deepLinkKey"] = "pictureId"
        config["deepLinkKey"] = "pictureId"
        
        MobileCore.updateConfigurationWith(configDict: config)

    }


}

