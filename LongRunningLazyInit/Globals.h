//
//  Globals.h
//  LongRunningLazyInit
//
//  Created by Sven A. Schmidt on 12.03.12.
//  Copyright (c) 2012 abstracture GmbH & Co. KG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Globals : NSObject

+ (id)shared;

- (NSString *)valueForKey:(NSString *)key;

@end
