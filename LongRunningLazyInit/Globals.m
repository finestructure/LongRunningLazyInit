//
//  Globals.m
//  LongRunningLazyInit
//
//  Created by Sven A. Schmidt on 12.03.12.
//  Copyright (c) 2012 abstracture GmbH & Co. KG. All rights reserved.
//

#import "Globals.h"


@interface Globals () {
  dispatch_queue_t valuesSerialQueue;
}

@property (strong) NSMutableDictionary *values;

@end


@implementation Globals

@synthesize values;

+ (id)shared {
  static dispatch_once_t onceQueue;
  static Globals *globals = nil;
  
  dispatch_once(&onceQueue, ^{ globals = [[self alloc] init]; });
  return globals;
}


- (NSString *)slowInitForKey:(NSString *)key {
  sleep(5);
  return [NSString stringWithFormat:@"value for key: %@", key];
}


- (id)init {
  self = [super init];
  if (self) {
    valuesSerialQueue = dispatch_queue_create("de.abstracture.valuesSerialQueue", NULL);
    self.values = [NSMutableDictionary dictionary];

    [[NSArray arrayWithObjects:
      @"A", @"B", @"C", @"D", nil]
     enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
       dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
         NSString *value = [self slowInitForKey:obj];
         dispatch_async(valuesSerialQueue, ^{
           [self.values setObject:value forKey:obj];
         });
       });
     }];
  }
  return self;
}


- (void)dealloc {
  dispatch_release(valuesSerialQueue);
}


- (NSString *)valueForKey:(NSString *)key {
  __block NSString *result = nil;
  
  dispatch_sync(valuesSerialQueue, ^{
    result = [self.values objectForKey:key];
  });
  
  while (result == nil) {
    // keep polling until there's a value
    dispatch_sync(valuesSerialQueue, ^{
      result = [self.values objectForKey:key];
    });
  }
  return result;
}



@end
