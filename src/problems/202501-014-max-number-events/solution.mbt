///|
fn max_value(evts : Array[(Int, Int, Int)], n : Int) -> Int {
  let max_day = evts.fold(init=0, fn { acc, d => @math.maximum(acc, d.1) })
  let f = []
  for _ in 0..=max_day {
    let tmp = []
    for _ in 0..=n {
      tmp.push(0)
    }
    f.push(tmp)
  }
  for day in 1..=max_day {
    for n in 1..=n {
      for evt in evts {
        if evt.1 <= day {
          f[day][n] = @math.maximum(f[day][n], evt.2 + f[evt.0 - 1][n - 1])
        }
      }
    }
  }
  f[max_day][n]
}

test {
  inspect!(max_value([(1, 2, 4), (3, 4, 3), (2, 3, 1)], 2), content="7")
  inspect!(max_value([(1, 2, 4), (3, 4, 3), (2, 3, 10)], 2), content="10")
  inspect!(
    max_value([(1, 1, 1), (2, 2, 2), (3, 3, 3), (4, 4, 4)], 3),
    content="9",
  )
}
