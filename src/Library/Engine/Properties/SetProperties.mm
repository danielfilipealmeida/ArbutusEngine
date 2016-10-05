//
//  SetProperties.cpp
//  Arbutus
//
//  Created by Daniel Almeida on 12/01/16.
//
//

#include "SetProperties.h"






SetProperties::SetProperties() {
    stopCurrentVisualIfTriggeredInvalid = true;
}



void SetProperties::setStopCurrentVisualIfTriggeredInvalid(bool val) {
    stopCurrentVisualIfTriggeredInvalid = val;
}



bool SetProperties::getStopCurrentVisualIfTriggeredInvalid() {
    return stopCurrentVisualIfTriggeredInvalid;
}