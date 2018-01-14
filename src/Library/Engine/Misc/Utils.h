//
//  Utils.h
//  ArbutusEngine
//
//  Created by Daniel Almeida on 24/03/17.
//
//

#ifndef Utils_h
#define Utils_h

#include <string>

typedef enum StateType {
    StateType_Invalid = 0,
    StateType_Integer,
    StateType_Float,
    StateType_String,
    StateType_ButtonGroup,
    StateType_ToggleButtonGroup
    
};

class Utils {
    
public:
    
    /*!
     \brief Calculate the md5 of a given message.
     \params message the message to encode
     \returns a string with the md5 of the given message
     */
    static std::string md5(std::string message);
    
    /*!
     \brief Returns the StateType associated with a given
     
     \param typeidName the dynamic type name of the variable, retrieved using `typeid(<var>).name()`
     \returns the StateType
     */
    static StateType getStateTypeForTypeidName(std::string typeidName);
};


constexpr unsigned int str2int(const char* str, int h = 0)
{
    return !str[h] ? 5381 : (str2int(str, h+1) * 33) ^ str[h];
}

float roundWithPrecision(float input, int precision);


#endif /* Utils_h */
