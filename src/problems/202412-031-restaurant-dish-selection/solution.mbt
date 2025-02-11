///|
fn solution(s : String, a : Array[Int], m : Int, k : Int) -> Int {
  let a = a.mapi(fn { idx, v => (v, idx) })
  a.sort_by_key(fn { p => p.0 })
  let mut res = 0
  loop a[:], m, k {
    [], _, _ => return -1
    [dish, .. a], m, k => {
      let s_i = s[dish.1]
      if m == 0 && s_i == '1' {
        continue a, m, k
      }
      res += dish.0
      if k == 1 {
        return res
      }
      continue a, if s_i == '1' { m - 1 } else { m }, k - 1
    }
  }
}

test {
  inspect!(solution("001", [10, 20, 30], 1, 2), content="30")
  inspect!(solution("111", [10, 20, 30], 1, 2), content="-1")
  inspect!(solution("0101", [5, 15, 10, 20], 2, 3), content="30")
}
