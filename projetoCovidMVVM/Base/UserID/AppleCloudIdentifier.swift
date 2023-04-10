//
//  AppleCloudIdentifier.swift
//  projetoCovidMVVM
//
//  Created by Roberto Edgar Geiss on 09/04/23.
//

import UIKit
import CloudKit

enum AppleCloudIdentifierError: Error
{
    case unknown
}

class AppleCloudIdentifier: NSObject
{
    class func fetch(_ completionHandler: @escaping (Result<String, Error>) -> Void)
    {
        let container = CKContainer.default()
        container.fetchUserRecordID { (recordID, error) in
            guard let recordID = recordID
            else
            {
                completionHandler(.failure(error ?? AppleCloudIdentifierError.unknown))
                return
            }
            completionHandler(.success(recordID.recordName))
        }
    }
}
