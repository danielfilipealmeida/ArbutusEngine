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


class Utils {
    
public:
    static std::string
    md5(std::string message);
};


constexpr unsigned int str2int(const char* str, int h = 0)
{
    return !str[h] ? 5381 : (str2int(str, h+1) * 33) ^ str[h];
}

float roundWithPrecision(float input, int precision);


#endif /* Utils_h */
