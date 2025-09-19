#include <flutter/method_call.h>
#include <flutter/method_result_functions.h>
#include <flutter/standard_method_codec.h>
#include <gtest/gtest.h>
#include <windows.h>

#include <memory>
#include <string>
#include <variant>

#include "../flutter_freedome_plugin.h"

namespace flutter_freedome {
namespace test {

namespace {

class MockMethodResult : public flutter::MethodResult<flutter::EncodableValue> {
 public:
  MOCK_METHOD1(SuccessInternal, void(const flutter::EncodableValue* result));
  MOCK_METHOD3(ErrorInternal, void(const std::string& error_code,
                                   const std::string& error_message,
                                   const flutter::EncodableValue* details));
  MOCK_METHOD0(NotImplementedInternal, void());
};

}  // namespace

TEST(FlutterFreedomePluginTest, GetPlatformVersion) {
  FlutterFreedomePlugin plugin;
  MockMethodResult result;
  flutter::MethodCall<flutter::EncodableValue> method_call(
      "getPlatformVersion", std::make_unique<flutter::EncodableValue>());

  EXPECT_CALL(result, SuccessInternal(testing::_));

  plugin.HandleMethodCall(method_call,
                          std::make_unique<MockMethodResult>(std::move(result)));
}

}  // namespace test
}  // namespace flutter_freedome
