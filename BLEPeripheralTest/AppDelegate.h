//
//  AppDelegate.h
//  BLEPeripheralTest
//
//  Created by Alessandro Maroso on 28/01/15.
//  Copyright (c) 2015 waresme. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <IOBluetooth/IOBluetooth.h>

@interface AppDelegate : NSObject <NSApplicationDelegate, CBPeripheralManagerDelegate>

@property (nonatomic, strong) IBOutlet NSButton *redButton;
@property (nonatomic, strong) IBOutlet NSButton *bluButton;

- (IBAction)buttonPressed:(id)sender;

@end

