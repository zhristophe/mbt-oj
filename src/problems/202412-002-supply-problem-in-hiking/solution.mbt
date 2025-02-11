///|
fn solution(k : Int, data : Array[Int]) -> Int {
  let n = data.length()
  let k = k - 1
  let f = []
  for i in 0..<n {
    let n = []
    for j in 0..=k {
      n.push(@int.max_value)
    }
    f.push(n)
  }
  for j in 0..=k {
    f[0][j] = data[0] * (j + 1)
  }
  for i in 1..<n {
    for j in 0..=k {
      for j0 in 0..=@math.minimum(k, j + 1) {
        let cost = f[i - 1][j0] + data[i] * (j - j0 + 1)
        f[i][j] = @math.minimum(f[i][j], cost)
      }
    }
  }
  // println(f)
  f[n - 1][0]
}

test {
  inspect!(solution(2, [1, 2, 3, 3, 2]), content="9")
  inspect!(solution(3, [4, 1, 5, 2, 1, 3]), content="9")
  inspect!(solution(1, [3, 2, 4, 1]), content="10")
  inspect!(solution(1, [5, 3, 2, 4, 1]), content="15")
}
