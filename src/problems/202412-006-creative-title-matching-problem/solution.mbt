///|
fn solution(template : String, titles : Array[String]) -> Array[Bool] {
  let res = []
  for title in titles {
    res.push(able(template.to_array()[:], title.to_array()[:]))
  }
  res
}

///|
fn able(template : ArrayView[Char], title : ArrayView[Char]) -> Bool {
  if template.length() == 0 {
    return title.length() == 0
  }
  // 如果以通配符开始，枚举所有通配情形
  let mut in_temp = false
  let mut template = template
  while template[0] == '{' {
    in_temp = true
    template = loop template {
      [] => panic()
      t => {
        if t[0] == '}' {
          break t[1:]
        }
        continue t[1:]
      }
    }
    if template.length() == 0 {
      return true
    }
  }
  if title.length() == 0 {
    return false
  }
  if in_temp {
    loop title {
      [] => return false
      t => {
        if able(template, t) {
          return true
        }
        continue t[1:]
      }
    }
  }
  if template[0] != title[0] {
    return false
  }
  return able(template[1:], title[1:])
}

test {
  inspect!(solution("{}", ["foo", "bar", "baz"]), content="[true, true, true]")
  inspect!(
    solution("f{}o", ["foo", "bar", "baz"]),
    content="[true, false, false]",
  )
  inspect!(
    solution("ad{xyz}cdc{y}f{x}e", [
      "adcdcefdfeffe", "adcdcefdfeff", "dcdcefdfeffe", "adcdcfe",
    ]),
    content="[true, false, false, true]",
  )
  inspect!(
    solution("{xxx}h{cQ}N{vF}u{XTA}S{NTA}MLCq{yyy}", [
      "CLSomGhcQNvFuzENTAMLCqxBdj", "CLSomNvFuXTASzENTAMLCqxBdj", "CLSomFuXTASzExBdj",
      "CLSoQNvFuMLCqxBdj", "SovFuXTASzENTAMLCq", "mGhcQNvFuXTASzENTAMLCqx",
    ]),
    content="[false, false, false, false, false, true]",
  )
  inspect!(
    solution("a{bdc}efg", ["abcdefg", "abefg", "efg"]),
    content="[true, true, false]",
  )
}
