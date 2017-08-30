//
//  UtilsTests.cpp
//  ArbutusEngine
//
//  Created by Daniel Almeida on 24/08/17.
//
//

#include <stdio.h>
#include "catch.hpp"
#include "Utils.h"

TEST_CASE("Floats are wrong with given precision", "[roundWithPrecision]") {

    REQUIRE(roundWithPrecision(0.06, 1) == 0.1f);
    REQUIRE(roundWithPrecision(0.006, 2) == 0.01f);
    REQUIRE(roundWithPrecision(0.04, 1) == 0.0f);
    REQUIRE(roundWithPrecision(0.004, 2) == 0.00f);
}
