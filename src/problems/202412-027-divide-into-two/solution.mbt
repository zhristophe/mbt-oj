///|
fn solution(a : Int, b : Int, arr : Array[Int]) -> Int {
  let mut res = 0
  // 一个数组空
  let sum = arr.fold(init=0, fn { acc, v => acc + v })
  let fd = first_digit(sum)
  if fd == a || fd == b {
    res += 1
  }
  // 幂集遍历
  for i in 1..<((1 << arr.length()) - 1) {
    let sum1 = arr.foldi(init=0, fn {
      idx, sum, v => if ((1 << idx) & i) != 0 { sum + v } else { sum }
    })
    let sum2 = sum - sum1
    if (a, b) == (first_digit(sum1), first_digit(sum2)) {
      res += 1
    }
  }
  res
}

///|
fn first_digit(a : Int) -> Int {
  "\{a}"[0].to_int() - '0'.to_int()
}

test {
  inspect!(solution(1, 2, [1, 1, 1]), content="3")
  inspect!(solution(3, 5, [1, 1, 1]), content="1")
  inspect!(solution(1, 1, [1, 1]), content="2")
}
