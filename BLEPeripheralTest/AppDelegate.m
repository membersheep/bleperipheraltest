//
//  AppDelegate.m
//  BLEPeripheralTest
//
//  Created by Alessandro Maroso on 28/01/15.
//  Copyright (c) 2015 waresme. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@property (nonatomic, strong) CBPeripheralManager *peripheralManager;
@property (nonatomic, strong) CBMutableService *service;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    self.peripheralManager = [[CBPeripheralManager alloc] initWithDelegate:self queue:nil];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

- (void)peripheralManagerDidUpdateState:(CBPeripheralManager *)peripheral
{
    if (CBPeripheralManagerStatePoweredOn == peripheral.state)
    {
        NSLog(@"peripheralManagerDidUpdateState: PoweredOn");
        self.button.enabled = YES;
        
        NSData *button = [@"button" dataUsingEncoding:NSUTF8StringEncoding];
        CBMutableCharacteristic *characteristic = [[CBMutableCharacteristic alloc] initWithType:[CBUUID UUIDWithString:@"b71e"]
                                                                                     properties:CBCharacteristicPropertyRead
                                                                                          value:button
                                                                                    permissions:CBAttributePermissionsReadable];
        
        self.service = [[CBMutableService alloc] initWithType:[CBUUID UUIDWithString:@"7e57"] primary:YES];
        self.service.characteristics = @[characteristic];
        
        [self.peripheralManager addService:self.service];
    }
    else
    {
        self.button.enabled = NO;
        [peripheral stopAdvertising];
        [peripheral removeAllServices];
    }
}


- (void)peripheralManagerDidStartAdvertising:(CBPeripheralManager *)peripheral error:(NSError *)error
{
    if (error)
        NSLog(@"%@", error);
    else
        NSLog(@"peripheralManagerDidStartAdvertising");
}

- (void)peripheralManager:(CBPeripheralManager *)peripheral didAddService:(CBService *)service error:(NSError *)error
{
    if (error)
        NSLog(@"%@", error);
    else
        NSLog(@"peripheralManagerDidAddService");
    
    [peripheral startAdvertising:@{ CBAdvertisementDataLocalNameKey: @"hello" }];
}

- (IBAction)buttonPressed:(id)sender
{
    NSLog(@"update peripheral value");
    [self.peripheralManager updateValue:[@"button ON" dataUsingEncoding:NSUTF8StringEncoding]
                      forCharacteristic:[self.service.characteristics firstObject]
                   onSubscribedCentrals:nil];
}

@end
