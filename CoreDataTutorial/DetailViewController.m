//
//  DetailViewController.m
//  CoreDataTutorial
//
//  Created by Alex on 2/21/14.
//  Copyright (c) 2014 Alex. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController () {
    NSManagedObjectContext *managedObjectContext;
}

@property (strong) NSManagedObject *users;

@end


@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    managedObjectContext = [appDelegate managedObjectContext];
    
    [self reloadData];
}

- (void)reloadData {
    [[self textFieldName] setText:[[self user] name]];
    [[self textFieldLastName] setText:[[self user] last_name]];
}

- (void)buttonSave:(id)sender {
    
    [[self user] setValue:[[self textFieldName] text] forKey:@"name"];
    [[self user] setValue:[[self textFieldLastName] text] forKey:@"last_name"];
    [managedObjectContext save:nil];
}

@end
