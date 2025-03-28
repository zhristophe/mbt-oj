///|
fn solution(s : String) -> UInt {
  let stack : Array[UInt] = []
  let pop = fn() { stack.pop().unwrap() }
  s
  .split(" ")
  .filter(fn { x => x != "" })
  .each(fn {
    "*" => stack.push(pop() * pop())
    "+" => stack.push(pop() + pop())
    "-" => stack.push(0U - pop() + pop())
    n =>
      stack.push(
        try {
          @strconv.parse_uint!(n)
        } catch {
          _ => panic()
        },
      )
  })
  pop()
}


///|
test {
  inspect!(solution("2 2 +"), content="4")
  inspect!(solution("0 1 -"), content="4294967295")
  inspect!(solution("2 4 + 3 *"), content="18")
  inspect!(solution("  3    8 * 2  +"), content="26")
  inspect!(solution("  3    8 * 2  +  1  -"), content="25")
  inspect!(solution("0 1 - 2 *"), content="4294967294")
}
