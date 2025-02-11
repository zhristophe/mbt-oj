///|
fn solution(arr : Array[Int], k : Int) -> Array[Int] {
  let res = []
  for i in 0..<(arr.length() - k + 1) {
    res.push(
      arr[i:i + k].fold(init=0, fn {
        acc, v => @math.maximum(acc, v)
      }),
    )
  }
  res
}

test {
  inspect!(
    solution([77, 63, 47, 62, 3, 28, 61, 27, 85, 519], 1),
    content="[77, 63, 47, 62, 3, 28, 61, 27, 85, 519]",
  )
  inspect!(
    solution([77, 63, 47, 62, 3, 28, 61, 27, 85, 519], 2),
    content="[77, 63, 62, 62, 28, 61, 61, 85, 519]",
  )
  inspect!(
    solution([77, 63, 47, 62, 3, 28, 61, 27, 85, 519], 9),
    content="[85, 519]",
  )
  inspect!(
    solution([77, 63, 47, 62, 3, 28, 61, 27, 85, 519], 10),
    content="[519]",
  )
}
