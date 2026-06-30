import gleam/json
import startest.{default_config, describe, it, run}
import startest/expect
import windsock

pub fn main() {
  run(default_config())
}

pub fn frame_tests() {
  describe("windsock", [
    it("encodes an event with positional args", fn() {
      windsock.encode("op", [json.string("c1"), json.int(7)])
      |> expect.to_equal("42[\"op\",\"c1\",7]")
    }),
    it("encodes an event with no args", fn() {
      windsock.encode("nack", [])
      |> expect.to_equal("42[\"nack\"]")
    }),
    it("decodes an event frame", fn() {
      let assert Ok(incoming) = windsock.decode("42[\"op\",\"c1\"]")
      incoming.event |> expect.to_equal("op")
    }),
    it("rejects non-event packets", fn() {
      windsock.decode("40")
      |> expect.to_be_error
      Nil
    }),
  ])
}
