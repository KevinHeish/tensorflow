// RUN: tf-mlir-translate -mlir-tf-to-hlo-text %s -tf-input-shapes=: -emit-use-tuple-args -emit-return-tuple | FileCheck %s

module attributes {tf.versions = {producer = 179 : i32}} {
  func @main() -> (tensor<0xi32>, tensor<0xi32>) {
    %0 = "tf.Const"() {value = dense<[]> : tensor<0xi32>} : () -> tensor<0xi32>
    %r0, %r1 = "tf.BroadcastGradientArgs"(%0, %0) {T = i32} : (tensor<0xi32>, tensor<0xi32>) -> (tensor<0xi32>, tensor<0xi32>)
    return %r0, %r1 : tensor<0xi32>, tensor<0xi32>
  }
}

// CHECK-LABEL: HloModule main
// CHECK:       ENTRY %main.{{[0-9+]}} ([[ARG_TUPLE:.*]]: ()) -> (s32[0], s32[0]) {
// CHECK:         %[[ARG_TUPLE]] = () parameter(0)
// CHECK:         [[CONSTANT:%.*]] = s32[0]{0} constant({})
// CHECK:         ROOT %tuple.{{[0-9]+}} = (s32[0]{0}, s32[0]{0}) tuple(s32[0]{0} [[CONSTANT]], s32[0]{0} [[CONSTANT]])
// CHECK:       }
