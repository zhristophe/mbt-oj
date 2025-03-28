///|
fn solution(a : Int, b : Int, arr : Array[Int]) -> Int {
  let mut res = 0
  let (a, b) = (a.to_uint64(), b.to_uint64())
  let sum : UInt64 = arr.fold(init=0, fn { acc, v => acc + v.to_uint64() })
  // 一个数组空
  let fd = first_digit(sum)
  res += (fd == a).to_int()
  res += (fd == b).to_int()
  println(res)
  // 幂集遍历
  for i in 1U..<((1U << arr.length()) - 1) {
    let sum1 : UInt64 = arr.foldi(init=0, fn {
      idx, acc, v =>
        if ((1U << idx) & i) != 0 {
          acc + v.to_uint64()
        } else {
          acc
        }
    })
    let sum2 = sum - sum1
    // println("sum1:\{sum1}, sum2:\{sum2}")
    if (a, b) == (first_digit(sum1), first_digit(sum2)) {
      println("sum1:\{sum1}, sum2:\{sum2}")
      res += 1
    }
  }
  res
}

///|
fn first_digit(a : UInt64) -> UInt64 {
  ("\{a}"[0].to_int() - '0'.to_int()).to_uint64()
}

///|
test {
  inspect!(solution(1, 2, [1, 1, 1]), content="3")
  inspect!(solution(3, 5, [1, 1, 1]), content="1")
  inspect!(solution(1, 1, [1, 1]), content="2")
}
