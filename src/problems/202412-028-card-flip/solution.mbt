///|
fn solution(front : Array[Int], back : Array[Int]) -> Int {
  loop [1, 0, 0], front[:], back[:] {
    res, [], _ => break res[0]
    res, _, [] => break res[0]
    // oj不支持该语法
    res, [a, .. ta], [b, .. tb] => {
      let new_res = [0, 0, 0]
      for i in [a, b] {
        for j in 0..<3 {
          new_res[j] += res[(j + i) % 3]
        }
      }
      continue new_res, ta, tb
    }
  }
}

test {
  inspect!(solution([1, 2, 3], [2, 3, 2]), content="3")
  inspect!(solution([3, 1, 2, 4], [1, 2, 3, 1]), content="6")
  inspect!(solution([1, 2, 3, 4, 5], [1, 2, 3, 4, 5]), content="32")
}
