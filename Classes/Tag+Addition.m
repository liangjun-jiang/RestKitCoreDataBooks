//
//  Tag+Addition.m
//  CoreDataBooks
//
//  Created by Liangjun Jiang on 4/20/14.
//
//

#import "Tag+Addition.h"

@implementation Tag (Addition)
+(NSArray *)arrayForResponseMapping
{
    return @[@"name",@"objectId",@"createdAt",@"updatedAt",@"book"];
}
@end
