//
//  Preset+CoreDataProperties.m
//  
//
//  Created by Cuong on 11/4/16.
//
//

#import "Preset+CoreDataProperties.h"

@implementation Preset (CoreDataProperties)

+ (NSFetchRequest *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Preset"];
}

@dynamic friday;
@dynamic monday;
@dynamic presetName;
@dynamic reminderTime;
@dynamic restTime;
@dynamic saturday;
@dynamic sunday;
@dynamic thursday;
@dynamic tuesday;
@dynamic wednesday;
@dynamic blocks;


@end
