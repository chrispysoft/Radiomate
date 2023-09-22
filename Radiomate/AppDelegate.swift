//
//  AppDelegate.swift
//  Radiomate
//
//  Created by Chris on 22.09.23.
//

import Cocoa

@main
class AppDelegate: NSObject, NSApplicationDelegate {
    
    @IBOutlet var statusMenu: NSMenu!
    
    private let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)
    private let statusIcon = NSImage(systemSymbolName: "antenna.radiowaves.left.and.right", accessibilityDescription: "Radiomate")!
    private let radiomate = Scheduler(config: Config())
    
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        statusItem.menu = statusMenu
        statusItem.button?.image = statusIcon
    }
    
    func applicationWillTerminate(_ notification: Notification) {
        
    }
    
    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }
}
