
let alignment = MemoryLayout<Int8>.alignment
let stride = MemoryLayout<Int8>.stride
let size = MemoryLayout<Int8>.size


do {
  print("raw pointer")
  // alignment = 1, 2 |0|1| 申请内存空间
  let pointer = UnsafeMutableRawPointer.allocate(byteCount: 2, alignment: 1)
  defer {
    // 结束时，释放内存
    pointer.deallocate()
  }
  
  pointer.storeBytes(of: 1, as: UInt8.self)
  pointer.advanced(by: stride).storeBytes(of: 2, as: UInt8.self)
  
  pointer.load(fromByteOffset: 0, as: UInt8.self)
  pointer.advanced(by: stride).load(as: UInt8.self)
  
  let bufferPointer = UnsafeRawBufferPointer(start: pointer, count: 2)
  for (index, byte) in bufferPointer.enumerated() {
    print("\(index), \(byte)")
  }
}

do {
  print("typed pointer: Int8")
  let count = 4
  let pointer = UnsafeMutablePointer<Int8>.allocate(capacity: count)
  // must initialize
  pointer.initialize(repeating: 0, count: count)
  defer {
    
    pointer.deinitialize(count: count)
    pointer.deallocate()
  }
  
  pointer.pointee = 10
  pointer.advanced(by: 1).pointee = 11
  pointer.advanced(by: 2).pointee = 12
  pointer.advanced(by: 3).pointee = 13

  let bufferPointer = UnsafeBufferPointer(start: pointer, count: count)
  for (index, byte) in bufferPointer.enumerated() {
    print("\(index), \(byte)")
  }
}
