//
//  Location.h
//  CodeStock
//
//  Created by Brice Wilson on 4/24/11.
//  Copyright 2011 Brice Wilson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>


@interface Location : NSObject <MKAnnotation>
{
}

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *subtitle;
@property (nonatomic, retain) NSString *category;
@property (nonatomic, assign) CLLocationDegrees latitude;
@property (nonatomic, assign) CLLocationDegrees longitude;

-(id)initWithTitle:(NSString *)pCity_Name 
		  subtitle:(NSString *)pState_ID 
		  category:(NSString *)pFacility_Name 
		  latitude:(CLLocationDegrees)pLatitude 
		 longitude:(CLLocationDegrees)pLongitude;

@end
