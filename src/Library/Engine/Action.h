/*
 *  Action.h
 *  ARBUTUS
 *
 *  Created by Daniel Almeida on 1/2/11.
 *  Copyright 2011 __MyCompanyName__. All rights reserved.
 *
 */

#ifndef Action_h
#define Action_h

#include <stdio.h>


typedef enum
{
    TriggerVisual = 0,
    ChangeLayer,
    ChangeParameter
} ActionType;


class TriggerVisualAction {
    int layer, column;
    
public:
    TriggerVisualAction(int _layer, int _column);
    bool run();
};



class ChangeLayerAction {
    int layer;
    
public:
    ChangeLayerAction(int _layer);
    bool run();
};


/*!
 
 */
class Action {
    ActionType type;
    TriggerVisualAction *triggerVisualAction;
    ChangeLayerAction   *changeLayerAction;
public:
    
    // constructors
    Action(ActionType _type);
    static Action *newTriggerVisualAction(int _layer, int _column);
    static Action *newChangeLayerAction(int _layer);
    
    bool run();
    
    // setters
    void setTriggerVisualAction(TriggerVisualAction *action);
    void setChangeLayerAction(ChangeLayerAction *action);
    
    
};
#endif /* Action_h */
