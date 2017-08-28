//
//  GetQRCodeView.swift
//  QRCode
//
//  Created by luojie on 16/10/24.
//  Copyright © 2016年 LuoJie. All rights reserved.
//

import UIKit
import AVFoundation
import RxSwift

open class GetQRCodeView: UIView, AVCaptureMetadataOutputObjectsDelegate {
    
    public var value: Observable<String> { return _value.asObservable() }
    private let _value = PublishSubject<String>()
    
    private var captureSession:AVCaptureSession?
    private var videoPreviewLayer:AVCaptureVideoPreviewLayer?
    private var qrCodeFrameView:UIView?
    
    private let supportedBarCodes = [
        AVMetadataObjectTypeQRCode,
        AVMetadataObjectTypeCode128Code,
        AVMetadataObjectTypeCode39Code,
        AVMetadataObjectTypeCode93Code,
        AVMetadataObjectTypeUPCECode,
        AVMetadataObjectTypePDF417Code,
        AVMetadataObjectTypeEAN13Code,
        AVMetadataObjectTypeAztecCode
    ]
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        videoPreviewLayer?.frame = layer.bounds
    }
    
    override open func awakeFromNib() {
        super.awakeFromNib()
        let captureDevice = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
        
        do {
            // Get an instance of the AVCaptureDeviceInput class using the previous device object.
            let input = try AVCaptureDeviceInput(device: captureDevice)
            
            // Initialize the captureSession object.
            captureSession = AVCaptureSession()
            // Set the input device on the capture session.
            captureSession?.addInput(input)
            
            // Initialize a AVCaptureMetadataOutput object and set it as the output device to the capture session.
            let captureMetadataOutput = AVCaptureMetadataOutput()
            captureSession?.addOutput(captureMetadataOutput)
            
            // Set delegate and use the default dispatch queue to execute the call back
            captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            
            // Detect all the supported bar code
            captureMetadataOutput.metadataObjectTypes = supportedBarCodes
            
            // Initialize the video preview layer and add it as a sublayer to the viewPreview view's layer.
            videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            videoPreviewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
            layer.insertSublayer(videoPreviewLayer!, at: 0)
            // Start video capture
            captureSession?.startRunning()
            
            // Move the message label to the top view
            
            // Initialize QR Code Frame to highlight the QR code
            qrCodeFrameView = UIView()
            
            if let qrCodeFrameView = qrCodeFrameView {
                qrCodeFrameView.layer.borderColor = UIColor.green.cgColor
                qrCodeFrameView.layer.borderWidth = 2
                addSubview(qrCodeFrameView)
                bringSubview(toFront: qrCodeFrameView)
            }
            
        } catch {
            // If any error occurs, simply print it out and don't continue any more.
            print(error)
            return
        }
    }
    
    public func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!) {
        
        // Check if the metadataObjects array is not nil and it contains at least one object.
        if metadataObjects == nil || metadataObjects.count == 0 {
            qrCodeFrameView?.frame = .zero
            return
        }
        
        // Get the metadata object.
        let metadataObj = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
        
        if supportedBarCodes.contains(metadataObj.type) {
            let barCodeObject = videoPreviewLayer?.transformedMetadataObject(for: metadataObj)
            qrCodeFrameView?.frame = barCodeObject!.bounds
            if metadataObj.stringValue != nil {
                _value.onNext(metadataObj.stringValue!)
            }
        }
    }
    
    public func startCapture() {
        captureSession?.startRunning()
    }
    
    public func stopCapture() {
        captureSession?.stopRunning()
        qrCodeFrameView?.frame = .zero
    }
}
