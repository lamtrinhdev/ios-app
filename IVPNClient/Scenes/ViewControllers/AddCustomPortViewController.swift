//
//  AddCustomPortViewController.swift
//  IVPN iOS app
//  https://github.com/ivpn/ios-app
//
//  Created by Juraj Hilje on 2022-10-06.
//  Copyright (c) 2022 Privatus Limited.
//
//  This file is part of the IVPN iOS app.
//
//  The IVPN iOS app is free software: you can redistribute it and/or
//  modify it under the terms of the GNU General Public License as published by the Free
//  Software Foundation, either version 3 of the License, or (at your option) any later version.
//
//  The IVPN iOS app is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
//  or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
//  details.
//
//  You should have received a copy of the GNU General Public License
//  along with the IVPN iOS app. If not, see <https://www.gnu.org/licenses/>.
//

import UIKit

protocol AddCustomPortViewControllerDelegate: AnyObject {
    func customPortAdded(port: ConnectionSettings)
}

class AddCustomPortViewController: UITableViewController {
    
    // MARK: - Properties -
    
    @IBOutlet weak var portTextField: UITextField!
    @IBOutlet weak var typeControl: UISegmentedControl!
    
    weak var delegate: AddCustomPortViewControllerDelegate?
    var vpnProtocol = ""
    
    // MARK: - @IBActions -
    
    @IBAction func addPort() {
        var port: ConnectionSettings
        let number = Int(portTextField.text ?? "") ?? 0
        
        if vpnProtocol == "OpenVPN" {
            if typeControl.selectedSegmentIndex == 1 {
                port = .openvpn(.tcp, number)
            } else {
                port = .openvpn(.udp, number)
            }
        } else {
            port = .wireguard(.udp, number)
        }
        
        delegate?.customPortAdded(port: port)
        navigationController?.dismiss(animated: true)
    }

}

// MARK: - UITextFieldDelegate -

extension AddCustomPortViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == portTextField {
            textField.resignFirstResponder()
            addPort()
        }
        
        return true
    }
    
}
