///|
fn solution(u : Array[Int]) -> Int {
  loop @int.max_value, 0, u[:] {
    _, minn, [] => break u.length() - minn
    minv, minn, [v, .. t] => {
      if v < minv {
        continue v, 1, t
      }
      if v == minv {
        continue minv, minn + 1, t
      }
      continue minv, minn, t
    }
  }
}

test {
  inspect!(solution([1, 2, 3, 1, 2]), content="3")
  inspect!(solution([100000, 100000, 100000, 100000]), content="0")
  inspect!(solution([1, 1, 1, 2, 2, 2]), content="3")
}
