//
//  JotComposeViewController.swift
//  Jot
//
//  Created by Pierre on 5/3/16.
//  Copyright © 2016 pierre. All rights reserved.
//

import UIKit

class JotComposeViewController: UIViewController, UITextViewDelegate {

    
    
    //MARK: Properties
    var jot: Jot?
    var activityViewController: UIActivityViewController!
    
    
    
    //MARK: IBOutlets
    @IBOutlet weak var bodyTextView: UITextView!
    @IBOutlet var toolBar: UIToolbar!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var hideButton: UIBarButtonItem!
    
    
    
    //MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShow), name: NSNotification.Name.UIKeyboardDidShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidHide), name: NSNotification.Name.UIKeyboardDidHide, object: nil)
        
        
        bodyTextView.dataDetectorTypes = .all
        
        self.automaticallyAdjustsScrollViewInsets = false
        
        saveButton.isEnabled = false
        saveButton.image = UIImage(named: "save_button_50%")?.withRenderingMode(.alwaysOriginal)
    
        setupToolbar()
        
        bodyTextView.delegate = self
        bodyTextView.keyboardDismissMode = .interactive
        
        toolBar.sizeToFit()
        bodyTextView.inputAccessoryView = toolBar
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLayoutSubviews() {
        self.bodyTextView.setContentOffset(CGPoint.zero, animated: false)
    }


    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        bodyTextView.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    func setupToolbar() {
        hideButton.setTitleTextAttributes([
            NSFontAttributeName: UIFont(name: "Helvetica-Bold", size: 16.0)!,
            NSForegroundColorAttributeName: UIColor.purpleNavigationBarColor()
            ], for: UIControlState())
    }
    
    
    
    //MARK: IBActions
    @IBAction func saveButtonTapped(_ sender: AnyObject) {
        if bodyTextView.text.characters.count > 0 {
            if let jot = self.jot {
                jot.body = self.bodyTextView.text
                bodyTextView.resignFirstResponder()
            } else {
                let newJot = Jot(body: bodyTextView.text)
                JotController.sharedController.saveJot(newJot)
                self.jot = newJot
            }
            
            guard let navigationController = navigationController else {return}
            navigationController.popViewController(animated: true)
            
        } else {
            let alert = UIAlertController(title: "", message: "add a jot before saving", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            alert.view.tintColor = UIColor.purpleNavigationBarColor()
        }
    }
        
    
    @IBAction func hideButtonTapped(_ sender: AnyObject) {
        bodyTextView.resignFirstResponder()
    }

    @IBAction func deleteButtonTapped(_ sender: AnyObject) {
        if let jot = self.jot {
            JotController.sharedController.deleteJot(jot)
        }
        
        bodyTextView.text = ""
        
        guard let navigationController = navigationController else {return}
        navigationController.popViewController(animated: true)
    }

    @IBAction func shareButtonTapped(_ sender: AnyObject) {
        if bodyTextView.text.isEmpty {
            let alert = UIAlertController(title: "", message: "jot something before you share it", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            alert.view.tintColor = UIColor.purpleNavigationBarColor()
        } else {
            activityViewController = UIActivityViewController(activityItems: [bodyTextView.text as NSString], applicationActivities: nil)
            present(activityViewController, animated: true, completion: { 
                UIBarButtonItem.appearance().tintColor = UIColor.white
            })
        }
    }
    
    
    @IBAction func boltButtonTapped(_ sender: AnyObject) {
		//let selectedRange = bodyTextView.selectedRange
    }
    
    @IBAction func italicsButtonTapped(_ sender: AnyObject) {
        
    }
    
    @IBAction func underlineButtonTapped(_ sender: AnyObject) {
        //let selectedRange = bodyTextView.selectedRange
        //let currentAttributes = bodyTextView.textStorage.attributes(at: selectedRange.location, effectiveRange: nil)
    }
    
    
    func applyFontStyleToSelection(attributes: [String:AnyObject]) {
        let range = bodyTextView.selectedRange
        
        bodyTextView.textStorage.beginEditing()
        bodyTextView.textStorage.setAttributes(attributes, range: range)
        bodyTextView.textStorage.endEditing()
    }
    
    /*
    func textStyleSelection(range: NSRange, style: String) -> [String:AnyObject] {
        let attributes = bodyTextView.textStorage.attributes(at: range.location, effectiveRange: nil)
        
        guard let currentFont = attributes[NSFontAttributeName] as? UIFont else {
            return [NSFontAttributeName: UIFont(name: "AvenirNext", size: 24.0)!]
        }
        
        switch currentFont.fontName {
        case "AvenirNext-Bold":
            if style == "AvenirNext-Bold" {
            	return [NSFontAttributeName: UIFont(name: "AvenirNext-Bold", size: 24.0)!]
            }
        case "AvenirNext-Italic":
            if style == "AvenirNext-Italic" {
            	return [NSFontAttributeName: UIFont(name: "AvenirNext-Italic", size: 24.0)!]
            }
    	default:
            return [NSFontAttributeName: UIFont(name: "AvenirNext", size: 24.0)!]
        }
    }
    */
    
    
    
    
    
    
    

    
    func updateWithJot(_ jot: Jot) {
        self.jot = jot
        bodyTextView.text = jot.body
    }
    
    
    //MARK: TextViewDelegate
    func textViewDidChange(_ textView: UITextView) {
        if textView.text.characters.count > 0 {
            saveButton.image = UIImage(named: "save_button")?.withRenderingMode(.alwaysOriginal)
        } else {
            saveButton.image = UIImage(named: "save_button_50%")?.withRenderingMode(.alwaysOriginal)
        }
    }
    
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        saveButton.isEnabled = true
    }
 
    
    func keyboardDidShow(_ notification: Notification) {
        if let userInfo = (notification as NSNotification).userInfo {
            let keyboardFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as AnyObject).cgRectValue
            
            if let keyboardFrame = keyboardFrame {
                UIView.animate(withDuration: 0.25, delay: 0.0, options: .curveEaseOut, animations: { 
                    self.bodyTextView.contentInset = UIEdgeInsetsMake(0.0, 0.0, keyboardFrame.height, 0.0)
                    }, completion: nil)
            }
        }
    }
    
    func keyboardDidHide(_ notification: Notification) {
        UIView.animate(withDuration: 0.25, delay: 0.0, options: .curveEaseOut, animations: { 
            self.bodyTextView.contentInset = UIEdgeInsets.zero
            }, completion: nil)
    }
}
