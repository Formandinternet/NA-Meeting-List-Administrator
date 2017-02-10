//
//  MeetingEditorBaseViewController.swift
//  NA Meeting List Administrator
//
//  Created by MAGSHARE.
//
//  Copyright 2017 MAGSHARE
//
//  This is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//
//  NA Meeting List Administrator is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//
//  You should have received a copy of the GNU General Public License
//  along with this code.  If not, see <http://www.gnu.org/licenses/>.

import UIKit
import BMLTiOSLib

/* ###################################################################################################################################### */
// MARK: - Base Single Meeting Editor View Controller Class -
/* ###################################################################################################################################### */
/**
 This class describes the basic functionality for a full meeting editor.
 */
class MeetingEditorBaseViewController : EditorViewControllerBaseClass, UITableViewDataSource {
    /** This is a list of the indexes for our prototypes. */
    enum PrototypeSectionIndexes: Int {
        /** The Meeting Name Editable Section */
        case MeetingNameSection = 0
    }
    
    /** We use this as a common prefix for our reuse IDs, and the index as the suffix. */
    let reuseIDBase = "editor-row-"
    
    /** This is the meeting object for this instance. */
    var meetingObject: BMLTiOSLibEditableMeetingNode! = nil
    
    /** This is a list of all the cells (editor sections). */
    var editorSections: [MeetingEditorViewCell] = []
    
    @IBOutlet var tableView: UITableView!
    
    /** The following are sections in our table. Each is described by a prototype. */
    
    /** These are the three "dynamics" in the editor. */
    /** If true, then we allow the meeting to be deleted. */
    @IBInspectable var showDelete: Bool!
    /** If true, then we allow the meeting to be saved as a duplicate. */
    @IBInspectable var showDuplicate: Bool!
    /** If true, then we allow meeting history to be show. */
    @IBInspectable var showHistory: Bool!
    
    /* ################################################################## */
    // MARK: Overridden Base Class Methods
    /* ################################################################## */
    /**
     Called as the view is about to appear.
     
     - parameter animated: True, if the appearance is animated.
     */
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.editorSections = []
        self.tableView.reloadData()
    }
    
    /* ################################################################## */
    // MARK: UITableViewDataSource Methods
    /* ################################################################## */
    /**
     - parameter tableView: The UITableView object requesting the view
     - parameter numberOfRowsInSection: The section index (0-based).
     
     - returns the number of rows to display.
     */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Got this tip from here: http://natecook.com/blog/2014/10/loopy-random-enum-ideas/
        var max: Int = 0
        
        while let _ = PrototypeSectionIndexes(rawValue: max) { max += 1 }
        
        return max
    }
    
    /* ################################################################## */
    /**
     This is the routine that creates a new table row for the Meeting indicated by the index.
     
     - parameter tableView: The UITableView object requesting the view
     - parameter cellForRowAt: The IndexPath of the requested cell.
     
     - returns a nice, shiny cell (or sets the state of a reused one).
     */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reuseID = self.reuseIDBase + String(indexPath.row)
        
        if let returnableCell = tableView.dequeueReusableCell(withIdentifier: reuseID) as? MeetingEditorViewCell {
            returnableCell.meetingObject = self.meetingObject
            self.editorSections.append(returnableCell)
            return returnableCell
        }
        
        return UITableViewCell()
    }
}

/* ###################################################################################################################################### */
// MARK: - Meeting Name Editor Table Cell Class -
/* ###################################################################################################################################### */
/**
 This is the base table view class for the various cell prototypes.
 */
class MeetingEditorViewCell: UITableViewCell {
    private var _meetingObject: BMLTiOSLibEditableMeetingNode! = nil
    
    var meetingObject: BMLTiOSLibEditableMeetingNode! {
        get { return self._meetingObject }
        set {
            self._meetingObject = newValue
            self.meetingObjectUpdated()
        }
    }
    
    func meetingObjectUpdated() {
        
    }
}

/* ###################################################################################################################################### */
// MARK: - Meeting Name Editor Table Cell Class -
/* ###################################################################################################################################### */
/**
 This is the table view class for the name editor prototype.
 */
class MeetingNameEditorTableViewCell: MeetingEditorViewCell {
    /** This is the meeting name section. */
    @IBOutlet weak var meetingNameLabel: UILabel!
    @IBOutlet weak var meetingNameTextField: UITextField!
    
    override func meetingObjectUpdated() {
        self.meetingNameLabel.text = NSLocalizedString(self.meetingNameLabel.text!, comment: "")
        self.meetingNameTextField.placeholder = NSLocalizedString(self.meetingNameTextField.placeholder!, comment: "")
    }
}
