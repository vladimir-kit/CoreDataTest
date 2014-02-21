//
//  FirstViewController.m
//  CoreDataTutorial
//
//  Created by Alex on 2/20/14.
//  Copyright (c) 2014 Alex. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController () {
    @private
    NSManagedObjectContext *managedObjectContext;
}

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    managedObjectContext = [appDelegate managedObjectContext];
}

- (IBAction)buttonSave:(id)sender {
    NSEntityDescription *entityDirection = [NSEntityDescription entityForName:@"User" inManagedObjectContext:managedObjectContext];
    NSManagedObject *managedObject = [[NSManagedObject alloc] initWithEntity:entityDirection insertIntoManagedObjectContext:managedObjectContext];
    
    [managedObject setValue:[[self textFieldName] text] forKey:@"name"];
    [managedObject setValue:[[self textFieldLastName] text] forKey:@"last_name"];
    [managedObject setValue:[NSNumber numberWithInt:[[[self textFieldAge] text] intValue]] forKey:@"age"];
    
    NSError *error = nil;
    [managedObjectContext save:&error];
}

@end
