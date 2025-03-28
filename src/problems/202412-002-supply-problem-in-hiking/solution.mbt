///| 动态规划
///  注意先买再吃，此处记录每天吃前的数量
fn solution(k : Int, data : Array[Int]) -> Int {
  let n = data.length()
  let f = Array::makei(n, fn { _ => Array::make(k + 1, @int.max_value) })
  for i in 1..=k {
    f[0][i] = data[0] * i
  }
  for i in 1..<n {
    for j in 1..=k {
      for j0 in 1..=@math.minimum(k, j + 1) {
        let cost = f[i - 1][j0] + data[i] * (j - j0 + 1) // 昨天吃掉1个
        f[i][j] = @math.minimum(f[i][j], cost)
      }
    }
  }
  f[n - 1][1]
}

///|
test {
  let res = solution(5, [1, 2, 3, 4, 5])
  println(res)
}

///|
test {
  inspect!(solution(2, [1, 2, 3, 3, 2]), content="9")
  inspect!(solution(3, [4, 1, 5, 2, 1, 3]), content="9")
  inspect!(solution(1, [3, 2, 4, 1]), content="10")
  inspect!(solution(1, [5, 3, 2, 4, 1]), content="15")
}
