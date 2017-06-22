//
//  main.cpp
//  catch
//
//  Created by Daniel Almeida on 10/03/17.
//
//

#define CATCH_CONFIG_RUNNER
//#define CATCH_CONFIG_MAIN  // This tells Catch to provide a main() - only do this in one cpp file
#include "catch.hpp"

#include "ofMain.h"
#include "ofApp.h"


/*

unsigned int Factorial( unsigned int number ) {
    return number <= 1 ? number : Factorial(number-1)*number;
}

TEST_CASE( "Factorials are computed", "[factorial]" ) {
    REQUIRE( Factorial(1) == 1 );
    REQUIRE( Factorial(2) == 2 );
    REQUIRE( Factorial(3) == 6 );
    REQUIRE( Factorial(10) == 3628800 );
}
 */


int main( int argc, char* argv[] )
{
    // global setup...
    
    ofSetupOpenGL(1024,768, OF_WINDOW);
    //ofRunApp( new ofApp());

    
    
    int result = Catch::Session().run( argc, argv );
    
    // global clean-up...
    
    return ( result < 0xff ? result : 0xff );
}
