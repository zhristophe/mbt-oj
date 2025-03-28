///| 即k(1+...+n)
fn solution(n : Int, k : Int) -> Int {
  let n = n.to_uint64()
  let k = k.to_uint64()
  let res = n * (n + 1) / 2 * k
  res.to_int()
}

///|
test {
  inspect!(solution(3, 1), content="6")
  inspect!(solution(2, 2), content="6")
  inspect!(solution(4, 3), content="30")
}
