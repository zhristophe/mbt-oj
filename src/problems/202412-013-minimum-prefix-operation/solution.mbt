///|
fn solution(s : String, t : String) -> Int {
  let mut res = s.length()
  loop 0, 0 {
    diff, idx => {
      res = @math.minimum(res, diff + s.length() - idx)
      if idx == s.length() || idx == t.length() {
        break
      }
      continue if s[idx] == t[idx] { diff } else { diff + 1 }, idx + 1
    }
  }
  res
}

test {
  inspect!(solution("aba", "abb"), content="1")
  inspect!(solution("abcd", "efg"), content="4")
  inspect!(solution("xyz", "xy"), content="1")
  inspect!(solution("hello", "helloworld"), content="0")
  inspect!(solution("same", "same"), content="0")
}
