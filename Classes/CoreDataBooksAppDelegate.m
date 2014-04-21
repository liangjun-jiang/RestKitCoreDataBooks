/*
     File: CoreDataBooksAppDelegate.m
 Abstract: Application delegate to set up the Core Data stack and configure the first view and navigation controllers.
  Version: 1.4
 
 Copyright (C) 2013 Apple Inc. All Rights Reserved.
 
 */

#import "CoreDataBooksAppDelegate.h"
#import "RootViewController.h"
#import "Book+Addition.h"
#import "RKValueTransformers.h"
#import <RestKit/RestKit.h>
#import "User+Addition.h"
#import "Tag+Addition.h"
@interface CoreDataBooksAppDelegate ()

@property (nonatomic, strong, readonly) NSManagedObjectModel *managedObjectModel;


@end


#pragma mark -

@implementation CoreDataBooksAppDelegate

@synthesize managedObjectModel=_managedObjectModel;

#pragma mark - Application lifecycle

- (void)applicationDidFinishLaunching:(UIApplication *)application
{
    
    [self setupEntityMapping];
}


- (void)applicationWillTerminate:(UIApplication *)application
{
}


- (void)applicationWillResignActive:(UIApplication *)application
{
}


- (void)applicationDidEnterBackground:(UIApplication *)application
{
}


// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"CoreDataBooks" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

#pragma mark -

- (void)setupEntityMapping
{
//    RKLogConfigureByName("RestKit/ObjectMapping", RKLogLevelTrace);
    
    NSURL *baseURL = [NSURL URLWithString:API_BASE_URL];
    RKObjectManager *objectManager = [RKObjectManager managerWithBaseURL:baseURL];
    objectManager.requestSerializationMIMEType = RKMIMETypeJSON;
    [objectManager.HTTPClient setDefaultHeader:@"X-Parse-Application-Id" value:API_APP_ID];
    [objectManager.HTTPClient setDefaultHeader:@"X-Parse-REST-API-Key" value:API_APP_TOKEN];
    
    // Enable Activity Indicator Spinner
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    
    
    RKManagedObjectStore *managedObjectStore = [[RKManagedObjectStore alloc] initWithManagedObjectModel:self.managedObjectModel];
    objectManager.managedObjectStore = managedObjectStore;
    
    RKEntityMapping *userMapping = [RKEntityMapping mappingForEntityForName:@"User" inManagedObjectStore:managedObjectStore];
    [userMapping addAttributeMappingsFromDictionary:[User dictionaryMappingResponse]];
    
//    RKObjectMapping *userRequestMapping = [RKObjectMapping requestMapping];
//    [userRequestMapping addAttributeMappingsFromDictionary:[User dictionaryMappingResponse]];
//    
//    RKRequestDescriptor *userPostDescriptor = [RKRequestDescriptor requestDescriptorWithMapping:userRequestMapping objectClass:[User class] rootKeyPath:nil method:RKRequestMethodPOST];
    
    RKEntityMapping *tagMapping = [RKEntityMapping mappingForEntityForName:@"Tag" inManagedObjectStore:managedObjectStore];
    tagMapping.identificationAttributes = @[@"objectId"];
    [tagMapping addAttributeMappingsFromArray:[Tag arrayForResponseMapping]];
    
    RKEntityMapping *bookMapping = [RKEntityMapping mappingForEntityForName:@"Book" inManagedObjectStore:managedObjectStore];
    bookMapping.identificationAttributes=@[@"objectId"];
    [bookMapping addAttributeMappingsFromArray:[Book arrayForResponseMapping]];
//    [bookMapping addAttributeMappingsFromDictionary:[Book dictionaryForResponseMapping]];
    [bookMapping addRelationshipMappingWithSourceKeyPath:@"tags" mapping:tagMapping];
    
    //user mapping
    [bookMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"user"
                                                                                   toKeyPath:@"user"
                                                                                 withMapping:userMapping]];
    
//    NSEntityDescription *projectEntity = [NSEntityDescription entityForName:@"Project" inManagedObjectContext:managedObjectContext];
//    NSRelationshipDescription *userRelationship = [projectEntity relationshipsByName][@"user"];
//    RKConnectionDescription *connection = [[RKConnectionDescription alloc] initWithRelationship:userRelationship attributes:@{ @"userID": @"userID" }];
    
//    NSDateFormatter *dateFormatter = [NSDateFormatter new];
//    dateFormatter.dateFormat = @"E MMM d HH:mm:ss Z y";
//    dateFormatter.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
//    [[RKValueTransformer defaultValueTransformer] insertValueTransformer:dateFormatter atIndex:0];
    
    // Register our mappings with the provider
    RKObjectMapping *errorMapping = [RKObjectMapping mappingForClass:[RKErrorMessage class]];
    
    [errorMapping addPropertyMapping:[RKAttributeMapping attributeMappingFromKeyPath:nil toKeyPath:@"errorMessage"]];
    RKResponseDescriptor *errorDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:errorMapping method:RKRequestMethodGET pathPattern:nil keyPath:@"error" statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassClientError)];
    
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:bookMapping
                                                                                            method:RKRequestMethodGET
                                                                                       pathPattern:nil
                                                                                           keyPath:@"results"
                                                                                       statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    
    
    RKResponseDescriptor *postResponseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:bookMapping
                                                                                            method:RKRequestMethodGET
                                                                                       pathPattern:nil
                                                                                           keyPath:nil
                                                                                       statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    RKResponseDescriptor *userpostResponseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:userMapping
                                                                                                method:RKRequestMethodGET
                                                                                           pathPattern:nil
                                                                                               keyPath:nil
                                                                                           statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    
    [objectManager addResponseDescriptorsFromArray:@[errorDescriptor, responseDescriptor, postResponseDescriptor,userpostResponseDescriptor]];
    
    // Do we need to have this?
    RKObjectMapping *requestMapping = [RKObjectMapping requestMapping];
    [requestMapping addAttributeMappingsFromDictionary:[Book dictionaryForResponseMapping]];

    RKRequestDescriptor *postDescriptor = [RKRequestDescriptor requestDescriptorWithMapping:requestMapping objectClass:[Book class] rootKeyPath:nil method:RKRequestMethodPOST];
    RKRequestDescriptor *putDescriptor = [RKRequestDescriptor requestDescriptorWithMapping:requestMapping objectClass:[Book class] rootKeyPath:nil method:RKRequestMethodPUT];
    RKRequestDescriptor *deleteDescriptor = [RKRequestDescriptor requestDescriptorWithMapping:requestMapping objectClass:[Book class] rootKeyPath:nil method:RKRequestMethodDELETE];
    [objectManager addRequestDescriptorsFromArray:@[postDescriptor, putDescriptor, deleteDescriptor]];

    
    
    /**
     Complete Core Data stack initialization
     */
    [managedObjectStore createPersistentStoreCoordinator];
    NSString *storePath = [RKApplicationDataDirectory() stringByAppendingPathComponent:@"CoreDataBooks.CDBStore"];
    NSError *error;
    NSPersistentStore *persistentStore = [managedObjectStore addSQLitePersistentStoreAtPath:storePath fromSeedDatabaseAtPath:nil withConfiguration:nil options:nil error:&error];
    NSAssert(persistentStore, @"Failed to add persistent store with error: %@", error);
    
    // Create the managed object contexts
    [managedObjectStore createManagedObjectContexts];
    
    // Configure a managed object cache to ensure we do not create duplicate objects
    managedObjectStore.managedObjectCache = [[RKInMemoryManagedObjectCache alloc] initWithManagedObjectContext:managedObjectStore.persistentStoreManagedObjectContext];
}
@end
