//
//  TCPlacesService.h
//  TCGoogleMaps
//
//  Created by Lee Tze Cheun on 9/3/13.
//  Copyright (c) 2013 Lee Tze Cheun. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TCPlacesServiceBlocks.h"

@class TCPlacesAutocompleteParameters;

/**
 * Provides methods to access the Google Places API.
 */
@interface TCPlacesService : NSObject

/**
 * Returns a shared `TCPlacesService` instance to access Google Placess API.
 */
+ (TCPlacesService *)sharedService;

/**
 * Sets the API key and sensor parameter for all requests to Google Places API.
 * This should be called exactly once by your application, e.g., 
 * in application: didFinishLaunchingWithOptions:
 *
 * @param APIKey your application's API key 
 * @param sensor indicates whether the request came from a device using
 *               a location sensor (e.g. a GPS)
 */
+ (void)setAPIKey:(NSString *)APIKey sensor:(BOOL)sensor;

/**
 * Retrieves place autocomplete predictions based on the supplied 
 * autocomplete request parameters.
 *
 * @param parameters the autocomplete request parameters. Cannot be nil.
 * @param completion the block to execute when autocomplete prediction results are returned
 */
- (void)placePredictionsWithParameters:(TCPlacesAutocompleteParameters *)parameters completion:(TCPlacesAutocompleteServiceCallback)completion;

/**
 * Retrieves details about the place identified by the given reference.
 *
 * @param reference  the place reference string
 * @param completion the block to execute when place detais are returned
 */
- (void)placeDetailsWithReference:(NSString *)reference completion:(TCPlaceDetailsServiceCallback)completion;

@end
