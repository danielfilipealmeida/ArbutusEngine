/*
 *  Action.mm
 *  ARBUTUS
 *
 *  Created by Daniel Almeida on 1/2/11.
 *  Copyright 2011 __MyCompanyName__. All rights reserved.
 *
 */

#include "Action.h"
#include "Engine.h"

extern Engine *_engine;

TriggerVisualAction::TriggerVisualAction(int _layer, int _column) {
    layer   = _layer;
    column  = _column;
}

bool TriggerVisualAction::run()  {
    if (_engine==NULL) return false;
    _engine->setActiveVisualInstanceNumberForLayer(column, layer);
    return true;
}


ChangeLayerAction::ChangeLayerAction(int _layer) {
    layer = _layer;
}

bool ChangeLayerAction::run() {
    if (_engine==NULL) return false;
    _engine->setActiveLayer(layer);
    return true;
}

Action::Action(ActionType _type) {
    type = _type;
    triggerVisualAction = NULL;
    changeLayerAction   = NULL;
};


Action* Action::newTriggerVisualAction(int _layer, int _column) {
    Action              *newAction;
    TriggerVisualAction *visualAction;
    
    newAction       = new Action(TriggerVisual);
    visualAction    = new TriggerVisualAction(_layer, _column);
    newAction->setTriggerVisualAction(visualAction);
    
    return newAction;
}


Action* Action::newChangeLayerAction(int _layer) {
    Action              *newAction;
    ChangeLayerAction   *layerAction;
    
    newAction       = new Action(ChangeLayer);
    layerAction     = new ChangeLayerAction(_layer);
    newAction->setChangeLayerAction(layerAction);
    
    return newAction;
   
}


bool Action::run() {
    if (type == TriggerVisual) return triggerVisualAction->run();
    if (type == ChangeLayer) return changeLayerAction->run();
    return false;
}


void Action::setTriggerVisualAction(TriggerVisualAction *action) {
    if (triggerVisualAction!=NULL) delete triggerVisualAction;
    triggerVisualAction = action;
}

void Action::setChangeLayerAction(ChangeLayerAction *action) {
    if (changeLayerAction!=NULL) delete changeLayerAction;
    changeLayerAction = action;
}
