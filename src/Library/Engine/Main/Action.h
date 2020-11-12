/*
 *  Action.h
 *  ARBUTUS
 *
 *  Created by Daniel Almeida on 1/2/11.
 *  Copyright 2011 __MyCompanyName__. All rights reserved.
 *
 * TODO:
 *  - create an action protocol
 *  - Have TriggerVisual and ChangeLayer Actions inheriting from the action protocol
 *  - Find where these classes are used and update
 */

#ifndef Action_h
#define Action_h

#include <stdio.h>


/*!
 */
typedef enum
{
    TriggerVisual = 0,
    ChangeLayer,
    ChangeParameter
} ActionType;



/*!
 @class TriggerVisualAction
 @abstract
 @discussion
 */
class TriggerVisualAction {
    int layer, column;
    
public:
    TriggerVisualAction(int _layer, int _column);
    bool run();
};


/*!
 @class ChangeLayerAction
 @abstract
 @discussion
 */
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
    
    /*!
     */
    Action(ActionType _type);

    /*!
     @function newTriggerVisualAction
     @abstract create a new Trigger Visual Action at a given layer/column
     @param _layer the number of the layer
     @param _column the number of the column
     @return a new Action object
     */
    static Action* newTriggerVisualAction(int _layer, int _column);
    
    /*!
     @function newChangeLayerAction
     @abstract Creates a new ChangeLayer Action
     @param _layer the index of the layer
     @return a new Action object
     */
    static Action* newChangeLayerAction(int _layer);
    
    /*!
     @function run
     @abstract Execute a function
     */
    bool run();
    
    /*!
     @function setTriggerVisualAction
     @abstract Sets the TriggerVisualAction object
     @param action  TriggerVisualAction object
     */
    void setTriggerVisualAction(TriggerVisualAction *action);
    
    /*!
     @function setChangeLayerAction
     @abstract sets the ChangeLayerAction object
     @param action ChangeLayerAction object
     */
    void setChangeLayerAction(ChangeLayerAction *action);
};
#endif /* Action_h */
