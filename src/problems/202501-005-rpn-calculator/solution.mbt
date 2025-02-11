///|
fn solution(s : String) -> UInt {
  loop [], s[:] {
    stack, prog => {
      if prog.length() == 0 {
        break stack[0]
      }
      match prog[0] {
        ' ' => continue stack, prog[1:]
        '*' => stack.push(stack.pop().unwrap() * stack.pop().unwrap())
        '+' => stack.push(stack.pop().unwrap() + stack.pop().unwrap())
        '-' => stack.push(0U - stack.pop().unwrap() + stack.pop().unwrap())
        _ => stack.push(prog[0].to_uint() - '0'.to_uint())
      }
      continue stack, prog[1:]
    }
  }
}

test {
  inspect!(solution("2 2 +"), content="4")
  inspect!(solution("0 1 -"), content="4294967295")
  inspect!(solution("2 4 + 3 *"), content="18")
  inspect!(solution("  3    8 * 2  +"), content="26")
  inspect!(solution("  3    8 * 2  +  1  -"), content="25")
}
