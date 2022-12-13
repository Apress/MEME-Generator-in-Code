//
//  EditorController.swift
//  MEMEGenerator
//
//  Created by Tihomir RAdeff on 1.11.22.
//

import UIKit

class EditorController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    @IBOutlet weak var editorView: UIView!
    
    @IBOutlet weak var line1Field: UITextField!
    @IBOutlet weak var line2Field: UITextField!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var line1Label: UILabel!
    @IBOutlet weak var line2Label: UILabel!
    
    var image: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        line1Field.delegate = self
        line2Field.delegate = self
        
        //rounded corners on the button
        saveButton.layer.cornerRadius = 16
        cancelButton.layer.cornerRadius = 16
        
        //show image
        imageView.image = UIImage(named: image!)
        
        //add shadow to the labels
        line1Label.layer.shadowColor = UIColor.blue.cgColor
        line1Label.layer.shadowRadius = 1.0
        line1Label.layer.shadowOpacity = 1.0
        line1Label.layer.shadowOffset = CGSize(width: 0, height: 0)
        line1Label.layer.masksToBounds = false
        
        line2Label.layer.shadowColor = UIColor.blue.cgColor
        line2Label.layer.shadowRadius = 1.0
        line2Label.layer.shadowOpacity = 1.0
        line2Label.layer.shadowOffset = CGSize(width: 0, height: 0)
        line2Label.layer.masksToBounds = false
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        line1Label.text = line1Field.text?.uppercased()
        line2Label.text = line2Field.text?.uppercased()
        
        view.endEditing(true)
    }
    
    @IBAction func cancelButtonAction(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func saveButtonAction(_ sender: Any) {
        //save image
        let imageSave = takeScreenshot(editorView)
        
        //share image
        let imageToShare = [imageSave]
        
        let activityViewControler = UIActivityViewController(activityItems: imageToShare, applicationActivities: nil)
        activityViewControler.popoverPresentationController?.sourceView = self.view
        
        activityViewControler.completionWithItemsHandler = {(actvityType: UIActivity.ActivityType?, completed: Bool, returnedItems: [Any]?, error: Error?) in
            if !completed {
                print("Cancelled!")
                return
            }
            print("Success!")
        }
        
        self.present(activityViewControler, animated: true, completion: nil)
    }
    
    func takeScreenshot(_ view: UIView) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, false, UIScreen.main.scale)
        view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        if image != nil {
            return image!
        }
        return UIImage()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        line1Label.text = line1Field.text?.uppercased()
        line2Label.text = line2Field.text?.uppercased()
        
        textField.resignFirstResponder()
        return true
    }
}
