//
//  Utils.h
//  ArbutusEngine
//
//  Created by Daniel Almeida on 24/03/17.
//
//

#ifndef Utils_h
#define Utils_h


constexpr unsigned int str2int(const char* str, int h = 0)
{
    return !str[h] ? 5381 : (str2int(str, h+1) * 33) ^ str[h];
}


#endif /* Utils_h */
