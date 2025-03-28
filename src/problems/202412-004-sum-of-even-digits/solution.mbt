///| dp
fn solution(numbers : Array[String]) -> Int {
  let count_digits = fn(s : String) -> Array[Int] {
    let cnt = [0, 0]
    for n in s {
      cnt[n.to_int() % 2] += 1
    }
    cnt
  }
  let mut res = [1, 0]
  for s in numbers {
    let cnt = count_digits(s)
    let res_0 = res[0] * cnt[0] + res[1] * cnt[1]
    let res_1 = res[1] * cnt[0] + res[0] * cnt[1]
    res = [res_0, res_1]
  }
  res[0]
}

///|
test {
  inspect!(solution(["123", "456", "789"]), content="14")
  inspect!(solution(["123456789"]), content="4")
  inspect!(solution(["14329", "7568"]), content="10")
}
