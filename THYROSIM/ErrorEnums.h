//
//  ErrorEnums.h
//  THYROSIM
//
//  Created by William Gu on 1/14/15.
//  Copyright (c) 2015 William Gu. All rights reserved.
//

#ifndef THYROSIM_ErrorEnums_h
#define THYROSIM_ErrorEnums_h



enum errorEnums {
    PAGE_ONE_T4S_ERROR = -5,
    PAGE_ONE_T4A_ERROR = -4,
    PAGE_ONE_T3S_ERROR = -3,
    PAGE_ONE_T3A_ERROR = -2,
    PAGE_ONE_SIMULDAYS_ERROR = -1,
    PAGE_ONE_GOOD = 0,
    PAGE_TWO_GOOD = 1,
    PAGE_TWO_INFUSION_GOOD = 2,
    PAGE_TWO_DOSING_GOOD = 3,
    PAGE_TWO_TIME_ERROR = 4,
    PAGE_TWO_DOSING_INTERVAL_ERROR = 5,
    ALL_GOOD_PROCEED = 69,
    

    
};
typedef int errorEnums;

#endif
