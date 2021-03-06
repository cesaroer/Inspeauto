//
//  Styles.swift
//  AutoInspector
//
//  Created by Cesar on 14/02/20.
//  Copyright © 2020 CesarVargas. All rights reserved.
//

import Foundation
import UIKit

class Styles {
    
    static func styleTextField(_ textfield:UITextField) {
        
        // Create the bottom line
        let bottomLine = CALayer()
        
        bottomLine.frame = CGRect(x: 0, y: textfield.frame.height - 2, width: textfield.frame.width, height: 2)
        
        bottomLine.backgroundColor = UIColor.myGreen.cgColor
        
        // Remove border on text field
        textfield.borderStyle = .none
        
        // Add the line to the text field
        textfield.layer.addSublayer(bottomLine)
        
    }
    
    static func styleFilledButton(_ button:UIButton) {
        
        // Filled rounded corner style
        button.backgroundColor = UIColor.myGreen
        button.layer.cornerRadius = 25.0
        button.tintColor = UIColor.white
    }
    
    static func styleHollowButton(_ button:UIButton) {
        
        // Hollow rounded corner style
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.myBlue.cgColor
        button.layer.cornerRadius = 25.0
        button.tintColor = UIColor.myBlue
    }
    
    
    //Funcion que valida la contraseña
    static func isPasswordValid(_ password : String) -> Bool {
        
        //Expresion regular con la que validaremos el formato de la contraseña
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        
        
        return passwordTest.evaluate(with: password)
    }
    
}

