///| 淘汰一个人后，转变成 n-1 个人的子问题
fn solution(n : Int, q : Int) -> Int {
  fn _f(n : Int, q : Int) -> Int {
    if n == 1 {
      return 0
    }
    let k = _f(n - 1, q)
    return (k + q) % n
  }

  return _f(n, q) + 1
}

///|
test {
  inspect!(solution(10, 2), content="5")
  inspect!(solution(10, 3), content="4")
  inspect!(solution(3, 2), content="3")
}
