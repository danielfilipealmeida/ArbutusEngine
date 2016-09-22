/*
 *  ArbutusLib.cpp
 *  ArbutusLib
 *
 *  Created by Daniel Almeida on 25/07/16.
 *
 *
 */

#include <iostream>
#include "ArbutusLib.hpp"
#include "ArbutusLibPriv.hpp"

void ArbutusLib::HelloWorld(const char * s)
{
	 ArbutusLibPriv *theObj = new ArbutusLibPriv;
	 theObj->HelloWorldPriv(s);
	 delete theObj;
};

void ArbutusLibPriv::HelloWorldPriv(const char * s) 
{
	std::cout << s << std::endl;
};

