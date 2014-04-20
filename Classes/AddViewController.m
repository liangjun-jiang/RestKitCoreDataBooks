/*
     File: AddViewController.m
 Abstract: The table view controller responsible managing addition of a new book to the application.
  When editing ends, the controller sends a message to its delegate (in this case, the root view controller) to tell it that it finished editing and whether the user saved their changes. It's up to the delegate to actually commit the changes.
 The view controller needs a strong reference to the managed object context to make sure it doesn't disappear while being used (a managed object doesn't have a strong reference to its context).
 
  Version: 1.4
 
 */

#import "AddViewController.h"
#import "Tag.h"

@implementation AddViewController

- (void)viewDidLoad
{    
    [super viewDidLoad];
    
    // Set up the undo manager and set editing state to YES.
    [self setUpUndoManager];
    self.editing = YES;
}


- (IBAction)cancel:(id)sender
{
    [self.delegate addViewController:self didFinishWithSave:NO];
}


- (IBAction)save:(id)sender
{
    
    
    
    
    [[RKObjectManager sharedManager] postObject:self.book path:@"/1/classes/Book" parameters:nil success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        RKLogInfo(@"Load complete: Table should refresh...%@", mappingResult);
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        RKLogError(@"Load failed with error: %@", error);
    }];
    
    [self.delegate addViewController:self didFinishWithSave:YES];
}


- (void)dealloc
{
    [self cleanUpUndoManager];
}


@end
