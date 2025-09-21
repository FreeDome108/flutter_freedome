#include <flutter_linux/flutter_linux.h>
#include <gmock/gmock.h>
#include <gtest/gtest.h>

#include "flutter_freedome_plugin_private.h"

// This demonstrates a simple unit test of the C portion of this plugin's
// implementation.
//
// Once you have built the plugin's example app, you can run these tests
// from the command line. For instance, if you built for x64 debug, run:
// $ build/linux/x64/debug/unit_tests
// To run the tests from an IDE, add the following lines to your IDE's
// configuration for the unit tests:
// --gtest_filter=<test_name>
// --gtest_repeat=<number_of_iterations>

namespace flutter_freedome_plugin {
namespace test {

TEST(FlutterFreedomePluginTest, GetPlatformVersion) {
  g_autoptr(FlMethodResponse) response = get_platform_version();
  EXPECT_NE(response, nullptr);
  EXPECT_TRUE(FL_IS_METHOD_SUCCESS_RESPONSE(response));
  FlValue* result = fl_method_success_response_get_result(
      FL_METHOD_SUCCESS_RESPONSE(response));
  EXPECT_EQ(fl_value_get_type(result), FL_VALUE_TYPE_STRING);
  // The full string varies by host, so just validate it starts with "Linux".
  EXPECT_TRUE(g_str_has_prefix(fl_value_get_string(result), "Linux"));
}

}  // namespace test
}  // namespace flutter_freedome_plugin


